---
date: '2009-01-26 09:47:34'
layout: post
slug: mx_function-declarative-function-definitions-in-mxml
status: publish
title: <mx:Function> - Declarative Function Definitions in MXML
wordpress_id: '668'
categories:
- Flex
---

I think I'm the only Flex developer out there that doesn't like code behind or <mx:Script> blocks.  So I have my own way of doing things.  What can I say?  I'm a cowboy!  ;)

I frequently code event handlers inline like:

    
    <mx:button>
        <mx:click>    
        // do something
        // do something else
        </mx:click>
    </mx:button>



I just don't like having to find code that is only used in this one place somewhere else.  This method is just more readable to me.

But there are times when you have some view logic code that needs to be reused within an MXML file.  Many of us would typically put that code inside a <mx:Script> block or in a separate AS3 file (code behind).  But I just don't like either of those.  When I code in MXML I like all my object instantiations to be declarative.  I recently discovered that you can also define functions in MXML.  (Of course the contents of the function is still AS3 and not declarative.)  To do this you just use the <mx:Function> tag.  But it's a bit finicky.  Unlike inline event handlers these must have a CDATA wrapper and you must still wrap the function.  Here's an example:

    
    <mx:function id="doSomething">
        function():void
        {
            // do something
            // do something else
        }
    </mx:function>



This is not as much of an improvement in readability over a single giant <mx:Script> block but I believe it is slightly more readable because there is a clear delimiter between different functions.

Call me crazy for not shoving all my AS3 code into a single place in MXML files.  But I do think inline event handlers and declarative function definitions lead to more readable code.

BTW: I do still usually have a <mx:Script> block but it only contains my imports.
