---
date: '2007-12-12 23:27:39'
layout: post
slug: blazebench-why-you-want-amf-and-blazeds
status: publish
title: 'BlazeBench: Why you want AMF and BlazeDS'
wordpress_id: '218'
categories:
- BlazeDS
- Flex
- Java
---

Update: I've merged BlazeBench and Census into a [single demo](/census).  There is a known bug in in Firefox 3 due to a change in IFrame handling.  To start the test when using FF3 you need to click on the results panel.

Today Adobe released BlazeDS, an open source Java implementation of AMF based remoting and messaging.  This is huge news for the Flex, Flash, Adobe AIR and Java communities!  I can't wait to break the news with Bruce Eckel in a few hours at the JavaPolis day 2 Keynote!  Check out the [press release](http://www.adobe.com/aboutadobe/pressroom/pressreleases/200712/121307BlazeDS.html).  And go [download the bits](http://labs.adobe.com/technologies/blazeds/).  And take a look at my new [BlazeBench application](/blazebench/) which shows why you want AMF and BlazeDS.  Right-click on the application to find the source code on SourceForge.  I'll roll out a binary and source build in the next week or so.  We have also officially published the AMF spec!

[Please note that my server is probably going pretty taxed for the next few days so the results you see might vary from normal results.  When I publish the binary version of this app you will be able to run it locally and see more accurate results.  Notice how much time it's taking my server to create those large data packets and gzip them?  One more reason that AMF is great!  Super fast without the need for gzip!]

[![blazebench.jpg](http://www.jamesward.org/wordpress/wp-content/uploads/2007/12/blazebench.jpg)](/blazebench/)
