---
author: admin
date: '2011-07-12 11:10:22'
layout: post
slug: architectural-evolution-from-middleware-to-the-cloud
status: publish
title: 'Architectural Evolution: From Middleware to The Cloud'
wordpress_id: '2455'
categories:
- Cloud
- Java
---

You've heard it said that "all things old are new again." That statement can
certainly be applied to the current Cloud hype. But each time the old becomes
new it gets a bit better because of what was learned the last time around. If
we look back ten years at enterprise application development in Java things
were quite different than they are today. EJB was "the way" to build scalable
systems from a vast abundance of components. But things didn't work out as
well as the vendors planned.

**EJB Component Architecture**  
I remember back in the early days of enterprise Java everyone was talking
about "Components." Application complexity would be greatly reduced because
there would be components for everything! Need to connect your app to
Exchange? Well, there's a component for that. Does your app need to send
email? No problem, there are twenty components for that! Component
marketplaces flourished with VC funding galore.

The official way to build reusable Java components became standardized as
_Enterprise Java Beans_ (EJB). These "beans" could be accessed either locally
or remotely! Vendors led us to believe this was the panacea of Lego-style
application development. Just grab pieces from every-which place and hook them
together. Hooking the components together required a heavyweight "Middleware"
server. Here is what Monolithic Middleware with EJBs looks like: ![](http://ww
w.jamesward.com/wp/uploads/2011/07/MiddlewaretoCloudServices_j2ee.png)

But the EJB Component Architecture didn't work. Billions of dollars were spent
on components and the middleware to tie them all together. And now I bet you
can't find a single person that doesn't regret going that route. Why? Three
primary reasons...

  1. The programming model was too hard. The EJB programming model consisted of too much boilerplate code ("solved" through code-gen tools like xdoclet). EJB's also required configuration which was often middleware server-specific. The EJB Component Architecture creates too many layers of indirection ([Core J2EE Patterns](http://java.sun.com/blueprints/corej2eepatterns/) anyone?).
  2. Scalability was too hard. EJBs can either run inside your container (using what is called a "Local Interface") or somewhere else (a "Remote Interface"). Using Local Interfaces is fast but causes middleware to run into memory limits and scaling bloated app servers is challenging. Using Remote Interfaces leads to massive serialization and routing overhead and whatever is on the remote end of the wire is still a pain to scale.
  3. Deployment was too hard. Remember the days when starting up an app server / middleware container took minutes not seconds?
  
If you need further proof that the middleware model didn't work then just try
to name one place you can still go to buy an EJB component today. Obviously we
needed another way to compose the parts of an application.

**POJO Component Architecture**  
SpringSource deserves a lot of credit for pulling us out of the EJB muck. They
created a model where the application pieces are _Plain Old Java Objects_
(POJOs) injected into an application. This led to better testability, much
easier deployment, and a much better programming model. Essentially the
revolution of Spring was to make all those app pieces injectable dependencies.
This was a huge step forward. But there are still some limitations with this
model that are currently being addressed by the next revolution. The three
primary challenges with the POJO Component Architecture are:

  1. Isolation is too hard. It is now very easy to throw a bunch of components together into a single Web application ARchive (WAR). But at some point all of these pieces being stacked on top of each other make our application brittle and difficult to piece together. What do you do when the version of Hibernate you want to use requires a different version of an Apache Commons library than the version of XFire that you want to use? Or when two libraries that your app needs actually require conflicting dependencies. Sometimes isolating the pieces of an application is actually simpler than injecting them. And unfortunately with POJOs you may not be able to easily switch from using a "Local Interface" to an external "Remote Interface" like you can with EJBs.
  2. Polyglot is too hard. The POJO components we use today in our systems are not inherently supportive of a Polyglot world where different parts of a system may be built using different technologies. Suppose your system has a rules engine and you want to access it from a Java-based application and a Ruby-based application. Today the only way to do that is to proxy that component and expose it through an easily serialization protocol (likely XML or JSON over HTTP). This will likely add unnecessary complexity to your system. When the high-level functional pieces of a system are technology-specific the entire system may be forced to use that technology or those pieces may exist multiple times to support the Polyglot nature of today's systems.
  3. Scaling is still too hard. As we continue to stack more pieces on top of each other it becomes harder to stick with simple, lightweight share-nothing architectures where each piece is individually horizontally scalable.
  
