---
date: '2011-10-19 09:26:28'
layout: post
slug: running-play-framework-scala-apps-on-heroku
status: publish
title: Running Play Framework + Scala Apps on Heroku
wordpress_id: '2725'
categories:
- Play Framework
- Scala
---

Building [Play Framework apps with Scala](http://scala.playframework.org/) is all the rage right now.  And for good reason...  It's never been easier to build and deploy JVM-based web apps!  Lets walk through how to build a Play app with Scala and then deploy it on the cloud with Heroku.

Step 1) [Install the Play Framework](http://www.playframework.org/download) (make sure you have at least version 1.2.3)

Step 2) Install the Play Scala module:

    
    
    play install scala
    



Step 3) Create a new Play app with Scala support:

    
    
    play new playwithscala --with scala
    



Step 4) Start the app:

    
    
    cd playwithscala
    play run
    



Step 5) Open the app in your browser:
[http://localhost:9000](http://localhost:9000)

That was easy!  Lets spice this up a bit before we deploy it on Heroku by adding a custom model, view, and controller.

Step 1) Create a new _app/models/Widget.scala_ file containing:

    
    
    package models
    
    case class Widget(id: Int, name: String)
    



Step 2) Create a new _app/views/Widget/list.scala.html_ file containing:

    
    
    @(widgets: Vector[models.Widget])
    
    
    <html>
        <body>
            @widgets.map { widget => 
                Widget @widget.id = @widget.name</br>
            }
        </body>
    </html>
    



Step 3) Create a new _app/controllers/WidgetController.scala_ file containing:

    
    
    package controllers
    
    import play._
    import play.mvc._
    
    object WidgetController extends Controller {
    
        import views.Widget._
        import models.Widget
    
        def list = {
            val widget1 = Widget(1, "The first Widget")
            val widget2 = Widget(2, "A really special Widget")
            val widget3 = Widget(3, "Just another Widget")
            html.list(Vector(widget1, widget2, widget3))
        }
    
    }
    



Step 4) Test out the new code by going to:
[http://localhost:9000/WidgetController/list](http://localhost:9000/WidgetController/list)

It works!  And we didn't even need to reload the server!  But lets clean up that URL a bit.  Edit the _conf/routes_ file and change "Application.index" to "WidgetController.list":

    
    
    GET     /                                       WidgetController.list
    



Now load the new URL:
[http://localhost:9000/](http://localhost:9000/widgets/list)

That was easy but now we want to show our friends.  So lets deploy it on Heroku.

Step 1) Install the Heroku command line client on [Linux](http://toolbelt.herokuapp.com/linux/readme), [Mac](http://toolbelt.herokuapp.com/osx/download), or [Windows](http://toolbelt.herokuapp.com/windows/download)

Step 2) Login to Heroku from the command line:

    
    
    heroku auth:login
    



Step 3) Heroku uses git for application upload, so create a .gitignore file containing:

    
    
    /modules
    /tmp
    



Step 4) Create a git repo, add the files to it, and commit them:

    
    
    git init
    git add .
    git commit -m init
    



Step 5) Create the new application on Heroku:

    
    
    heroku create -s cedar
    



This provisions a new application on Heroku and assigns a random name / URL to the app.

Step 6) Deploy the application:

    
    
    git push heroku master
    



The application will now be assembled and deployed on Heroku.

Step 7) Open the application in the browser:

    
    
    heroku open
    



Tada!  Your Play + Scala app is now running on the cloud!

At JavaOne I showed this to Bill Venners (creator of [ScalaTest](http://www.scalatest.org/)).  He then moved the scalatest.org website (a Play + Scala app) to Heroku!  Cool stuff!

Let me know if you have any questions.
