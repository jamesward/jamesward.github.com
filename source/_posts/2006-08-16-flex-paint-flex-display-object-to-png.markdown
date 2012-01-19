---
date: '2006-08-16 00:55:46'
layout: post
slug: flex-paint-flex-display-object-to-png
status: publish
title: Flex Paint - Flex Display Object to PNG
wordpress_id: '66'
categories:
- Flex
- Java
- Open Source
- RIA
---

UPDATE - I've created a [new version of Flex Paint](http://www.jamesward.com/blog/2009/04/16/flex-paint-2/) which doesn't require the server roundtrip.

Flex allows you to easily create beautiful UIs.  But what if you want to take a piece of the UI and save it as an image?  Well, using [Tinic's AS3 PNG Encoder](http://www.kaourantin.net/2005/10/png-encoder-in-as3.html), Remote Object, and Flash's BitmapData and ByteArray API it's very easy.  To show how this is done, I created a simple application called Flex Paint.


**Flex Paint** (requires Flash 9)

<iframe src="http://www.cayambe.com/flexpaint/flexpaint.mxml" width="325" height="380" style="border:0px"></iframe>

**How it Works**

We use the Flash drawing API to draw on a canvas.  Then when the "Save Image" button is clicked we do a few simple things.  First we create a new BitmapData object:

```actionscript
var bd:BitmapData = new BitmapData(canvas.width,canvas.height);
```

Then we copy canvas' pixels onto the BitmapData object:

```actionscript
bd.draw(canvas);
```

Now we convert the BitmapData object to a ByteArray encoded as a PNG:
```actionscript
var ba:ByteArray = PNGEnc.encode(bd);
```

And then upload the PNG via Remote Object:
```actionscript
ro.doUpload(ba);
```

Then Remote Object just saves the file to the file system.  If you would like to download the code for Flex Paint, you can find it on [Source Forge](http://sourceforge.net/projects/flexapps/).  Let me know what you think.  Thanks!
