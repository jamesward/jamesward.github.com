---
author: admin
date: '2011-11-28 12:20:43'
layout: post
slug: using-apache-tomcat-on-heroku
status: publish
title: Using Apache Tomcat on Heroku
wordpress_id: '2802'
categories:
- Heroku
- Java
---

One great thing about Heroku is the freedom to use any APIs and any
application server. On Heroku you bring your application server with you. The
easiest way to do this is by specifying your app server as a dependency of
your application. This allows for maximum control and avoids the pain
associated with developer and production environments using different versions
of the container.

Most of the articles that have been written about running Java on Heroku use
embedded Jetty since it's lightweight and easy to specify as a dependency. But
you can also use [Apache Tomcat](http://tomcat.apache.org/) in the same way.
There is now a great article on the [Heroku Dev
Center](http://devcenter.heroku.com/) that walks you through how to do it.
Check it out:

**[Create a Java Web Application using Embedded Tomcat](http://devcenter.heroku.com/articles/create-a-java-web-application-using-embedded-tomcat)**  
If you want to get started with a simple demo application on Heroku then try a
little app that I'm working on:

**[http://java.herokuapp.com/](http://java.herokuapp.com/)**  
Just select the demo you want (like "Simple Web App with Maven and Tomcat"),
put in your email address, and a clone of the demo will be created and
deployed on Heroku that is all yours to play with. Let me know what you think.
Thanks!

