---
author: admin
date: '2007-01-17 10:36:52'
layout: post
slug: my-tribute-to-flash-9-on-linux-compiz-like-wobbly-windows
status: publish
title: 'My Tribute to Flash 9 on Linux: Compiz Like Wobbly Windows'
wordpress_id: '87'
categories:
- Flash Player
- Flex
- Linux
---

I'm sitting in Caribou Coffee in Ann Arbor Michigan looking out at beautiful
ice covered trees glistening in the sunlight. It's Jan 17th 2007 and this day
is going down in history! Today is the day Flash Player 9 was [officially rele
ased](http://weblogs.macromedia.com/emmy/archives/2007/01/adobe_flash_pla_1.cf
m) for Linux! This is HUGE! The web allows anyone with a PC to engage with
information and others. Flash has always pushed the limits of how that
engagement happens, most recently with video. Even though many Desktop Linux
users prefer free software, Adobe has still committed to making Flash work on
Linux. I think this is noble. Do you see MS or Apple doing this with their
platforms? By having Flash 9 for Linux, Desktop Linux is made all that much
better. I have been using Linux as a desktop since '96 and without Flash I
would be missing out on some pretty amazing stuff. Some will say "But Flash
isn't Open Source". You are right. But if you don't want to run proprietary
software, rather than complain, go help
[Gnash](http://www.gnu.org/software/gnash/). Ok, now that I've espoused my
religious views, lets move on to the cool stuff!

[First the demo: Wobbly Windows on the Web](/wobbly/wobbly.html)

That's using Flash Player 9 and was built with the free Flex SDK. The wobble
isn't as refined as Compiz's/Beryl's, but that can be fixed once I (or you)
figure out the math for doing that. Let's walk through how you can compile
that application.

First get the code from
[SourceForge](http://sourceforge.net/cvs/?group_id=174131). It's in the wobbly
module of the flexapps repository.

You need to get the [free Flex SDK](http://www.adobe.com/products/flex/sdk/).
Also if you don't have it, you will need the Sun JDK 1.4 or better.

Set the FLEX_SDK to where you extracted the Flex SDK to.

In the directory where you checked out the wobbly code, run build.sh

Load the build/wobbly.html file in your browser!

This still needs some work, and since it's Open Source, I'd love your help!
Let me know what you think.

