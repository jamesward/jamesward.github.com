---
date: '2006-12-04 17:49:06'
layout: post
slug: please-mind-the-gap-between-flash-versions
status: publish
title: Please Mind the Gap; Between Flash Versions
wordpress_id: '77'
categories:
- Flex
---

Currently the latest version of Flash 9 for Windows & Mac is 9.0.28.0 and for Linux (currently in beta) it's 9.0.21.78.  Notice that that third digit is different?  That's mostly because Flash 9 for Linux doesn't yet support full screen.  Unless your application is unusable without full screen, then please be nice to us folks on Linux and don't tell your Flash detection script to require 9.0.28.  This is an easy mistake to make.  Even we (Adobe) recently did this with the [Kuler app](http://kuler.adobe.com/).  Which currently doesn't work on Linux due to [an evil 28 in the detection script](http://www.adobe.com/cfusion/webforums/forum/messageview.cfm?forumid=72&catid=622&threadid=1217042&enterthread=y).  If you really do need 9.0.28, then the right thing to do would be to tell your detection script to require it for Windows & Mac, and just require 9.0.0 for Linux.  Otherwise we end up having to write GreaseMonkey scripts to de-28 offending pages.  And nobody wants to join the list of sites which need de-28 grease.

*** Update ***
Good news!  The Kuler team has updated their site to now work on Linux!  Now this is the beauty of the Flash Platform!  True write once, run anywhere applications!  And you don't even need any "if IE" hacks!  And you can even get away with only testing on one browser and one OS (provided you mind the gap).  :)
