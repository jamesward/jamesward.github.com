---
date: '2009-07-09 08:41:52'
layout: post
slug: flex-example-right-click-save-image-as
status: publish
title: 'Flex Example: Right-Click -> Save Image As'
wordpress_id: '144'
categories:
- Flex
---

One of the things that is available in HTML web pages but usually left out of Flex applications is the ability to save images by right-clicking on them.  This is not because it's not possible with Flex - rather it just requires a little extra coding.  So I created a simple Flex example that adds the "Save Image As" right-click menu item.  Check out the [demo](/saveAsImage/saveAsImage.html) and the [source code](/saveAsImage/srcview/).

[![Flex Example - Save Image As](http://www.jamesward.com/blog/wp-content/uploads/2009/07/SaveImageAs.gif)](/saveAsImage/saveAsImage.html)

This requires Flash Player 10 which allows users to save files generated at runtime on the client-side.  I couldn't find the ByteArray containing the original image file loaded by Flash Player so instead I had to read the bytes of the image wrapped in a SWF and slice out the image.  I'm not 100% sure that this trick will work for all image formats.  So give it a try and let me know what happens.
