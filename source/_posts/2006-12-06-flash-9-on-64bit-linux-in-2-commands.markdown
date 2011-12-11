---
author: admin
date: '2006-12-06 16:06:54'
layout: post
slug: flash-9-on-64bit-linux-in-2-commands
status: publish
title: Flash 9 on 64bit Linux in 2 Commands
wordpress_id: '78'
categories:
- Flash Player
- Flex
- Linux
---

I've heard it so many times... "Flash 9 doesn't work on 64bit Linux" So when I
loaded 64bit Gentoo Linux my new Merom based Intel Core 2 Duo, I really was
expecting an adventure. Turns out that it was actually pretty uneventful. It
worked first try without any problems and in only 2 commands. Here's what I
did..

First I added the net-www/netscape-flash package to
/etc/portage/package.unmask `sudo vi /etc/portage/package.unmask`

Then I emerged Flash 9 & the Netscape Plugin Wrapper `sudo emerge -av
netscape-flash nspluginwrapper`

Then I reloaded Firefox, tested it, and it works great! I assume it's this
easy on other distributions, but I only have Gentoo to test on.

Of course this means much more than just being able to watch YouTube videos...
Now that the [Flex 2 SDK is free](http://www.adobe.com/products/flex/sdk/) (as
in beer) anyone can build applications that work the same on all major
browsers and operating systems! I'm happy to say that since I started doing
Flex development about two years ago, Firefox on Linux has been my primary
build and test environment. And in that two years the only time I've had to
write any of those "if IE" things was when I was writing JavaScript for a soon
to be released Ajax & Flex benchmarking tool.

Using my OS of choice... Writing code once that works the same universally...
These are things that make me happy. :)

Oh, and the fact that Flash is now built on the Mozilla / Open Source [Tamarin
VM](http://www.mozilla.org/projects/tamarin/) makes me ecstatic!

