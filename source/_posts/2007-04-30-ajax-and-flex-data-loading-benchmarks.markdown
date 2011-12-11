---
author: admin
date: '2007-04-30 09:42:30'
layout: post
slug: ajax-and-flex-data-loading-benchmarks
status: publish
title: Ajax and Flex Data Loading Benchmarks
wordpress_id: '110'
categories:
- Ajax
- Flex
- Open Source
---

For close to a year I've been working (in my infrequent spare time) on an
application that shows differences in data loading for RIAs (Rich Internet
Applications), comparing Ajax methods, Ajax frameworks, and various Flex
methods. The results are pretty surprising. The screenshot below is from a
test run I did with the server running locally. (Note for the screenshot
below: All tests except Dojo were 5000 rows, while the Dojo test was 500
rows.) [![](http://www.jamesward.org/wordpress/wp-
content/uploads/2007/04/census.png)](http://www.jamesward.org/census/)

To run the benchmarks yourself, go to:
[http://www.jamesward.org/census/](http://www.jamesward.org/census/)

I have tried to be as fair as possible with these tests. Still, I encourage
you to use these results only as an initial guide. You should always do your
own benchmarks that more closely resemble your actual use case.

You can find more details explaining the tests and the results inside the
"Guide Me" mode of the application, so I won't go into depth here. Also, [the
code](http://sf.net/projects/flexapps) is Open Source (GPL) on SourceForge. If
you feel that a test should be done differently or you find other things that
you think should be changed, get the code, fix it, and send me a patch file.
Please don't just tell me I did something wrong. In the spirit of Open Source,
help me fix it. I want this application to be as fair and accurate as
possible.

While these results may be eye-opening to some, once you understand some
fundamental differences between Flex and Ajax, they end up making a lot of
sense. Flex applications run within the Mozilla Tamarin VM inside Flash 9.
Tamarin does JIT compilation which makes code execution 10 to 1000 times
faster than interpreted JavaScript in the browser. Also Tamarin can be very
efficient when dealing with typed objects.

In addition, Flex supports a compact binary object serialization protocol,
called AMF3, which is extremely fast. There are numerous Open Source
implementations using various backend technologies for AMF3, as well as a
commercial / supported Adobe product, called Flex Data Services. If you
control both sides of the wire in your application, then there is rarely a
good reason to serialize and deserialize text. Objects are blazing fast as you
can tell by this benchmark. AMF3 is also typically much more efficient across
the wire (even without compression) and consumes much less client side memory.
JIT compilation and binary object serialization are the primary reasons why
Flex AMF3 is so fast, even in the test with the full 20,000 rows. And, it’s
not just faster for loading - it also speeds client side sorting and
filtering. (Try client-side sorting in the Dojo benchmark and the Flex AMF
benchmark.)

A quick note on compression: I did not include compression support in this
version because its value really depends on many application-specific factors.
For instance, if most of your users have slow connections then compression can
help speed things up, but if most have fast connections the added latency can
actually make things slower. However, I do want to add a Gzip option to this
benchmark for the next release.

This is really a version 0.1 release. There are many improvements I have on
the to-do list. And I'd love the community's help. Here are some things I want
to do for the 0.2 release: - Add Gzip option on tests - Add a Laszlo test -
Implement more Ajax frameworks that have DataGrids and that support paging and
sorting - Add a server side sorting option - Add Ajax client side memory usage
metrics (don't know if this is possible) - Improve the UI for use on
projectors (I use this demo in every presentation I give) - Integrate feedback
I get from the initial version - Maybe add a WPF/E test (which I won't be able
to do because I run Linux)

I sincerely hope that you find this demo useful. I built it as a tool to help
people learn more about the various methods of data loading in RIAs. I did not
in any way build this to attack Ajax, Dojo, and SOAP. Please help me improve
this application so that we all continue to learn more about the technologies
available to us.

