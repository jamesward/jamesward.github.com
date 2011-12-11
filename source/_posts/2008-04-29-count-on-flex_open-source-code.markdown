---
author: admin
date: '2008-04-29 09:20:24'
layout: post
slug: count-on-flex_open-source-code
status: publish
title: Count on Flex - 1,117,019
wordpress_id: '268'
categories:
- BlazeDS
- Flex
- Tamarin
---

**1,117,019** = Number of Lines of Open Source code for [Flex](http://opensource.adobe.com/wiki/display/flexsdk/), [BlazeDS](http://opensource.adobe.com/wiki/display/blazeds/), and [Tamarin](http://opensource.adobe.com/wiki/display/site/Projects#Projects-Tamarin).  
200,897 lines in the
[flex_sdk](http://opensource.adobe.com/svn/opensource/flex/sdk/trunk/) 218,789
lines in [blazeds](http://opensource.adobe.com/svn/opensource/blazeds/trunk/)
353,644 lines in [tamarin-central](http://hg.mozilla.org/tamarin-central/)
343,689 lines in [tamarin-tracing](http://hg.mozilla.org/tamarin-tracing/)

That's **1,117,019** more reasons you can Count on Flex!

"Count on Flex" is a series of blogs about the current state of the Flex
ecosystem... by the numbers.

* * *

  
For this post I did a very basic calculation which doesn't factor out comments
and licenses. For the Flex SDK and BlazeDS I used this command:

    
    find . \( -name "*.java" -or -name "*.as" -or -name "*.mxml" -or -name "*.css" \)|xargs wc -l

And for the two Tamarin projects I used this command:

    
    find . \( -name "*.py" -or -name "*.as" -or -name "*.cpp" -or -name "*.h" -or -name "*.es" \)|xargs wc -l

