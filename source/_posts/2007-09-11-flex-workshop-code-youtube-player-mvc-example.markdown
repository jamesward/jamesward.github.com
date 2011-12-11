---
author: admin
date: '2007-09-11 14:36:52'
layout: post
slug: flex-workshop-code-youtube-player-mvc-example
status: publish
title: Flex Workshop Code - YouTube Player / MVC Example
wordpress_id: '165'
categories:
- Flex
---

This past weekend I did a three hour workshop on Flex at the [Rich Web
Experience](http://www.therichwebexperience.com). We started with some very
simple stuff and ended with a YouTube Video Player that includes a Draggable
Panel, Live Reflection, and a simple Model View Controller (MVC) architecture.
You can see the application here:

[http://www.jamesward.org/youtube/youtube.html](http://www.jamesward.org/youtu
be/youtube.html)

You can get the code by right-clicking on the application and selecting "View
Source". If you want to compile that code you will also need NJ's DragPanel
and Reflector components available from:

[http://www.rictus.com/flex/LiveReflection/srcview/index.html](http://www.rict
us.com/flex/LiveReflection/srcview/index.html)

Also I had to setup a proxy server for the YouTube videos which required me to
add a customized VideoPlayer component which tells the NetStream to check the
policy file on the server from which the videos are being loaded. The server
that the videos are being loaded from needs to contain a crossdomain.xml
policy file which allows my application to access the contents of the video
which is needed to do a reflection of the video. Flickr recently added a
crossdomain.xml policy file to the servers from which their photos are loaded.
I wish YouTube would do the same so I could avoid the whole proxy thing.

Thanks to everyone who attended the workshop. And for those who didn't I hope
you learn something by looking at the code for this application.

