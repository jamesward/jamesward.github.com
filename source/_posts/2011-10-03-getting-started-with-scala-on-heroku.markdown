---
date: '2011-10-03 14:24:32'
layout: post
slug: getting-started-with-scala-on-heroku
status: publish
title: Getting Started with Scala on Heroku
wordpress_id: '2595'
categories:
- Heroku
- Scala
---

Over the past year I've been gradually learning Scala and I think it's fantastic!  So I'm incredibly excited that [Scala now runs on Heroku](http://blog.heroku.com/archives/2011/10/3/scala/)!  Of course you can use the standard [Java on Heroku](http://www.jamesward.com/2011/08/25/heroku-adds-java-support) / Maven method of running Scala on Heroku.  But as of today you can also use [sbt](https://github.com/harrah/xsbt) (the Scala Build Tool) to run Scala apps on Heroku.  If you are new to Heroku, it is a Polyglot Cloud Application Platform.  Put very simply:

**Heroku = Polyglot + Platform as a Service (PaaS) + Cloud Components**

If you want to try out Scala on Heroku, here are a few quick steps to get you started:

** Step 1)** [Create a Heroku account](http://heroku.com/signup)

** Step 2)** Install the Heroku command line client on [Linux](http://toolbelt.herokuapp.com/linux/readme), [Mac](http://toolbelt.herokuapp.com/osx/download), or [Windows](http://toolbelt.herokuapp.com/windows/download).

** Step 3)** Install [git](http://git-scm.com/) and setup your SSH key

** Step 4)** Install [sbt](https://github.com/harrah/xsbt/wiki/Setup) 0.11.0

** Step 5)** Login to Heroku from the command line:

    heroku auth:login

** Step 6)** Create a file named `build.sbt` containing:

```scala
    scalaVersion := "2.9.1"
    {
      val stage = TaskKey[Unit]("stage", "Prepares the project to be run, in environments that deploy source trees rather than packages.")
      stage in Compile := {}
    }
```

This adds the "stage" task which is used for the build on Heroku.

** Step 7)** Create a `project/build.properties` file containing:

```
    sbt.version=0.11.0
```

This tells sbt which version of sbt to use.

** Step 8)** Create a very simple Scala app in `src/main/scala/Hello.scala` containing:

```scala
    object Hello extends App {
      println("hello, world")
    }
```

** Step 9)** Test the app locally by running:

    sbt run

You should see something like:

    [info] Set current project to default-0c17d0 (in build file:/home/jamesw/projects/helloscala/)
    [info] Running Hello 
    hello, world
    [success] Total time: 1 s, completed Sep 7, 2011 4:17:01 AM

** Step 10)** Create a `.gitignore` file containing:

```
    target
    project/boot
    project/target
```

** Step 11)** Create a git repo, add the files to it, and commit them:

    git init
    git add .
    git commit -m init

** Step 12)** Create a new app on Heroku using the Cedar stack:

    heroku create -s cedar

** Step 13)** Upload your app to Heroku using git:

    git push heroku master

** Step 14)** Run the app on Heroku:
    
    heroku run "sbt run"

Voilà!  You just ran Scala on the Cloud!

You can get the full code for this project on github:  
[https://github.com/jamesward/helloscala](https://github.com/jamesward/helloscala)

That was a very simple example to get you started.  Visit the [Heroku Dev Center](http://devcenter.heroku.com/tags/scala) to continue learning about how to use Scala on Heroku.  And let me know if you have any questions.
