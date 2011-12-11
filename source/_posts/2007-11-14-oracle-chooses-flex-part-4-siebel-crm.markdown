---
author: admin
date: '2007-11-14 13:32:04'
layout: post
slug: oracle-chooses-flex-part-4-siebel-crm
status: publish
title: Oracle Chooses Flex (part 4 - Siebel CRM)
wordpress_id: '197'
categories:
- Flex
- Oracle
---

Yesterday at Oracle OpenWorld I co-presented a session with Dipock Das on
Siebel CRM and Rich Internet Applications. Dipock and I talked about how Rich
Internet Applications are transforming the user experience in Enterprise
Software. We also presented a proof-of-concept I built with Flex in about two
days. Dipock and I were able to move from his paper-based mock-up and Siebel
data file to a working application with only two short conversations and two
days of coding. The application, named "Contact Radar", allows sales people to
easily see how long it has been since they were in contact with their
customers and potential customers. Ultimately we wanted to illustrate how my
[four axioms of Rich Internet Applications](/wordpress/2007/10/17/what-is-a
-rich-internet-application/) - Connected, Alive, Interactive, and Responsive -
relate to Enterprise Software.

Connected - We demonstrated that the same application can run as a desktop
application using Adobe AIR and as a web application using Flash Player. In
the POC we showed that a Flex application can easily run offline and integrate
with other offline concepts like native drag-and-drop to MS Office. The POC
also connected to a Siebel web service to get its data.

Alive - Dipock and I wanted to build an application with an interface that
felt alive. We integrated natural world experiences like movement, shadows,
translucency, and vectors deeply into the interface.

Interactive - There are many ways that we interact in the natural world -
voice, touch, sight, etc. One way we demonstrated this was to add
[Ribbit](http://www.goribbit.com/) calling straight into the application.

Responsive - In the natural world humans usually respond in less than a
second. Web applications however usually make us wait for much longer than a
second. In the POC we wanted to show how RIAs can have a sub-second response
time for data operations like loading, rendering, and filtering.

Dipock has given me permission to post the live POC here on my blog so that
everyone can see what we were able to quickly build in just two days. In order
to post the application I had to make a few small changes. First the Ribbit
calling has been disabled. We are also using a much smaller dataset because we
didn't want to give out the real dataset with all those real contacts. Also
since this version runs in the browser it doesn't have the offline features
that the AIR version has. Lastly remember that this was a POC built in two
days - there are bugs. Here is the app ([run it](/contactradar/oow.html)):

[![](http://www.jamesward.org/wordpress/wp-
content/uploads/2007/11/contact_radar.jpg)](/contactradar/oow.html)

There are still more amazing Flex applications from Oracle. Stay tuned.

