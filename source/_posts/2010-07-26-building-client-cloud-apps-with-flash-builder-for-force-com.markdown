---
date: '2010-07-26 12:15:25'
layout: post
slug: building-client-cloud-apps-with-flash-builder-for-force-com
status: publish
title: Building Client / Cloud Apps with Flash Builder for Force.com
wordpress_id: '1894'
categories:
- Adobe AIR
- Cloud
- Flex
- Mobile
- Salesforce.com
---

I have a theory.  The majority of people who use enterprise software today use old school Client / Server apps.  We've been trying to move these apps to the web for more than ten years.  The ease of deployment of web apps is a clear motivator.  Yet the client capabilities of the plain old web browser have not been sufficient for many apps to make the leap.  This is why I love Flex and the Flash Platform.  It provides a way to use web technologies and the web deployment model but adds many of the critical things needed for mission critical apps that people use all day long.

But no one wants to go back to the Client / Server architecture.  We want to embrace Cloud Computing architectures but not lose the client capabilities.  What we really need is the Client / Cloud architecture.  We need a web deployment model that provides ease of deployment but also the ability to install applications on our desktops and mobile devices.

This is why I'm so excited about the new [Adobe Flash Builder for Force.com](http://developer.force.com/flashbuilder).  In a nutshell this is a tool that Adobe and Salesforce.com built together to enable developers to build great software using Flex for the UI and Force.com for the Cloud back-end.  It's a wonderful combination of technologies that will help many Client / Server apps make the switch to Client / Cloud.

