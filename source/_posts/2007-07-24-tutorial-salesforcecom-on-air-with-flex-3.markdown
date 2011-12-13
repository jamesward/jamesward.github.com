---
date: '2007-07-24 09:02:58'
layout: post
slug: tutorial-salesforcecom-on-air-with-flex-3
status: publish
title: 'Tutorial: Salesforce.com on AIR with Flex 3'
wordpress_id: '129'
categories:
- Adobe AIR
- Flex
- Salesforce.com
---

**This tutorial has been updated to Flex 3 Beta 2.  The new version is now on the Adobe Developer Connection:
[_Building a standalone Adobe AIR application on salesforce.com with Flex 3_](http://www.adobe.com/devnet/flex/articles/flex_air_salesforce.html)**


The excitement around using Flex & AIR to build amazing front-ends for Salesforce applications continues to grow.  Nitobi has posted [a cool AIR application](http://blogs.nitobi.com/andre/index.php/2007/07/20/offline-salesforcecom-with-air-and-ajax/) that uses the Salesforce Ajax library.  Also Dave Carroll of Salesforce has posted [a great blog](http://blog.sforce.com/sforce/2007/07/why-flexair-dev.html) about why Flex & AIR developers should care about the Apex platform.  Back in April I posted [the first version](http://www.jamesward.org/wordpress/2007/04/17/the-open-source-flex-and-apollo-toolkit-for-salesforcecom/) of a tutorial about how to use the Flex Toolkit for Apex to build AIR (was Apollo) applications.  Since the Flex 3 and AIR betas were released recently it's time to update that tutorial.  So if you want to start building some sexy interfaces on top of salesforce.com follow along...

1. Download and unzip the Flex Toolkit for Apex:
[http://wiki.apexdevnet.com/index.php/Flex_Toolkit](http://wiki.apexdevnet.com/index.php/Flex_Toolkit)

2. Download and install the Flex 3 Beta:
[http://labs.adobe.com/technologies/flex/flexbuilder3/](http://labs.adobe.com/technologies/flex/flexbuilder3/)

3. Create a new AIR Project:
![](http://www.jamesward.org/wordpress/wp-content/uploads/2007/07/step1.jpg)
![](http://www.jamesward.org/wordpress/wp-content/uploads/2007/07/step2.jpg)

4. Add the Salesforce SWC to the Library Build Path:
![](http://www.jamesward.org/wordpress/wp-content/uploads/2007/07/step3.jpg)

5. Write your AIR application:

    
    <?xml version="1.0" encoding="utf-8"?>
    <mx:WindowedApplication xmlns:mx="http://www.adobe.com/2006/mxml" xmlns:salesforce="http://www.salesforce.com/"
      creationComplete="conn.loginWithCredentials('dev@mavericks.demo', '123456', new AsyncResponder(loginResult, loginFault));">
    
      <mx:Script>
      <![CDATA[
      import mx.controls.Alert;
      import com.salesforce.results.QueryResult;
      import com.salesforce.AsyncResponder;
    
      private function loginResult(result:Object):void
      {
        conn.query("SELECT Id, Contact.Firstname, Contact.Lastname FROM Contact",
          new AsyncResponder(queryResult));
      }
    
      private function loginFault(fault:Object):void
      {
        Alert.show("Login error!");
      }
    
      private function queryResult(qr:QueryResult):void
      {
        dg.dataProvider = qr.records;
      }
    
      ]]>
      </mx:Script>
    
      <salesforce:Connection id="conn"/>
    
      <mx:DataGrid id="dg" width="100%" height="100%"/>
    
    </mx:WindowedApplication>



6. Save it (which automatically compiles it)

7. Run it:
![](http://www.jamesward.org/wordpress/wp-content/uploads/2007/07/step4.jpg)

8. Export it as an installable AIR file so you can share it with others

9. Say "That's Hot!"

Now go ahead and build some amazing Flex and AIR applications on top of salesforce.com!  Just let me know what you create so that I can use it in my demos.  :)

[Download the AIR file for this tutorial](/downloads/sf_air.air)
