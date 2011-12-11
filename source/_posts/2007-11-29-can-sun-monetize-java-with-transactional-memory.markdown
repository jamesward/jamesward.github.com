---
author: admin
date: '2007-11-29 17:45:16'
layout: post
slug: can-sun-monetize-java-with-transactional-memory
status: publish
title: Can Sun Monetize Java with Transactional Memory?
wordpress_id: '184'
categories:
- Java
---

Admittedly I know very little about concurrent computing. But the consensus
seems to be that it's the future. We can't keep building faster CPUs so we are
just going with more of them. This presents a problem for software that can't
easily be split into pieces. If some CPU intensive piece of code can't be
chopped up to run in parallel then it is constrained by the speed of a single
CPU. So what is the solution? Some think that the programming models need to
change to better accommodate parallel computing. The problem is that no matter
how smart the programming model is at splitting stuff up you are always going
to be blocked by IO operations - memory, ram, network, etc. Others think that
one solution may be [Transactional
Memory](http://en.wikipedia.org/wiki/Transactional_memory). This can
potentially alleviate the problem of threads waiting for locks.

Allegedly Sun is working on implementing Transactional Memory in their next
generation of processors. Now what if the Sun Java Virtual Machine were tuned
to run unbelievably fast on these new processors? One missing piece to this
theory is the programming model. I haven't done a lot of concurrent
programming but I hear it's quite difficult to get right in Java.
[Allegedly](http://www.artima.com/weblogs/viewpost.jsp?thread=214627) the
concept of Agents in Scala (which runs on the JVM) makes concurrent
programming much easier. Combine Agents with Transaction Memory and a JVM
tuned to take advantage of it and maybe we could see a significant performance
boost associated with the multi-core/cpu machines.

I've always liked Sun hardware but with the low cost of Intel and AMD hardware
the additional cost may not seem worth it. However if Sun hardware ran my Java
10x faster I'd be totally sold. Now that is an interesting way for Sun to
monetize Java... At least for a while.

