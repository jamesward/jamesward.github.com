---
date: '2010-12-06 14:16:02'
layout: post
slug: p2p-in-desktop-mobile-and-tablet-flex-apps
status: publish
title: P2P in Desktop, Mobile, and Tablet Flex Apps
wordpress_id: '2103'
categories:
- Adobe AIR
- Flex
- Mobile
tags:
- flexorg
---

Using the open source Flex SDK, developers can easily build desktop, mobile, and tablet applications that use Peer to Peer (P2P) communication.  I've created a video that walks through demos and code illustrating how to use the P2P APIs in Adobe AIR applications.  Check it out:

<object width="640" height="505"><param name="movie" value="http://www.youtube.com/v/IwCOwfwUp4w?fs=1&amp;hl=en_US&amp;rel=0"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/IwCOwfwUp4w?fs=1&amp;hl=en_US&amp;rel=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="640" height="505"></embed></object>

Grab the code for the demos in the video from [github](http://github.com/jamesward):

  * [P2Pong](https://github.com/jamesward/P2Pong)
  * [P2Hancock](https://github.com/jamesward/P2Hancock) (Signature capture over P2P)

Just as the video shows, it's incredibly easy to use the P2P APIs.  Here is a quick walk through.  First create a new NetConnection that is connected to "rtmfp:" like so:

```actionscript    
    localNc = new NetConnection();
    localNc.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
    localNc.connect("rtmfp:");
```

In the netStatus event listener wait for the "NetConnection.Connect.Success" event and then set up the NetGroup:

```actionscript
    private function netStatus(event:NetStatusEvent):void
    {                        
        switch(event.info.code)
        {
            case "NetConnection.Connect.Success":
                setupGroup();
                break;
        }
    }
    
    private function setupGroup():void
    {
        var groupspec:GroupSpecifier = new GroupSpecifier(GROUP_ID);
        groupspec.ipMulticastMemberUpdatesEnabled = true;
        groupspec.multicastEnabled = true;
        groupspec.routingEnabled = true;
        groupspec.postingEnabled = true;
        
        // This is a multicast IP address. More info: http://en.wikipedia.org/wiki/Multicast_address
        groupspec.addIPMulticastAddress("239.254.254.2:30304");
                            
        netGroup = new NetGroup(localNc, groupspec.groupspecWithAuthorizations());
        netGroup.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
    }
```

Now handle a "NetGroup.SendTo.Notify" event when a message is received over the P2P connection:

```actionscript
    // in the netStatus switch block
    case "NetGroup.SendTo.Notify":
        var data:Object = event.info.message;
        break;
```

And finally to send a P2P message to everyone who is listening simply do:

```actionscript    
    netGroup.sendToAllNeighbors(objectToSend);
```

That's it!  Super simple and super fun!  :)

Thanks to [Tom Krcha](http://www.flashrealtime.com/) for all of his great blogs on how to do this.  Also thanks to Mark Dong and [James Li](http://jamesli.cn/blog/) (Flash Platform Evangelists in China) for helping me build P2Pong.
