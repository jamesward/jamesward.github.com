---
date: '2009-03-10 12:47:52'
layout: post
slug: flex-monkey-patching-and-framework-rsls
status: publish
title: Flex Monkey Patching and Framework RSLs
wordpress_id: '778'
categories:
- Flex
---

The Flex Framework RSLs (Runtime Shared Libraries) are a great way to reduce download time for your Flex application.  But they have an unfortunate side effect...  They break the ability to monkey patch Flex framework classes.  The reason for this is the way that the Flex compiler structures a SWF file.  Every Flex application has two frames.  You can think of a "frame" as a container for compiled ActionScript classes.  The Flex compiler puts as few things into the first frame as possible.  This is so that the loading progress bar can come up quickly (as soon as the first frame has loaded).  If you put too much on the first frame then you wouldn't see anything happening until the whole first frame is loaded.  When you monkey patch a Flex Framework class it usually will go into the second frame.  The problem with monkey patching and the framework RSLs is that the RSLs get loaded in the first frame.  The Flash Player's class loader won't overwrite classes so when the preloader finishes loading and then starts loading frame two (where the monkey patched class is) it will not overwrite the class loaded from the RSL.

The solution is to get your monkey patched class onto frame one.  The easiest way to do this is to create a custom preloader that contains a reference to the monkey patched class.  Here's a simple one in which my monkey patched class is mx.controls.Button:

    
    package
    {
    	import mx.controls.Button;
    	import mx.preloaders.DownloadProgressBar;
    
    	public class MyPreloader extends DownloadProgressBar
    	{
    		public function MyPreloader()
    		{
    			super();
    			
    			if (0)
    			{
    				var b:Button = new Button();
    			}
    		}
    		
    	}
    }



Make sure you then tell your application to use your custom preloader:


    
    <mx:application preloader="MyPreloader" xmlns:mx="http://www.adobe.com/2006/mxml">



Now since Button is referenced from the preloader the Flex compiler will put Button and all of its dependencies on frame one.  The monkey patched Button class will then be loaded BEFORE the RSLs thus making monkey patching work again!  But the big caveat here is that now you have a ton of stuff on frame one (Button and all its dependencies - which we are trying to leave out of our SWF in the first place).  And now the user won't see the preloader progress bar until all of frame one is loaded - which now takes significantly longer than before.

While this works, it's not ideal.  What we need is a way to shove a single class into frame one.  I've tried every way I can think of to do this but to no avail.  What I'd hoped would work was to put my monkey patched class but none of its dependencies into a SWC and then use the _-compiler.include-libraries_ mxmlc compiler flag to shove the monkey patched class into my SWF.  But I couldn't get compc to put just my monkey patched class into the SWC.  Here is what I tried:

    
    ${FLEX_SDK}/bin/compc -source-path=src -debug=false -o=build/monkey.swc \
    -external-library-path=${FLEX_SDK}/frameworks/libs,${FLEX_SDK}/frameworks/libs/player/9/playerglobal.swc \
    -include-classes mx.controls.Button



But it appears that since compc sees the mx.controls.Button class in the _-external-library-path_ it decides it doesn't need to put my monkey patched Button in the SWC despite me telling it to.

Maybe someone else has some tricky way of getting just the monkey patched class into a SWC or onto frame one of the SWF.  Otherwise please go vote for [bug #19735](https://bugs.adobe.com/jira/browse/SDK-19735).
