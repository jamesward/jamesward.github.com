---
date: '2011-08-29 09:11:28'
layout: post
slug: getting-started-with-play-framework-on-heroku
status: publish
title: Getting Started with Play Framework on Heroku
wordpress_id: '2561'
categories:
- Heroku
- Play Framework
---

Last week Heroku announced that [you can now run Java apps on Heroku](http://www.jamesward.com/2011/08/25/heroku-adds-java-support).  Today [Heroku announced](http://blog.heroku.com/archives/2011/8/29/play/) that you can also easily run [Play Framework](http://www.playframework.org) apps on Heroku!  Here's a quick guide to getting started with Play! on Heroku:

**Step 1)** Install the heroku command line client on [Linux](http://toolbelt.herokuapp.com/linux/readme), [Mac](http://toolbelt.herokuapp.com/osx/download), or [Windows](http://toolbelt.herokuapp.com/windows/download).

**Step 2)** Install [git](http://git-scm.com/) and setup your SSH key

**Step 3)** [Install Play! version 1.2.3](http://www.playframework.org/download)

**Step 4)** Login to Heroku from the command line:

    heroku auth:login

**Step 5)** Create a new Play! app:

    play new play_hello_world
    cd play_hello_world

**Step 6)** Run the app locally to test it:

    play run --%production

**Step 7)** Create a git repo, add the files, and commit:

    git init
    git add app conf lib public test
    git commit -m init

**Step 8)** Create a new app on Heroku:

    heroku create -s cedar

**Step 9)** Push the app to Heroku:

    git push heroku master

**Step 10)** Open the app in your browser:

    heroku open

That's it!  If you want to learn more about Heroku, check out the [Heroku for Java Workbook](https://github.com/heroku/java-workbook) and the [Heroku Dev Center](http://devcenter.heroku.com/).  And if you are at Dreamforce 2011 then check out [Felipe Oliveira's](http://geeks.aretotally.in/) session on "Introducing Play! Framework: Painless Java and Scala Web Applications" on Wednesday at 3:30pm.

Let me know what you think and if you have any questions.
