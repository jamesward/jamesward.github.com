---
date: '2009-08-11 15:05:52'
layout: post
slug: fonts-in-flex-4-flash-player-10-air-1-5-make-me-happy
status: publish
title: Fonts in Flex 4 / Flash Player 10 / AIR 1.5 Make Me Happy
wordpress_id: '1106'
categories:
- Adobe AIR
- Flash Player
- Flex
---

Device font rendering in Flash content has always had some limitations, including the inability for text to be correctly scaled, rotated, and faded.  Due to these limitations many developers using Flex resort to embedding fonts.  But this can really bloat the size of applications - especially when working with non-English languages.  Luckily Flash Player 10 / AIR 1.5 added a new font engine!  To make using the new engine easy Adobe also created an open source library called the [Text Layout Framework](http://opensource.adobe.com/wiki/display/tlf/Text+Layout+Framework), which wraps Flash Player's low level text APIs.  Flex 4 Spark components use the Text Layout Framework for all text rendering.  The end result is much better device font support in Flex applications.  Here's a quick example ([view source](http://www.jamesward.com/demos/fontTest/srcview/index.html)):

Drag the slider to change the scaleX and scaleY on the Panels.  Notice how the Flex 3 / Flash Player 9 text jumps around and flickers.  And then notice how the Flex 4 / Flash Player 10 text looks wonderful as it scales up and down!  That makes me happy.
