---
author: admin
date: '2008-05-16 12:21:58'
layout: post
slug: where-is-64-bit-linux-support-for-flash-player
status: publish
title: Where is 64-bit Linux support for Flash Player?
wordpress_id: '278'
categories:
- Flash Player
- Linux
- Tamarin
---

I run 32-bit Linux but there is a very vocal group of people who really want
64-bit Linux support for Flash Player. Today there is a decent work around for
running the 32-bit Flash Player on a 64-bit Linux system using the
[nspluginwrapper](http://gwenole.beauchesne.info/en/projects/nspluginwrapper).
From what I've heard it works fairly well on most distro's but I haven't heard
yet how well it works with the [new Flash Player 10
beta](http://labs.adobe.com/technologies/flashplayer10/). Despite this
potential work around eventually Adobe does need to natively support 64-bit
Linux - and they will. This is not as simple as a recompile - otherwise there
would be 64-bit support today. There is [a bug already
filed](https://bugs.adobe.com/jira/browse/FP-37) in the public Flash Player
bug database for 64-bit support. I'd encourage you to not just go vote for
that bug but also to get involved. As [Tinic Uro](http://www.kaourantin.net/)
points out in the bug comments, the missing piece for 64-bit support is open
source - so you can help! Flash Player uses the open source [Mozilla Tamarin
VM](http://www.mozilla.org/projects/tamarin/). This VM does not yet support
64-bit Linux because all that machine code generation in the JIT compiler
needs to be ported from 32-bit to 64-bit. The code is in [Mozilla's Tamarin
Central Mercurial repo](http://hg.mozilla.org/tamarin-central/). This IS open
source! You can help get 64-bit Linux support for Flash Player!

