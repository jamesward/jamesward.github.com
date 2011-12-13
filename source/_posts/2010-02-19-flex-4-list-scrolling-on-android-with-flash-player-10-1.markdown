---
date: '2010-02-19 14:53:56'
layout: post
slug: flex-4-list-scrolling-on-android-with-flash-player-10-1
status: publish
title: Flex 4 List Scrolling on Android with Flash Player 10.1
wordpress_id: '1563'
categories:
- Flash Player
- Flex
- Mobile
---

UPDATE 1: The first version of this demo was intended to show how to hook up touch events to the Flex 4 List / DataGroup controls. I've posted [a new version](http://www.jamesward.com/2010/02/21/flex-performance-on-mobile-devices/) that adds some optimizations for the touch event handling and adds the kinetic flick behavior.

One of the challenges of running existing web content on mobile devices is that user interactions differ between mediums.  For instance, on a normal computer with a mouse, scrolling though lists is often done by clicking on scroll bars or mouse wheels.  On mobile devices that lack a pointing device this is not the best interaction paradigm.  On devices with touch screens the paradigm for scrolling is usually a swipe gesture.

In Flash Player 10.1 there are APIs for gestures and multitouch events.  I thought it would be fun to hook up the list scrolling on a Flex 4 List to the [TouchEvent](http://help.adobe.com/en_US/FlashPlatform/beta/reference/actionscript/3/flash/events/TouchEvent.html#TOUCH_MOVE) on my Nexus One.  Check out the video:



If you want to see how I created this [simple demo](http://www.jamesward.com/demos/MobileListSwipe/MobileListSwipe.html), check out the [source code](http://www.jamesward.com/demos/MobileListSwipe/srcview/).  Let me know if you have any questions.
