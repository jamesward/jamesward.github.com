---
author: admin
date: '2009-07-22 08:47:49'
layout: post
slug: protected-messaging-in-flex-with-blazeds-and-lcds
status: publish
title: Protected Messaging in Flex with BlazeDS and LCDS
wordpress_id: '1068'
categories:
- BlazeDS
- Flex
- LCDS
---

UPDATE: BlazeDS 4 and LCDS 3.1 now have built-in support to [disallow
subscriptions to wildcard
subtopics](https://bugs.adobe.com/jira/browse/BLZ-415). Just set the following
parameter on the messaging destination's server properties:

    
    false

You no longer need to use the ProtectedMessagingAdapter from the code examples
below in order to protect your messages.

One of the great things about Flex is how easy it is to set up publish and
subscribe messaging using BlazeDS, LCDS, or other various server technologies.
Basically a Flex application can be either a Consumer of messages from the
server, a Producer of messages to the server, or both. The channels that are
used for the actual transport can vary dramatically depending on the needs.
[Here is a great blog](http://devgirl.wordpress.com/2009/07/14/livecycle-data-
services-channels-and-endpoints-explained/) that explains the different
transports. No matter what transport / channel is used the API in Flex is the
same. If you'd like to see how to use those APIs check out [this
video](http://www.jamesward.com/blog/2008/07/21/video-flex-and-java/) I
recorded.

Many times with pub/sub messaging the messages should only be sent to a subset
of the subscribers. There are two ways to achieve this in Flex - either using
a subtopic or a selector. Subtopics allow simple dot separated expressions
such as "stocks.ADBE" which would allow Flex clients to subscribe to only
messages about the ADBE stock. A Flex client could also subscribe to wild card
subtopics like "stocks.*" or "*". The developer usually hard codes the
subtopics (if any) that an app will use.

Subtopics seem like a great way to send point-to-point or point-to-group
messages. To send a message to a particular client it's as easy as setting the
subtopic of the message to a special complex token - usually a generated UID
or the server's session ID. The subscriber then subscribes to a subtopic with
that particular complex token and none of the other clients listening on that
messaging destination will receive that message. Or maybe they can...

A malicious developer could easily determine the endpoint being used by an
application. After discovering this they could also very easily create a Flex
application that subscribes to the "*" subtopic of a messaging destination.
Then the server would send them ALL of the messages on all of the subtopics
for that destination. Pretty scary stuff. To see an example of this follow
these steps:

  1. Open the [test application](/protectedMessaging/protectedMessaging.html)
  2. Open the [hacker application](/protectedMessaging/HackerApp.html)
  3. Click the send button in the test application
  4. Watch the message appear in the regularDestination output panel of the hacker application
  
Both panels use the same messaging API and same subtopic to send and receive
messages. However the protectedDestination uses a customized Messaging Adapter
that doesn't allow subscriptions to subtopics containing a wild card ("*").
Here is the Java code for the ProtectedMessagingAdapter:

    
    package com.jamesward;  
    import flex.messaging.services.messaging.Subtopic;
    import flex.messaging.services.messaging.adapters.ActionScriptAdapter;  
    public class ProtectedMessagingAdapter extends ActionScriptAdapter
    {  
      public boolean allowSubscribe(Subtopic subtopic)
      {
        return !(subtopic.containsSubtopicWildcard());
      }  
    }

  
Here is an example of how to use the new adapter in the messaging-config.xml
file:

    
    
      
        
            
          
        
            
          
        
            
            
                
                    true
                    .
                
            
          
    

  
If you are using subtopics (or selectors) to protect messages from being sent
to the wrong people then I highly recommend that you use my
ProtectedMessagingAdapter or something else so that malicious hackers can't
snoop on private messages or send impostor messages. In my demo I run both the
test app and hacker app on the same server but this can be done in other ways
(such as proxy servers or local apps). Also authentication may not protect you
because a malicious user might also be an authenticated user. So the only
solution is to really protect destinations from subscriptions to wild card
subtopics.

I hope this is helpful for those using messaging. Let me know what you think.

