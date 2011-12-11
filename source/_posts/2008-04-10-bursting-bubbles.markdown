---
author: admin
date: '2008-04-10 09:42:21'
layout: post
slug: bursting-bubbles
status: publish
title: Bursting Bubbles
wordpress_id: '258'
categories:
- Adobe AIR
- Flash Player
- Flex
---

![](http://www.jamesward.org/wordpress/wp-
content/uploads/2008/04/singlemoveperframeair.png)Bubblemark is a popular
benchmark for some of the RIA technologies including Flex, Adobe AIR, Ajax
(DHTML), Java Swing, Java FX, Silverlight, etc. I've been trying for a while
to create a new Flex version of Bubblemark to show just how fast Flash Player
and Adobe AIR are. But I've come to a few realizations... First, you can make
benchmarks say whatever you want them to say.

When trying to optimize Bubblemark I found a few interesting things. First was
that IE (and some versions of Firefox) limit the frame rate of Flash Player
([and possibly other plugins](http://www.kaourantin.net/2006/05/frame-rates-
in-flash-player.html)). This means that while the Flash Player VM might be
able to actually achieve 200+ frames per second the actual visual result might
be only 60 fps. And maybe this is for good reason. Why do you need a visual
frame rate faster than the refresh rate on a monitor? You don't. And
especially not for RIAs.

Graphic rendering performance is certainly relevant for RIAs but that is only
one factor which affects overall application performance. [As Chet Haase
points out](http://graphics-geek.blogspot.com/2008/04/off-bubblemark.html),
Bubblemark lumps a number of different factors - calculation speed, rendering
performance, and timer resolution - into a single "frames per second" metric.
That leads to my second realization.

The frame rate of bouncing bubbles isn't very relevant to RIAs. As [Josh
Marinacci of Sun
says](http://weblogs.java.net/blog/joshy/archive/2008/04/at_the_speed_of.html)
- "there aren't any real benchmarks yet for rich internet applications." I
think that my [Census RIA benchmark](http://www.jamesward.org/census/) is more
pertinent to RIAs than bouncing bubbles. Census benchmarks how quickly an
application can get data from a server, parse that data, and render the data
in a datagrid. Sorting and filtering are also important benchmarks that I'm
working on integrating into Census. Today the Census app has various Flex and
Ajax tests but I'm also currently working on adding a Silverlight test, an Ext
JS test, and an updated Dojo test. I'd love it if someone would create a Java
FX version as well.

Just for kicks let's go back to Bubblemark and see what I was able to come up
with (with help from [Chet Haase](http://graphics-geek.blogspot.com/)). I
created two versions of the new Flex Bubblemark application. You can run each
version in the browser (Flash Player) or on the desktop (Adobe AIR). The
results will vary between the web and desktop versions due to the browser
throttling. The first application will only move the bubbles once per frame.
This is similar to the original Flex Bubblemark application. If the browser is
only letting Flash Player run at 60 fps then the maximum fps will be 60. Adobe
AIR seems to limit the fps to 250 but I haven't yet confirmed that. With both
of these versions CPU utilization should be pretty low since they are being
artificially throttled. The second set of applications moves the bubbles as
many times as possible per frame. The appearance of these might be choppy
since the bubbles only get rendered after being moved potentially hundreds of
times. The second set of benchmarks is more real world if you are interested
in VM processing speed as opposed to resolution of the timing mechanism.
However a third set of tests which is probably the most useful and that I
haven't yet written would calculate how many bubbles can be moved once per
frame and maintain 60 fps. That kind of metric is probably relevant to RIAs
that need to do a lot on every frame. But most RIAs I've seen are more
concerned with the speed of data processing. Here are the new Flex Bubblemark
applications:

Single Move Per Frame:
[Web](http://www.jamesward.org/Bubblemark/SingleMovePerFrameWeb.html) |
[Desktop](http://www.jamesward.org/Bubblemark/SingleMovePerFrame.air)
(requires Adobe AIR 1.0) Many Moves Per Frame:
[Web](http://www.jamesward.org/Bubblemark/ManyMovesPerFrameWeb.html) |
[Desktop](http://www.jamesward.org/Bubblemark/ManyMovesPerFrame.air) (requires
Adobe AIR 1.0)

([Flex Bubblemark Source
Code](http://flexapps.svn.sourceforge.net/viewvc/flexapps/bubblemark/))

Benchmarks are only useful when you apply them to your scenario. Is the
performance good enough for what you need? Are your users able to run what you
build? There are thousands of RIAs which run in Flash Player and now hundreds
of Adobe AIR applications. For the millions of users of these applications the
frame rate is fast enough and the VM performance is superb. For the developers
of these applications the Flex tooling enabled them to efficiently build these
applications. Not only do the runtimes and the tools work on Windows, Mac, and
Linux - the runtimes and core development tools are free. There is more to
choosing a platform than the speed at which a runtime can bounce objects
around the screen. Sorry if I've burst any bubbles.

