---
date: '2010-02-21 13:46:24'
layout: post
slug: flex-performance-on-mobile-devices
status: publish
title: Flex Performance on Mobile Devices
wordpress_id: '1574'
categories:
- Flash Player
- Flex
- Mobile
---

This past weekend I spent an hour optimizing the [Flex 4 scrolling demo](http://www.jamesward.com/2010/02/19/flex-4-list-scrolling-on-android-with-flash-player-10-1/) that I posted last week.  The original demo was intended to show how to hook up touch events to the Flex 4 List / DataGroup controls.  This new version adds some optimizations for the touch event handling and adds the kinetic flick behavior.  Check it out and let me know what you think:



I've posted [the code](http://www.jamesward.com/demos/MobileListSwipe2/srcview/) for this second version of the [touch scrolling demo](http://www.jamesward.com/demos/MobileListSwipe2/MobileListSwipe2.html).  It was pretty trivial to optimize it this far.  With a little more work it'll be as smooth as silk and as fast as Apolo Ohno.  :)

Over the past few days I've received some questions about the performance of Flex apps on mobile devices.  My [Census RIA Benchmark](http://www.jamesward.com/census) has been a great way to compare the performance of various data loading techniques and technologies.  Now that I have my Android based Nexus One mobile device with an early build of Flash Player 10.1 I wanted to see how fast I could load and render large amounts of data in a Flex application.  I'm really impressed with the results!  20,000 rows of data loaded from the server and rendered on my phone in about 2 seconds!  Those 20,000 rows can then be sorted on the device instantaneously.  Pretty amazing performance for such a little device!  Check out the video:



You can run the mobile version of the [Flex AMF Census Test](http://www.jamesward.com/demos/MobileCensus/MobileCensus.html) and check out the [source code](http://www.jamesward.com/demos/MobileCensus/srcview/index.html).  Let me know what you think.
