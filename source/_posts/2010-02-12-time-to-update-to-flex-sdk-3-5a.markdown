---
author: admin
date: '2010-02-12 12:44:40'
layout: post
slug: time-to-update-to-flex-sdk-3-5a
status: publish
title: Time to Update to Flex SDK 3.5a
wordpress_id: '1538'
categories:
- Adobe AIR
- BlazeDS
- Flex
---

If you are using a Flex SDK before 3.5a then it's probably time to update.
Flex SDKs before 3.4 have a [security vulnerability](http://www.adobe.com/supp
ort/security/bulletins/apsb09-13.html). I believe the problem is actually in
the HTML template, so when you update make sure that you also update the HTML
templates that you are using. The Flex SDK 3.4 had the [double responder
bug](https://bugs.adobe.com/jira/browse/SDK-22883). And the initial release of
Flex SDK 3.5 had a [bug with AIR's
ApplicationUpdaterUI](https://bugs.adobe.com/jira/browse/SDK-24766). If you
overlay your own AIR SDK on top of the Flex SDK then be aware that you will
actually be overwriting the ApplicationUpdaterUI fix (comments in the bug
report discuss how to deal with that).

So it's time to move to the [latest Flex SDK
3.5a](http://opensource.adobe.com/wiki/display/flexsdk/Download+Flex+3)!

Also, if you are using BlazeDS, LCDS, or FDS then it's time to update that as
well due to [a security
vulnerability](http://www.adobe.com/support/security/bulletins/apsb10-05.html)
that was published yesterday.

