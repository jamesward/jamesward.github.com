---
author: admin
date: '2008-08-27 15:20:46'
layout: post
slug: flex-data-binding-performance-pitfall
status: publish
title: Flex Data Binding Performance Pitfall
wordpress_id: '388'
categories:
- Flex
---

A friend of mine recently asked me to help him troubleshoot some performance
problems with his Flex application. In his scenario he had a large list of
data and wanted to filter the data such that each time the search string grew
by a character the complex filter would only be run on the results of the
previous filter. A very simple approach to this is just to keep a record in
each item indicating if the item matched the filter for each search string.
Even though the filter function will still run for each item, the complex part
of the filter function could easily be isolated and only run for the subset of
data which matched the previous filter. This may not be the best way to do
this (I'm open to other suggestions) but it was simple. You can see the
results of my first attempt here:

[Demo 1](/fastFilterSubset/fastFilterSubset1.html) (Enter a few numbers in the
search field and see how many items are being filtered and how long it takes.)
[Source 1](/fastFilterSubset/srcview/source/fastFilterSubset1.mxml.html)

Notice that in order to keep track of how many items are reaching the main
part of the filter I increment a _Bindable_ variable inside the filter
function:

    
    [Bindable] private var ffCount:Number = 0;
    ...
    private function ff(item:Object):Boolean
    {
    ...
        ffCount++;
    ...
    }

  
Now since I've been programming in Flex for over four years you'd think I'd
know better. Every time a _Bindable_ object is modified Flex does a bunch of
event dispatching and other plumbing. In this case the Label which is bound to
the _ffCount_ variable is also doing a bunch of work each time _ffCount_
changes. As you can see, the results are not great. It takes almost a full
second (on my machine) to do the filter on 20,000 items. Obviously this isn't
right.

Lesson learned: A Flex application should never, ever, ever, update _Bindable_
objects in filter functions or other places where the user won't ever be able
to distinguish something changing that rapidly.

A better approach is to update a non-_Bindable_ variable in the loop or filter
function, then when the loop or filter is done, copy the non-_Bindable_
variable to a _Bindable_ one. You can see the updated demo using this approach
here:

[Demo 2](/fastFilterSubset/fastFilterSubset2.html) [Source
2](/fastFilterSubset/srcview/source/fastFilterSubset2.mxml.html)

This approach is about 10x faster! And only a little bit more work. In this
case it's very easy to be notified when the filter has completed and then
update the _Bindable_ variable:

    
    if (event.kind == CollectionEventKind.REFRESH)
    {
        ffCount = _ffCount;
    }

  
In retrospect this seems like a silly mistake but I would not be surprised if
this sort of thing is causing performance problems in many Flex applications.
Data Binding is a very powerful part of Flex but it can also cause performance
problems when used incorrectly. I hope this helps some of you to avoid this
pitfall. Let me know what you think.

