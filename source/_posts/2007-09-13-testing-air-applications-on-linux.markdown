---
author: admin
date: '2007-09-13 09:18:28'
layout: post
slug: testing-air-applications-on-linux
status: publish
title: Testing AIR Applications on Linux
wordpress_id: '167'
categories:
- Adobe AIR
- Linux
---

*** WARNING - THIS IS TOTALLY UNSUPPORTED, UNENDORSED, AND A COMPLETE HACK ***  
I tried for a while to get the actual Adobe AIR runtime installed via wine on
Linux. But I wasn't able to get it to work. Then I realized that I don't
really need the whole runtime to just test my AIR applications. All I need is
ADL - the testing tool for AIR applications. So I gave it a try on a
Salesforce.com project I'm working on:

`jamesw@dos:~/projects/mavericks/examples/air/AccountTracker/bin$ wine
~/flex_sdk-3_b1/bin/adl.exe salesforceTest-app.xml`

And to my total surprise the AIR application loaded and ran on Linux! Sweet!

