---
date: '2010-10-11 14:33:36'
layout: post
slug: data-paging-in-flex-4
status: publish
title: Data Paging in Flex 4
wordpress_id: '2039'
categories:
- Flex
tags:
- flexorg
---

I know -- you've heard it from me before -- [AMF rocks!](http://www.jamesward.com/2009/06/17/blazing-fast-data-transfer-in-flex/)  With AMF you can load massive amounts of data into your Flex ([or JavaScript](http://www.jamesward.com/2010/07/07/amf-js-a-pure-javascript-amf-implementation/)) apps very quickly.  This can often obviate the need for paging data.  But what if you have lots, and lots, and lots of data?  Well then you should use data paging.  And here is how...

There is a new collection wrapper class in Flex 4 called "[AsyncListView](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/mx/collections/AsyncListView.html)".  The UI data controls in Flex 4 know how to handle an AsyncListView as a dataProvider.  The purpose of the AsyncListView is to give you a callback when the underlying list throws an [ItemPendingError](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/mx/collections/errors/ItemPendingError.html).  The ItemPendingError indicates that an item that the list thinks it has isn't really there yet.  This allows you to then load the data and update the list.  In order to throw an ItemPendingError you need to keep track of which items haven't been loaded and then, when an item is requested that isn't really there, throw the ItemPendingError.  Here is some code from my [PagedList](http://github.com/jamesward/DataPaging/blob/master/src/PagedList.as) implementation:

```actionscript
    public function getItemAt(index:int, prefetch:int = 0):Object
    {
        if (fetchedItems[index] == undefined)
        {
          throw new ItemPendingError("itemPending");
        }
    
        return _list.getItemAt(index, prefetch);
    }
```

In my main application I just create a PagedList, set its length (which should really be done by a remote call instead of manually), and then assign the instance of PagedList to the list property on my instance of AsyncListView.  With MXML this looks like:

```mxml
<local:PagedList id="items" length="100000"/>
<s:AsyncListView id="asyncListView" list="{items}" createPendingItemFunction="handleCreatePendingItemFunction"/>
```

When the ItemPendingError is thrown, the handleCreatePendingItemFunction is called.  Now I just figure out what page of data is needed, make sure that there isn't already a pending request for that page, and then make the request.  When the response comes back I simply update the underlying collection.  Here is the code that does that:

```actionscript
    private function handleCreatePendingItemFunction(index:int, ipe:ItemPendingError):Object
    {
      var page:uint = Math.floor(index / pageSize);
      if (fetchedPages[page] == undefined)
      {
        var numItemsToFetch:uint = pageSize;
        var startIndex:uint = pageSize * page;
        var endIndex:uint = startIndex + pageSize - 1;
        if (endIndex > items.length)
        {
          numItemsToFetch = items.length - startIndex;
        }
        var asyncToken:AsyncToken = ro.getElements(startIndex, numItemsToFetch);
        asyncToken.addResponder(new AsyncResponder(function result(event:ResultEvent, token:Object = null):void {
          for (var i:uint = 0; i < event.result.length; i++)
          {
            items.setItemAt(event.result[i], token + i);
          }
        }, function fault(event:FaultEvent, token:Object = null):void {
        }, startIndex));
        fetchedPages[page] = true;
      }
      return null;
    }
```

In this example I'm using RemoteObject (AMF) but this could be anything (HTTPService, WebService, etc.) as long as there is a method on the back end that lets me set the starting location and the page size.

Here is a simple demo of data paging using the new Spark DataGrid in Flex Hero.  The page size is 100 and there are 100,000 total items.

<iframe src="http://www.jamesward.com/demos/DataPaging/DataPaging.html" width="100%" height="400"></iframe>

[Fork or view the code](http://github.com/jamesward/DataPaging) for this example on [github.com](http://github.com).

Of course another option for doing data paging more automatically is with LiveCycle Data Services.  Check out a great example of [Data Paging with LCDS in Tour de Flex](http://www.adobe.com/devnet-archive/flex/tourdeflex/web/#sampleId=13850;illustIndex=0;docIndex=0) to learn more about that.

A big thanks to [Mike Labriola](http://blogs.digitalprimates.net/codeSlinger/) for helping me figure this out!  Please let me know if you have any questions about this.
