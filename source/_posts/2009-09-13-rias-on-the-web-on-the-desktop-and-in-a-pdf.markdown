---
date: '2009-09-13 14:30:51'
layout: post
slug: rias-on-the-web-on-the-desktop-and-in-a-pdf
status: publish
title: RIAs on the Web, on the Desktop, and in a PDF
wordpress_id: '1200'
categories:
- Adobe AIR
- Flash Player
- Flex
- PDF
---

Some believe that the "Internet" in "rich Internet application" (RIA) means that RIAs must only run in the browser.  However my [definition of RIA](http://www.jamesward.com/blog/2007/10/17/what-is-a-rich-internet-application/) is not constrained to only web-based applications.  RIAs can run anywhere: web, desktop, mobile devices, TVs, or even [inside PDFs](http://www.jamesward.com/blog/2008/11/05/portable-rias-flex-apps-in-pdfs/).  Ideally we should have some level of code and library reusability between these environments.  However to think that we can reuse the entire application is a pipe dream.  Client capabilities and end user needs vary too greatly between these mediums.

I wanted to build an application in Flex that shows how applications can have a high degree of reuse between the web, the desktop, and in a PDF.  I decided to build a Mortgage Calculator to illustrate this.  Here is the web widget:

<iframe src="/mortgageCalc/mortgageCalcWeb.html" width="100%" height="540"></iframe>

From within the web widget you can install the desktop widget or email yourself a PDF containing the widget.  Since this application is a small, self contained application (i.e. a widget) the functionality between the different mediums is very similar.  In this case I was able to reuse about 99% of the code between the different versions.  However, sometimes achieving that level of reuse is not possible due to the differences in client capabilities and the end user needs.  This is the case with the Flex and Adobe AIR based [Oracle CRM Gadgets](http://www.oracle.com/applications/crm/siebel/crm-gadgets.html), which are for different use cases than the primary Siebel UI.

There are beginning to be more instances where RIA widgets are being reused across different mediums.  But this is only one piece of software development.  In other instances the capabilities and functionality of web, desktop, and mobile applications vary so greatly that there is little reuse.  Either way it's important to architect our back ends such that they are agnostic to the front end.  This is one of the ways RIA and mobile app development have changed the way we build software.  It's a good thing and we should embrace it.