Applications created with Flash Builder for Force.com can be run in the browser, on the desktop, and on mobile devices.  These applications can be assembled from the hundreds of Flex components that are out there (check out many of them in [Tour de Flex](http://flex.org/tour)).

Check out this video to see how to use Flash Builder for Force.com to build a simple app:

<object width="640" height="385"><param name="movie" value="http://images.tv.adobe.com/swf/player.swf"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><param name="FlashVars" value="fileID=7230&context=64&embeded=true&environment=production"></param><embed src="http://images.tv.adobe.com/swf/player.swf" flashvars="fileID=7230&context=64&embeded=true&environment=production" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="385"></embed></object>

As you can see, it's very easy to get started.  But I wanted to go a step further and try to build something real--something that shows a genuine use case for extending beyond the out-of-the-box Salesforce.com UI.  I wanted to keep it really simple so that I could post the code here.  What I came up with is this (in user story form):




  * As a Salesforce.com user I want to take a photo, using my phone, of one of my contacts so that the photo can be saved to their contact record for future reference.


  * As a Salesforce.com user I want to see photos I've taken of my contacts so that I can be reminded of what they look like.



Simple enough.  So here is what I came up with:

<object width="640" height="505"><param name="movie" value="http://www.youtube.com/v/RIUwh6wk8cY&amp;hl=en_US&amp;fs=1?rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/RIUwh6wk8cY&amp;hl=en_US&amp;fs=1?rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="505"></embed></object>

To build these two apps I first downloaded and installed [Flash Builder for Force.com](https://www.developerforce.com/events/flashbuilder/registration.php).  I used the [Adobe AIR for Android prerelease](http://www.adobe.com/go/airbetasignup) to build the mobile app.  Here is how I created these apps.

First I added a new field to Contact to store the photo.  Salesforce.com doesn't have a binary field so I used a large text field (32k limit).  I'll store the photo Base64 encoded.

Then in Salesforce.com I saved my enterprise.wsdl file. Check out a [great video from Dave Carroll](http://wiki.developerforce.com/index.php/Demo_Building_Desktop_Client_for_the_Cloud) to see how to do this.

Now in Flash Builder for Force.com I created a new Force.com Flex Project for the mobile app.  If you do this on your own and want to run on a mobile device then you will need to overlay the AIR for Android SDK on top of a Flex 4.1 SDK.  Select Desktop Application as the app type.  Replace WindowedApplication with just Application.  And replace the F3DesktopApplication with F3WebApplication since F3DesktopApplication uses APIs that are not available on AIR for Android.  (BTW: Flash Builder, Flex, and Force.com Flex Projects do not officially support mobile deployment yet.  It works but there is no support and no guarantees.)  If you are building a standard Web Application or Desktop Application then you can just leave the generated code as is.

Using the Data/Services wizard I connected to Salesforce.com using my enterprise.wsdl file.  After the services and value objects have been generated I modified the Contact object and added a Bindable account property.  The generated application already included the F3DesktopApplication Declaration used to connect to Salesforce.  Due to an incompatibility with that API and AIR for Android I switched it to use F3WebApplication.  In F3WebApplication's loginComplete event handler I query Salesforce.com for Accounts and then Contacts, associate contacts with their account, and then store the contacts:

```actionscript    
    app.wrapper.query("select Id, Name from Account", new AsyncResponder(function(data:ArrayCollection, token:Object):void {
        accounts = data;
        app.wrapper.query("select Id, AccountId, FirstName, LastName, Phone, MobilePhone, Email, Title, Department, MailingCity, photoData__c from Contact", new AsyncResponder(function(data:ArrayCollection, token:Object):void {
            for each (var contact:Contact in data)
            {
                for each (var account:Account in accounts)
                {
                    if (account.Id == contact.AccountId)
                    {
                        contact.account = account;						
                    }
                }
            }
            contacts = data;
        }, handleError));
    }, handleError));
```

Notice in the query that I'm fetching photoData__c, which is the custom field I created on Contact to store the photo.

In the renderer for a contact I need to either display the photo if there is one or let the user add one.  Here is the simple UI code to handle that:

```mxml
<s:Group width="92" height="92" top="8" right="8">
    <s:Rect width="92" height="92">
        <s:fill>
            <s:SolidColor color="#cccccc"/>
        </s:fill>
    </s:Rect>
    <s:Label id="addPhoto" text="Add a photo" width="92" height="92" verticalAlign="middle" textAlign="center"/>
    <s:BitmapImage id="photo" width="92" height="92"/>
</s:Group>
```

When the contact is set I check to see if there is a photo and if so display it:

```actionscript    
if (contact.photoData__c == null)
{
    photo.visible = false;
    return;
}

var decoder:Base64Decoder = new Base64Decoder();
decoder.decode(contact.photoData__c);
                                
var loader:Loader = new Loader();
loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
    photo.source = event.target.content;
    photo.visible = true;
});
loader.loadBytes(decoder.toByteArray());
```

The data from the photoData__c field is Base64 decoded and then displayed using the Flex BitmapImage component.

Now when the user clicks on the photo or empty photo box I use the AIR for Android CameraUI to grab a photo, resize it, covert it to a PNG, Base64 encode it, set it on the contact, and then save the contact to Salesforce.com:

```actionscript    
    if (CameraUI.isSupported)
    {
        cameraUI = new CameraUI();
        cameraUI.addEventListener(MediaEvent.COMPLETE, function(event:MediaEvent):void {
            var loader:Loader = new Loader();
            loader.load(new URLRequest(event.data.file.url));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
                var bitmap:Bitmap = event.target.content as Bitmap;
    						
                var result:BitmapData = new BitmapData(46, 46, false);
                var matrix:Matrix = new Matrix();
                matrix.scale(46 / bitmap.width, 46 / bitmap.height);
                result.draw(bitmap, matrix);
    			
                var pngEncoder:PNGEncoder = new PNGEncoder();
                var pngBytes:ByteArray = pngEncoder.encode(result);
    			
                var base64Encoder:Base64Encoder = new Base64Encoder();
                base64Encoder.encodeBytes(pngBytes);
                var encodedImage:String = base64Encoder.flush();
    						
                contact.photoData__c = encodedImage;
    			
                displayPhoto();
    						
                F3WebApplication.getInstance().wrapper.save(contact, new AsyncResponder(function(data:Object, token:Object=null):void {
                }, FlexGlobals.topLevelApplication.handleError));
            });
        });
        cameraUI.addEventListener(ErrorEvent.ERROR, function(event:ErrorEvent):void {
            FlexGlobals.topLevelApplication.handleError(event);
        });
        cameraUI.launch(MediaType.IMAGE);
    }
```

That's it for the mobile app!  I compiled it, exported it to an Android app, and then copied it to my phone.  Pretty simple and as you can see it works!  One limitation with my approach is the 32k limit of the photoData__c field.  However, I think I could easily get around that by striping the Base64 encoded data across multiple fields.  It's not ideal but it would work.

To display the photo when I view a contact on Salesforce.com I created a very simple Flex app using another Force.com Flex Project.  I could have also added photo upload to this application but chose to keep it simple.  All it does is display the selected contact's photo.  Here is the complete code (after generating the required services in Flash Builder):

```mxml
<?xml version="1.0" encoding="utf-8"?>
<s:Application xmlns:fx="http://ns.adobe.com/mxml/2009"
    xmlns:s="library://ns.adobe.com/flex/spark"
    xmlns:mx="library://ns.adobe.com/flex/mx"
    xmlns:flexforforce="http://flexforforce.salesforce.com">

    <fx:Script>         
    import mx.rpc.AsyncResponder;
    import mx.utils.Base64Decoder;
    </fx:Script>

    <fx:Declarations>
        <flexforforce:F3WebApplication id="app" requiredTypes="Contact">
            <flexforforce:loginComplete>
                app.wrapper.query("select photoData__c from Contact where Id = '" + this.parameters.contactId + "'", new AsyncResponder(function(data:Object, token:Object):void {
                    if (data.length == 1)
                    {
                        if (data[0].photoData__c == null)
                        {
                            photo.visible = false;
                            noPhoto.visible = true;
                            return;
                        }
                                
                        var decoder:Base64Decoder = new Base64Decoder();
                        decoder.decode(data[0].photoData__c);
                                                
                        var loader:Loader = new Loader();
                        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
                            photo.source = event.target.content;
                            photo.visible = true;
                        });
                        loader.loadBytes(decoder.toByteArray());
                    }
                }, function(fault:Object):void {
                    // ignored
                }));
            </flexforforce:loginComplete>
        </flexforforce:F3WebApplication>
    </fx:Declarations>

    <s:applicationComplete>
        app.serverUrl = this.parameters.serverUrl;
        app.loginBySessionId(this.parameters.sessionId);
    </s:applicationComplete>
        
    <s:Rect width="92" height="92">
        <s:fill>
            <s:SolidColor color="#cccccc"/>
        </s:fill>
    </s:Rect>

    <s:Label id="noPhoto" text="No Photo" width="92" height="92" textAlign="center" verticalAlign="middle" visible="false"/>
        
    <s:BitmapImage id="photo" width="92" height="92"/>

</s:Application>
```

Finally I created a custom S-Control to run the Flex app:

```html
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="92" codebase="https://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab" id="ContactPhoto" height="92"> 
        <param name="movie" value="{!Scontrol.JavaArchive}"></param> 
        <param name="flashvars" value="sessionId={!API.Session_ID}&serverUrl={!API.Partner_Server_URL_90}&contactId={!Contact.Id}"></param> 
        <embed src="{!Scontrol.JavaArchive}" pluginspage="http://www.adobe.com/go/getflashplayer" name="ContactPhoto" height="92" width="92" type="application/x-shockwave-flash" flashvars="sessionId={!API.Session_ID}&serverUrl={!API.Partner_Server_URL_90}&contactId={!Contact.Id}"> 
        </embed> 
    </object>
```

I uploaded the compiled Flex app to the S-Control and added it to the Contact page.  And that's it!  In just a few hours I extended Force.com and built a cool mobile app.  I could also have easily created a desktop widget for browsing contacts and adding photos.  If you are looking for a fun project to use as a way to learn this stuff that would be a good one!  :)

Here are some resources to help you get started with Flash Builder for Force.com:

  * [Force.com Flex Quick Start Tutorial](http://wiki.developerforce.com/index.php/Force.com_Flex_Quick_Start_Tutorial)


  * [Force.com Flex Project APIs for Web Applications](http://developerforce.s3.amazonaws.com/website/afb/docs/ASDoc_Flex/index.html)


  * [Force.com Flex Project APIs for Desktop Applications](http://developerforce.s3.amazonaws.com/website/afb/docs/ASDoc_AIR/index.html)


  * [Numerous other demo applications and tutorials](http://developer.force.com/flashbuilder)


  * [Source code for my mobile contacts demo](http://github.com/jamesward/MobileContacts)


  * [Source code for my web contact photo viewer demo](http://github.com/jamesward/WebContactSControl)



Have fun building the next generation of software!  Let me know how it goes.
