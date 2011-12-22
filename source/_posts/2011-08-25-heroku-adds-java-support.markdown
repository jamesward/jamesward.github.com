---
date: '2011-08-25 15:23:53'
layout: post
slug: heroku-adds-java-support
status: publish
title: Heroku Adds Java Support
wordpress_id: '2538'
categories:
- Heroku
- Java
---

Today [Heroku announced](http://blog.heroku.com/archives/2011/8/25/java/) that Java is now supported on the Heroku Cloud Application Platform!  This is incredibly exciting news and I'm very lucky to be a Heroku for Java Developer Evangelist!

Joining salesforce.com and jumping into the the Java Cloud space holds some nostalgia for me.  When I began using Java in 1997 I was working at an ISP in Denver.  We did the regular web hosting thing, but when the first Java Servlet engines (like Java Web Server 1.0) came out, I created the "wantjava.com" hosting service.  Things were really nasty at first.  We could only run one instance of the JWS on a server so I came up with a really bad way to do "multi-tenancy".  I setup a cron job to rsync the customers' .class files into the server's webapp and then restart the server.  Customers had to email me to get a servlet added to the web.xml file.  Uggg...  I feel like I need to go to confession for this.  But it worked and as the Servlet containers improved we quickly migrated to a more sustainable model.

Now thirteen years later I am privileged to once again be part of Java on the Cloud.  But this time around things are so much easier, better, and sexier!  Heroku is a leading the way in a new generation of application deployment that is making things much better for us Java developers.

## What is Heroku?

Shortly I will dive into how you can run Java on Heroku, but first, what is Heroku?  From my perspective, Heroku is a [Polyglot Cloud Application Platform](http://blog.heroku.com/archives/2011/8/3/polyglot_platform/).  Heroku provides us a way to run Ruby, Node.js, Clojure, and Java applications on a managed, scalable, and multi-tenant system.  Heroku also provides [numerous add-ons](http://addons.heroku.com) that help us make the [shift from monolithic middleware to Cloud Components](http://www.jamesward.com/2011/07/12/architectural-evolution-from-middleware-to-the-cloud).  Another way to say it is:

** Heroku = Polyglot + Platform as a Service (PaaS) + Cloud Components **

It is very exciting to see these three things coming together!  With Polyglot I can choose the right tool for the job.  With PaaS I don't have to think about managing operating systems, scalability, failover, etc.  And with the Cloud Component Architecture I can keep my app thin and focused on what is unique to the problem it needs to solve.  Heroku brings these models together as a cloud application platform.

## Running Java Apps on Heroku

Heroku can run any Java app that runs in OpenJDK 6.  Today Heroku uses Maven to create a "[slug](http://devcenter.heroku.com/articles/slug-compiler)" for Java apps.  That slug can then be loaded onto one or more "[dynos](http://devcenter.heroku.com/articles/dynos)".  You can tell a dyno to execute / start a Java app from the command line and you can also use a "[Procfile](http://devcenter.heroku.com/articles/procfile)" to provide a command that will auto-start for each instance of a specific dyno type.  Web dynos are able to listen on a port and will receive HTTP traffic through a load balancer that is automatically setup for each app.  With that background knowledge, lets dive into code!

For Dreamforce 2011, I (with the help of a few co-workers) put together a [Heroku for Java Workbook](http://github.com/heroku/java-workbook).  The Workbook provides detailed instructions on how to create web apps, connect to a database, setup worker processes, use the Redis to Go Heroku add-on, and use Spring Roo on Heroku.  But if you are anxious to get started and don't need as much hand-holding, here is a quick and very simple walk through of how to run Java on Heroku:

**Step 1)** Install the heroku command line client on [Linux](http://toolbelt.herokuapp.com/linux/readme), [Mac](http://toolbelt.herokuapp.com/osx/download), or [Windows](http://toolbelt.herokuapp.com/windows/download).

**Step 2)** Install [git](http://git-scm.com/) and setup your ssh key

**Step 3)** Install [Maven](http://maven.apache.org)

**Step 4)** Login to Heroku from the command line:

    heroku auth:login

**Step 5)** Create a new project directory and move into it:

    mkdir helloherokujava
    cd helloherokujava

**Step 6)** Create a Maven build file named `pom.xml` containing:

    
```xml
    <project xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://maven.apache.org/POM/4.0.0" xsi:schemalocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelversion>4.0.0</modelversion>
        <groupid>foo</groupid>
        <version>1.0-SNAPSHOT</version>
        <name>helloherokujava</name>
        <artifactid>helloherokujava</artifactid>
    </project>
```

**Step 7)** Create a Java source directory:

    mkdir -p src/main/java

**Step 8)** Create a new Java class in the `src/main/java` directory named `Hello.java` containing:

```java
    public class Hello
    {
      public static void main(String[] args)
      {
        System.out.println("hello, world");
      }
    }
```

**Step 9)** Compile the class:

    mvn compile

**Step 10)** Run the class locally:

    java -cp target/classes Hello

**Step 11)** Create a local git repo, add the `pom.xml` file & `src` dir, and commit the files:

    git init
    git add pom.xml src
    git commit -m init

**Step 12)** Create a new app on Heroku using the Cedar stack:

    heroku create -s cedar

**Step 13)** Upload your app to Heroku:

    git push heroku master

Heroku will create a slug for your app.

**Step 14)** Run the app on Heroku:

    heroku run "java -cp target/classes Hello"

Heroku will start a new dyno with your slug and then run the specified command.

You just ran Java on the cloud!  Obviously this is a very simple example.  But I like to start new things with the simplest thing that could possibly work.  Now that you have that working there is more to learn and much more power to harness!

## Next Steps

  * Go through the [Heroku for Java Workbook](http://github.com/heroku/java-workbook)
  * Go through the articles on the [Heroku Dev Center](http://devcenter.heroku.com/articles/java)
  * Ask questions about Heroku on [StackOverflow](http://stackoverflow.com)
  * Keep watching here for many more blogs about Java on Heroku

Have fun and please let me know if you have any questions about Heroku.
