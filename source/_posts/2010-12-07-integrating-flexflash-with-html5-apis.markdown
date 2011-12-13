---
date: '2010-12-07 13:36:43'
layout: post
slug: integrating-flexflash-with-html5-apis
status: publish
title: Integrating Flex/Flash with HTML5 APIs
wordpress_id: '2116'
categories:
- Flex
- HTML5
tags:
- flexorg
---

Beyond the media hype about Flash _versus_ HTML5 exists the reality of coexistence and cooperation.  This coexistence and cooperation makes the web a better place.  When developers combine the strengths of Flash with the strengths of HTML, users get the best possible experiences on the web.

Both HTML and Flash are important foundations that Adobe builds its products on.  Here's a little secret about Adobe's business model...  When new versions of those platforms come out, so do new versions of the tools for building on them.  And guess what Adobe makes money on...  Tools.  So it is true that [Adobe loves Flash **AND** HTML5](http://www.infoworld.com/d/developer-world/microsoft-adobe-proclaim-their-love-html5-775).  :)

In the world of coexistence and cooperation (that is the technical reality) we find some really exciting things.  One such thing is [Jangaroo](http://www.jangaroo.net/home/index.html) an open source project that cross-compiles ActionScript to JavaScript.  This means that you can build applications in ActionScript (and eventually MXML) and cross-compile those applications to run in places where Flash doesn't exist.  And you can even use [Adobe tools](http://www.adobe.com/products/flashbuilder/) to help you write that ActionScript.  :)

Another quick example I whipped up is a proof-of-concept of how you can integrate Flex applications with the new HTML5 [session history and navigation APIs](http://www.w3.org/TR/html5/history.html) (pushState, replaceState, and so on).  In a sufficiently modern browser (such as Chrome, Firefox 4, or Safari) open the following demo in a new tab / window:
[http://www.jamesward.com/demos/FlexReplaceState/app](http://www.jamesward.com/demos/FlexReplaceState/app)

As you click on tabs notice that the URL changes without page refresh and without resorting to the use of named anchors / hashes.  Also notice that page refresh, back, and forward all work.  Check out the [source for the demo on github](https://github.com/jamesward/FlexReplaceState).  That is the kind of cooperation and integration we will continue to see more of as HTML5 matures.  I'm excited to see the web become a better place as HTML and Flash both mature!
