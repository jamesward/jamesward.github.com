---
author: admin
date: '2007-05-23 11:45:51'
layout: post
slug: salesforce-flex-apollo-sample-offline-data-sync
status: publish
title: Salesforce Flex / Apollo Sample - Offline Data Sync
wordpress_id: '123'
categories:
- Adobe AIR
- Flex
- Salesforce.com
---

On Monday I presented at the Salesforce Developer Conference in Santa Clara.
It was a great conference! The keynote was especially exciting because it
kinda turned into the Flex/Apollo show. Near the middle of his keynote Marc
Benioff went on about how great Adobe is for innovating with Flex and Apollo.
He then brought Kevin Lynch on stage who did his usual Apollo demos, which
filled the crowd with "Ooos" and "Ahhhs". Then they brought up someone who
built some amazing Salesforce based applications. And guess what? It was a
Flex app running inside a Salesforce S-Control! Then Adam Gross and Parker
Harris from Salesforce took the stage to present even more Flex applications!
It felt for a second like I was at [Max](http://www.adobemax2007.com/)!

I was pretty excited to see all the broad uses of the [Flex Toolkit for
Apex](http://wiki.apexdevnet.com/index.php/Flex_Toolkit) which has been the
catalyst for Salesforce jumping further into the Flex & Apollo world. The
Toolkit started as one of my "plane projects" where I took the existing
Salesforce JavaScript library and did regex replaces on the code, moved the
prototype stuff to proper classes, added static typing, and finally got the
thing to compile. Thanks primarily to Dave Carroll and Ron Hess from
Salesforce as well as Seth Hodgson from the Flex Data Services team, the
Toolkit evolved well beyond a "plane project" and is now being used in demos
and production applications!

Back to the conference... Throughout the day I stopped by the Adobe demo pod
to show demos and give out Apollo books. Dave Carroll and I also co-presented
a one hour session to a packed audience of about 250.

The use of Flex and Apollo in the Salesforce world is taking off! Like I said
in my session on Monday... Salesforce is revolutionizing how we build back-
ends! Flex & Apollo are revolutionizing how we build front-ends! Bringing
these two technologies together is a perfect match!

Now on to the Salesforce Apollo Sample...

[![](http://www.jamesward.org/wordpress/wp-content/uploads/2007/05/salesforce.
png)](http://www.jamesward.org/AccountTracker2.air)

[AccountTracker2.air - Apollo
Sample](http://www.jamesward.org/AccountTracker2.air) (Requires [Apollo
Alpha](http://www.adobe.com/go/apollo))

This Apollo application is one of the samples we are working on for the Flex
Toolkit for Apex. It has some cool offline data sync capabilities. However
currently the sync is only one way and some of the application is just smoke
and mirrors (the chart data is fake because I was in crunch mode getting this
ready for the Web 2.0 conference). But it really does pull most of its data
from Salesforce.com and syncs data and files to the local system so that it
works offline. I can't take credit for much of this application. I did some
polishing but most of the work was done by Dave Carroll and Ron Hess from
Salesforce. They have both put in a ton of work to the Toolkit and the
samples. So big thanks to them!

If you want to see how to start building Flex and Apollo applications using
the Flex Toolkit for Apex, check out these resources:
[http://www.jamesward.org/wordpress/2007/04/17/the-open-source-flex-and-
apollo-toolkit-for-
salesforcecom/](http://www.jamesward.org/wordpress/2007/04/17/the-open-source-
flex-and-apollo-toolkit-for-salesforcecom/) [http://wiki.apexdevnet.com/index.
php/Flex_Toolkit](http://wiki.apexdevnet.com/index.php/Flex_Toolkit) [http://w
iki.apexdevnet.com/index.php/Tutorial:_Creating_Flex_Salesforce_Mashups](http:
//wiki.apexdevnet.com/index.php/Tutorial:_Creating_Flex_Salesforce_Mashups)

