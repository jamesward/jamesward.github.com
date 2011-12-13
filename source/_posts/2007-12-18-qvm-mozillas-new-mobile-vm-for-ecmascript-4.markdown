---
date: '2007-12-18 18:03:25'
layout: post
slug: qvm-mozillas-new-mobile-vm-for-ecmascript-4
status: publish
title: 'Tamarin-Tracing: Mozilla''s New VM for ECMAScript 4'
wordpress_id: '222'
categories:
- Flash Player
- Flex
- Mobile
- Open Source
---

[Update: QVM was an internal Adobe codename.  The new VM's name seems to be "Tamarin-Tracing".  For more info on this new VM read the [announcement  by Edwin Smith](http://groups.google.com/group/mozilla.dev.tech.js-engine/browse_thread/thread/e10d25db3dcb28cf#841d6253dcf2de12).  Edwin doesn't explicitly state that the VM is for mobile devices but it is hinted at.  However the research paper that Edwin references does state that this tracing type of VM is good for mobile devices.]

The mobile space has been heating up lately with Apple's iPhone, Google's Android, and Sun's JavaFX Mobile.  But what about all of us developing with JavaScript 2.0 / ActionScript 3.0 / ES4?  While we have been able to build for Flash Lite with Flash CS3, those of us developing with Flex haven't had an easy way to use our existing programming knowledge to build mobile applications.  Part of the reason for this is that the core language of Flex (AS3 / ES4) isn't yet supported on mobile devices.  The good news is that Adobe has just contributed a new VM targeted at mobile devices, to the Mozilla Tamarin project.  Tamarin is the open source core of Flash Player 9 and will at some point be the VM in Firefox that executes JavaScript 2.0.  More specifically AVM2 is the VM piece of Tamarin which executes ActionScript Byte Code (ABC).  ABC can be created using the soon to be open source Flex SDK's ASC compiler which turns AS3 (or ES4) into ABC.  Unfortunately AVM2 wasn't written to work well on mobile devices.  So Adobe built Tamarin-Tracing - a new VM in Tamarin which is much better suited for non-pc devices.  This is very exciting stuff!
