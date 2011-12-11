---
author: admin
date: '2007-04-17 08:28:17'
layout: post
slug: the-open-source-flex-and-apollo-toolkit-for-salesforcecom
status: publish
title: The Open Source Flex and Apollo Toolkit for Salesforce.com
wordpress_id: '106'
categories:
- Adobe AIR
- Flex
- Salesforce.com
---

A few months ago I met with Salesforce.com about Flex and Apollo. They had
begun building some Flex applications that used the Flex Ajax Bridge to
communicate with Salesforce. This worked but they wanted to be able to more
easily build Flex and Apollo applications. So I took their JavaScript library
and did an initial port to ActionScript. Surprisingly the code ported pretty
easily. It was actually a fascinating experiment. ActionScript 3 is based on
the same specification as JavaScript 2, so in theory this kind of thing should
be pretty trivial -- especially if the code being ported doesn't do much with
the browser DOM. That was the situation in this case because the Salesforce
JavaScript library talks to their backend via XHR and doesn't do much with the
browser DOM. Once I had an initial port done including authentication and
query support Ron and Dave from Salesforce.com cleaned everything up, added
better object typing, built complex examples, and developed an Apollo demo.
Everything has been going on under a semi-secret SourceForge project, code
named Mavericks.

"Adobe Flex Toolkit for Apex" is the formal name for this new Flex / Apollo
library. The library is licensed under BSD so everyone can easily reuse it in
their applications. Because it uses a simple asynchronous communications model
and typed objects wherever possible, this new library accelerates the process
of building Flex and Apollo applications on top of the Salesforce.com Apex
platform. With just a few lines of code you can get data from Salesforce.com
and render it in your application. There are three primary ways to use this
toolkit. You can use it to build Apollo based desktop applications, create
custom web applications hosted on your site, or build a custom S-Control
hosted on Salesforce.com. For instructions on how to build a custom S-Control
and the basics of using the toolkit, check out the [Creating Flex Salesforce M
ashups](http://wiki.apexdevnet.com/index.php/Tutorial:_Creating_Flex_Salesforc
e_Mashups) tutorial.

Here is what you need to do to build an Apollo application using the Flex
Toolkit for Apex.

1. Download the toolkit: [http://wiki.apexdevnet.com/index.php/Members:Flex_To
olkit_download](http://wiki.apexdevnet.com/index.php/Members:Flex_Toolkit_down
load)

2. If you haven't already done so, install Flex Builder and the Apollo
Extensions: [http://www.adobe.com/go/tryflex](http://www.adobe.com/go/tryflex)
[http://labs.adobe.com/technologies/apollo/](http://labs.adobe.com/technologie
s/apollo/)

3. Create a new Apollo Project
![salesforce1.png](http://www.jamesward.org/wordpress/wp-
content/uploads/2007/04/salesforce1.png)

4. Add the Salesforce SWC to the Library Build Path
![salesforce2.png](http://www.jamesward.org/wordpress/wp-
content/uploads/2007/04/salesforce2.png)

5. Write your Apollo application:

    
    
    <?xml version="1.0" encoding="utf-8"?>
    <mx:ApolloApplication xmlns:mx="http://www.adobe.com/2006/mxml" xmlns:salesforce="http://www.salesforce.com/"
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
      
    </mx:ApolloApplication>

  
6. Save it (which automatically compiles it)

7. Run it ![salesforce3.png](http://www.jamesward.org/wordpress/wp-
content/uploads/2007/04/salesforce3.png)

8. Export it as an installable AIR file so you can share it with others

9. Say “WOW!”

It really is that easy. To learn more check out the examples in the toolkit.
Also if you really want to dive in, the toolkit is 100% Open Source so you can
look at all the code and even help us improve it. Check it out from the
[SourceForge SVN repository](http://sourceforge.net/projects/sforce). I'm
working on another article which will walk you through setting up the
environment to begin hacking on the toolkit using either the Free Flex SDK or
Flex Builder (we support both methods). I hope you find the toolkit useful and
please let me know what cool things you build with it!

