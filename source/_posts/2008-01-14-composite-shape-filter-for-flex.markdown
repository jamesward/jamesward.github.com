---
date: '2008-01-14 13:59:33'
layout: post
slug: composite-shape-filter-for-flex
status: publish
title: Composite Shape Filter for Flex
wordpress_id: '234'
categories:
- Flex
---

Recently a friend asked me how to work around a visible depth issue in Flex.  The problem is that a drop shadow and other filters only work on objects that are on the same plane .  Suppose you have one object inside a Panel and another object "floating" outside of the panel but next to the object in the Panel.  Everything works fine and these objects may appear next to each other until you add a filter to the objects.  As you can see in the top example below, the drop shadow from the box outside of the Panel overlaps the box inside the Panel.  What we would like to see is one contiguous drop shadow around both objects.

[![compositeshapefiltertest.jpg](http://www.jamesward.org/wordpress/wp-content/uploads/2008/01/compositeshapefiltertest.jpg)](http://www.jamesward.org/CompositeShapeFilterTest/CompositeShapeFilterTest.html)

I created a really simple way to deal with this issue.  The solution is to not apply the drop shadow directly to the boxes but to a hidden copy of the boxes and then float that drop shadow above both boxes.  To do this I created a simple class called CompositeShapeFilter.  You can see the end result of this experiment [here](http://www.jamesward.org/CompositeShapeFilterTest/CompositeShapeFilterTest.html) or check out the source code [here](http://www.jamesward.org/CompositeShapeFilterTest/srcview/index.html).  There might be an easier / better way to do this that I'm not aware of.  Let me know what you think.
