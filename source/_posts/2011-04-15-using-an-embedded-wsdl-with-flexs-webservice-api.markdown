---
author: admin
date: '2011-04-15 07:42:53'
layout: post
slug: using-an-embedded-wsdl-with-flexs-webservice-api
status: publish
title: Using an Embedded WSDL with Flex's WebService API
wordpress_id: '2255'
categories:
- Flex
- SOAP
tags:
- flexorg
---

Recently I was helping a customer figure out how to use an embedded WSDL with
Flex's WebService API. One scenario in which this is needed is when the actual
WSDL is not available at runtime. In this case the application must contain
the WSDL instead of request it at runtime. The Flex WebService API today only
supports loading the WSDL over the network at runtime. Beginning in Flash
Builder 4 the Service wizard generate code that internally use the WebService
API. So no matter how you integrate with a SOAP Web Service in Flex, you need
the WSDL accessible via a URL at runtime. This wasn't possible for the
customer I was working with so we figured out a way to actually embed the WSDL
into the application. Here is what we did...

I used my [Census](http://www.jamesward.com/census2) SOAP Service as a simple
service to test this with. In this case, my WSDL is publicly available at: [ht
tp://www.jamesward.com/census2-tests/services/CensusSOAPService?wsdl](http://w
ww.jamesward.com/census2-tests/services/CensusSOAPService?wsdl)

First, I created a new Flex project and saved the WSDL into the src dir of the
project. I built a simple test program using the WebService API directly:

    
    
    
      
    	
    		
    	
    	
    	
    		ws.getElements(0, 50);
    	
    	
    	  
    
    

  
Then I ran the application in Chrome with the Network view open in the Chrome
Developer Tools panel. This indicated that, just as expected, the WSDL is used
at runtime:
![](http://www.jamesward.com/wp/uploads/2011/04/flex_wsdl_webservice.png)

Next I had a look around the _WebService_ source code (available in
<FLEX_SDK>/frameworks/projects/rpc/src/mx/rpc/soap) and discovered there is a
_loadWSDL_ method that can be overwritten to handle the embedded loading of
the WSDL instead of the default network loading of the WSDL. So I created a
new class that extends the base _WebService_ class, embeds the WSDL file, and
overrides the _loadWSDL_ method:

    
    
    package
    {
    	import mx.core.ByteArrayAsset;
    	import mx.core.mx_internal;
    	import mx.rpc.events.WSDLLoadEvent;
    	import mx.rpc.soap.mxml.WebService;
    	import mx.rpc.wsdl.WSDL;
    	
    	use namespace mx_internal;
    	
    	public dynamic class MyWebService extends WebService
    	{
    		[Embed(source="CensusSOAPService.xml", mimeType="application/octet-stream")]
    		private static const WSDL_CLASS:Class;  
    		public function MyWebService(destination:String=null)
    		{
    			super(destination);
    			loadWSDL();
    		}  
    		override public function loadWSDL(uri:String=null):void
    		{
    			var thing:Object = new WSDL_CLASS();
    			var baa:ByteArrayAsset = (thing as ByteArrayAsset);
    			var xml:String = baa.readUTFBytes(baa.length);
    			
    			deriveHTTPService();
    			
    			var wsdlLoadEvent:WSDLLoadEvent = WSDLLoadEvent.createEvent(new WSDL(new XML(xml)));
    			wsdlHandler(wsdlLoadEvent);
    		}
    	}
    }
    

  
In the regular _WebService_ class, setting the _wsdl_ property will trigger
the _loadWSDL_ method, but since we are embedding the WSDL, we must manually
call the _loadWSDL_ method. I do that in the constructor.

Embedded assets become a class, so first an instance of that class must be
instantiated as a _ByteArrayAsset_ (the default type for files embedded with
the application/octet-stream mimeType). Then the instance is read into a
string. Then the _deriveHTTPService_ method is called to set up the underlying
_HTTPService_'s channel information. Finally, we create a _WSDL_ object from
the _XML_ that was read from the _ByteArrayAsset_, create a new
_WSDLLoadEvent_ with the _WSDL_, and call the _wsdlHandler_ method, passing it
the _wsdlLoadEvent_. This essentially is doing the same thing as the original
_WebService_ class, but now doing it without the network request.

I can now switch my test application to use my extension to WebService instead
of the original one:

    
    
    	
    		
    	
    

  
Now when I run the application and monitor the network activity I no longer
see the WSDL being requested at runtime! So everything works when using the
_WebService_ API directly. However, the customer I was working with was using
the Service wizard in Flash Builder. So we needed to figure out how to get the
generated code to use the new _WebService_ extension instead of the original
_WebService_ class. I went through the Data Wizards and had it generate the
client-side stubs for my Census SOAP Service. This created a
_CensusSOAPService_ class that extends the generated
__Super_CensusSOAPService_ class. The _CensusSOAPService_ is intended to give
us a place to make modifications to the generated stuff, while the
__Super_CensusSOAPService_ class is not supposed to be modified because it
will be overwritten if we refresh the service. Looking in the
__Super_CensusSOAPService_ class I discovered that the _WebService_ instance
is being created directly in the constructor:

    
    
        public function _Super_CensusSOAPService()
        {
            // initialize service control
            _serviceControl = new mx.rpc.soap.mxml.WebService();  
            // rest of method omitted
        }
    

These are the kinds of things that really make you wish the Flex framework
used dependency injection because we need to set __serviceControl_ from the
_CensusSOAPService_ class. So we thought... Alright, this is not ideal but we
can just copy the contents of the __Super_CensusSOAPService_'s constructor
into _CensusSOAPService_'s constructor, replace the line that instantiates the
_WebService_, have it instantiate _MyWebService_ instead, and then just not
call _super()_. We gave it a try and for some reason kept getting
__serviceControl_ set as a _WebService_ not _MyWebService_. WTF? It made no
sense until we found this little gem in the [Flex
docs](http://help.adobe.com/en_US/flex/using
/WS2db454920e96a9e51e63e3d11c0bf67eed-7fff.html): _"If you define the
constructor, but omit the call to super(), Flex automatically calls super() at
the beginning of your constructor."_ Now it all made sense! Since we didn't
call _super()_, Flex conveniently inserted a _super()_ call for us! Fun. So we
had to figure out a way to convince the Flex compiler that we were going to
call _super()_, but then not call it.

    
    
    if (0)
    {
        super();
    }
    

Voila! Now the _CensusSOAPService_'s constructor sets __serviceControl_ to a
new instance of _MyWebService_ and __Super_CensusSOAPService_ doesn't get the
chance to mess that up.

We tested the new _CensusSOAPService_ and everything worked perfectly!

I hope that helps some of you who are using the Flex WebService API. Let me
know if you have any questions.

