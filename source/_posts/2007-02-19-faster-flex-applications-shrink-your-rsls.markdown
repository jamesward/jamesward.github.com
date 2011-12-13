---
date: '2007-02-19 12:23:07'
layout: post
slug: faster-flex-applications-shrink-your-rsls
status: publish
title: 'Faster Flex Applications: Shrink Your RSLs'
wordpress_id: '98'
categories:
- Flex
---

A few days ago [Metal](http://hurlant.com/) pointed out to me in a [comment on my blog](http://www.jamesward.org/wordpress/2006/11/27/howto-reduce-the-size-of-your-flex-app/#comment-4802) that by using the SWFs inside a SWC, my RSLs are much larger than they need to be.  Sure enough he was right.  When you use compc to create a SWC, the SWF inside the SWC contains a lot of unnecessary stuff when used as an RSL.  That stuff is necessary to create an application which uses the SWC, so don't go ditching compc.  Here is what you need to do if you want to have size optimized RSLs:

1) Create an ActionScript class that extends Sprite and includes references to the stuff you want to go into your RSL.  For instance:



`package
{
import flash.display.Sprite;
import mx.core.Application;

public class smallLinker extends Sprite
{
    private var application:Application;
}
}`



2) Compile your SWC:



`compc -debug=false -o=my.swc smallLinker`




3) Compile your RSL:



`mxmlc -o=my.swf -file-specs=smallLinker.as`




4) Compile your application:



`mxmlc -external-library-path+=my.swc \
  -runtime-shared-libraries=http://www.yourhost.com/my.swf \
  -o=app.swf -file-specs=app.mxml`




5) Upload app.swf and my.swf to your host.

6) Run your application and verify it works.

7) Send me a check for the money you save on bandwidth (Don't worry Metal, we will split it 60/40).

If you compare the size of the SWF inside the SWC and the SWF created with mxmlc, you should see a very large difference.  Since your new SWF is much smaller than your old one, your application will take less time to load across the wire.  Fun stuff!
