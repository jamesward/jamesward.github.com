---
date: '2007-07-30 13:19:04'
layout: post
slug: flex-flash-as-competitors-to-java
status: publish
title: Flex & Flash as Competitors to Java?
wordpress_id: '137'
categories:
- Flash Player
- Flex
- Java
---

As [previously discussed](http://www.jamesward.org/wordpress/2007/07/26/2008-the-year-of-client-java/), my friend Joshua from Sun [recently blogged](http://weblogs.java.net/blog/joshy/archive/2007/07/java_fx_updated.html) about how the consumer JRE will take market share from Flash in 2008.  Today Sameer Tyagi <del>, also from Sun, </del>[blogged](http://sameertyagi.blogspot.com/2007/07/flex-web-services.html) about problems with using Flex to front-end JAX-WS.  Both posts seem to insinuate Flash and Flex as competitors to Java.  Yet for me Java and Flex have always been a perfect match.

The continued success of Flash and Flex only helps to better position Java in the enterprise.  Adobe is not a threat to Java's continued dominance on the server.  In fact many Adobe enterprise products are built on the Java platform including Flex Data Services.  If you must have an enemy then I suggest targeting those who actually have something to gain by Java losing market share in the enterprise.  That is definitely not Adobe.

As I've [said elsewhere](http://www.oreillynet.com/onjava/blog/2007/05/java_se_media_or_not_at_javaon.html#comment-630117), Java and Flex developers should be working more closely together to make building RIAs easier for developers and to make experiencing those applications better for end users.  Both technologies have similar values when it comes to openness, free tools and runtimes, and cross platform support.  And the areas in which Java and Flex overlap are really very minimal.  Developers and end users have much more to benefit by our harmony than by our discord.  I continue to meet many people who are embracing this vision of a harmonious union of these two great technologies.  I encourage others to consider doing the same.

Now to respond to Sameer's disappointment "with the Web Services support, or lack thereof, in Adobe's recent Flex 3.0 beta release" I built a quick Flex app which calls the non-trivial Web Service from the JAX-WS samples that Sameer referenced.  Here is the code for what I came up with:


    
    <?xml version="1.0" encoding="utf-8"?>
    <mx:Application xmlns:mx="http://www.adobe.com/2006/mxml">
    
      <mx:Script>
      <![CDATA[
      import mx.rpc.events.ResultEvent;
      import mx.rpc.events.FaultEvent;
      import mx.controls.Alert;
    
      private function handleFault(event:FaultEvent):void
      {
        Alert.show(event.fault.faultDetail, event.fault.faultString);
      }
    
      private function handleResult(event:ResultEvent):void
      {
        Alert.show("Your shipment number is: " + event.result.shipmentNumber, "Purchase Order Accepted");
      }
    
      private function submitPO():void
      {
        var po:Object = new Object();
        po.customerNumber = "1";
        po.orderNumber = "1";
    
        var item1:Object = new Object();
        item1.itemID = 1;
        item1.name = "a";
        item1.price = 1;
        item1.quantity = 1;
    
        var item2:Object = new Object();
        item2.itemID = 2;
        item2.name = "b";
        item2.price = 1;
        item2.quantity = 1;
    
        po.itemList = [item1,item2];
    
        srv.submitPO.send(po);
      }
      ]]>
      </mx:Script>
    
      <mx:WebService id="srv" wsdl="http://localhost:8080/jaxws-supplychain/submitpo?wsdl" fault="handleFault(event)" result="handleResult(event)">
        <mx:operation name="submitPO"/>
      </mx:WebService>
    
      <mx:Button label="Submit PO" click="submitPO()"/>
    
    </mx:Application>


This is a very simple example and doesn't have the UI necessary to actually assemble a PO based on user input.  That piece would also be trivial so I've left it out of this example.  The key thing is that it correctly talks to the JAX-WS based Web Service.  This is just one example which uses Java and Flex together.  There are many more.  And there are plenty of enterprises happily using Java and Flex together.  Pitting these technologies against each other does nothing to benefit developers or end users.