**Cloud Component Architecture**  
The emerging solution to the challenges we have faced with the EJB and POJO
Component Architectures is the Cloud Component Architecture. Instead of
bundling components for things like search indexing, distributed caching,
SMTP, and NoSQL data storage into your application those high level functions
can instead be used as Cloud Components. There are already numerous vendors
providing "Component as a Service" products like MongoDB, Redis, CouchDB,
Lucene Search, SMTP, and Memcache.

SMTP / outbound email is a simple example where the Cloud Component
Architecture makes a lot of sense. With the EJB and POJO Component
Architectures I'd find a SMTP component that simply sends email. Then
configure my server to be able to send emails that aren't considered spam. I'd
also need to deal with constant blacklisting challenges and a larger
management surface. Or in a Cloud Component Architecture I could simply sign-
up with one of the SMTP as a Service providers like
[AuthSMTP](http://www.authsmtp.com/) or [SendGrid](http://sendgrid.com/) and
then just use the Component as a Service.

Here is what the new Cloud Component Architecture for application composition
looks like: ![](http://www.jamesward.com/wp/uploads/2011/07/MiddlewaretoCloudS
ervices_csa.png)

The top six benefits of the Cloud Component Architecture are:

  1. Simple scalability. By making each functional piece of an application an independent and lightweight service they can each be horizontally scaled without impacting the overall application architecture or configuration. If you chose to use a vendor's Component as a Service then they will handle the scalability of those pieces. Then you only need to scale a very thin web layer. Composing Cloud Components also makes it easier to stick with a share-nothing architecture that is much easier to scale than the traditional architectures.
  2. Rapid composition. Cloud Components are flourishing! Most of the basic building blocks that applications need are now provided "as a Service" by vendors who maintain and enhance them. This is a much more erosion-resistant way to assemble applications when compared to the typical abandon-ware which is prevalent with many Java components. Many of the emerging Cloud Components also provide client libraries for multiple platforms and RESTful APIs to support easy composition in Polyglot systems.
  3. Reduced management surface. With Cloud Components you can reduce the number of pieces you must manage down to only the stuff that is unique to your app. Each Cloud Component you add doesn't enlarge the management surface like it does in typical component models where you own the implementation of the component.
  4. Simple Deployment. One of the biggest benefits of using the Cloud is the ease of deployment. Partitioning the functional pieces of an application makes it thinner and easier to deploy. With Cloud Components you can also setup development and staging instances that make it easy to simulate the production environment. Then moving from one environment to another is simply a matter of configuration.
  5. Better Security. In most application architectures today there is one layer of security. This would be like a bank without a vault. There are a few ways into the bank that are wrapped with security (doors with locks) but as soon as someone has found a way in, they have access to everything. With Cloud Components security can be more easily distributed to provide multiple layers of security.
  6. Manageable costs. With Cloud Components your costs can scale with your usage. This means it's easy to get started and grow rather than make large up-front investments.
  
The Cloud Component Architecture may seem similar in ways to the old EJB and
POJO Component Architectures because it is similar! The wheel has not been
reinvented, just improved. The dream of Lego-style application assembly is now
being realized because we've come full circle on some old ideas from twenty
years ago ([CORBA](http://en.wikipedia.org/wiki/Corba) anyone?). This time
around those ideas are reality thanks to the evolution of many independent
pieces like REST, Polyglot, and the Share-Nothing pattern. Cloud Components
are the foundation of a new era of application development. My only question
is... How long before we see the [UDDI](http://en.wikipedia.org/wiki/UDDI)
idea again? ;)

