---
date: '2011-12-11 19:20:42'
layout: post
slug: tutorial-play-framework-jpa-json-jquery-heroku
status: publish
title: 'Tutorial: Play Framework, JPA, JSON, jQuery, & Heroku'
wordpress_id: '2857'
categories:
- Heroku
- Java
- jQuery
- Play Framework
---

If you are a Java developer then you really need to give [Play Framework](http://www.playframework.org) a try.  It is really refreshing to take a few minutes, step out of the legacy-feeling world of traditional Java web app development and into something modern and fun.  I want to walk you through a very simple tutorial where we will build a web application with Play Framework.  The application will use JPA for persistence and expose access to the data through a JSON over HTTP interface.  The client-side of the application will be built with [jQuery](http://jquery.com/).  Lets get started.

**Step 1)** Download and install [Play Framework 1.2.3](http://download.playframework.org/releases/play-1.2.3.zip)

**Step 2)** Create a new Play app from the command line and then move to the new directory:

    play new playbars
    cd playbars

**Optional Step 3)** If you want to work in an IDE then you can run one of the following commands and then open the generated project in your IDE:

    play idealize

Or:

    play eclipsify

I won't walk though the IDE specific steps here, but you can refer to the [Play documentation on IDE integration](http://www.playframework.org/documentation/1.2/ide) if you want to get that setup.  Note that IntelliJ IDEA has great support for Play Framework with a console right in the IDE.

**Step 4)** Start the Play server from the new project's directory :

    play run --%test

This starts Play in test mode which will automatically recompile any changes we make to the application.  No packaging, redeploying, or restarting servers will be needed.

**Step 5)** Open the application in your browser:
[http://localhost:9000](http://localhost:9000)

The default page provides you with great Play documentation on how to get started.  But we will soon be changing that page.  If you want to view the documentation locally after we change the page you can use these links:

  * [Documentation](http://localhost:9000/@documentation/home)
  * [Play JavaDoc](http://localhost:9000/@api/index.html)

**Step 6)** Lets start by creating a new JPA entity.  Keeping it very simple, lets create a new `app/models/Bar.java` file containing:

```java
    package models;
    
    import play.db.jpa.Model;
    
    import javax.persistence.Entity;
    
    @Entity
    public class Bar extends Model {
        
        public String name;
        
    }
```

This entity uses the standard JPA Entity annotation but also extends the Play Model class which provides some nice conveniences which you can read more about [in the Play JPA docs](http://www.playframework.org/documentation/1.2.3/jpa).  I'm using just a plain public property on this class but you can also use the Java Bean getter/setter stuff in you like.

**Step 7)** Create a simple unit / integration test for this Bar object by creating a `test/BarTest.java` file with the following contents:

```java
    import org.junit.*;
    import java.util.*;
    import play.test.*;
    import models.*;
    
    public class BarTest extends UnitTest {
    
        @Test
        public void integrationTest() {
            Bar bar = new Bar();
            bar.name = "a new bar";
            bar.save();
            assertNotNull(bar.id);
            assertTrue(Bar.findAll().size() >= 1);
            bar.delete();
            assertTrue(Bar.findAll().size() == 0);
        }
    
    }
```

**Step 8)** Setup the default database by editing the `conf/application.conf` file and uncommenting the following line:

    # db=mem

This sets up the default database to be an in-memory database.

**Step 9)** Run the application's tests by opening the following URL in your browser:
[http://localhost:9000/@tests](http://localhost:9000/@tests)

Select `BarTest` and then click the `Start!` button.  The test should pass.

**Step 10)** Add the following two methods to the `app/controllers/Application.java` file:

```java
        public static void addBar(Bar bar) {
            bar.save();
            index();
        }
        
        public static void listBars() {
            renderJSON(Bar.findAll());
        }
```

The _addBar_ method takes a _Bar_, saves it, and then redirects back to the index page.  Play will automatically parse request parameters and populate the _Bar_ object.  The _listBars_ method queries for all of the Bars in the database and then outputs then as serialized JSON.

**Step 11)** Play has a very flexible model for mapping URLs to controllers.  Lets setup two new routes that will map URLs to the new methods we've added to the Application controller.  Add the following lines to the `conf/routes` file but make sure you either add them above the `Catch all` or simply remove the `Catch all` route:

    POST    /                                       Application.addBar
    GET     /bars.json                              Application.listBars

The first route handles HTTP POST requests to the `/` URL and handles them with the _Application.addBar_ method.  The second route handles requests to the `/bars.json` URL and handles them with the _Application.listBars_ method.

**Step 12)** Lets add a [FunctionalTest](http://www.playframework.org/documentation/1.2.4/test#Functionaltest) that will actually make requests to the Controller and test that our new routes and controller methods are working.  Add the following method to the `test/ApplicationTest.java` file:

```java
        @Test
        public void barTest() {
            Response addBarResponse = POST("/", APPLICATION_X_WWW_FORM_URLENCODED, "bar.name=foo");
            assertStatus(302, addBarResponse);
            Response listBarsResponse = GET("/bars.json");
            assertIsOk(listBarsResponse);
        }
```

This test adds a new _Bar_ by doing an HTTP POST to `/` and passing it some form encoded data.  Then a request is made to `/bars.json` and the response is checked to make sure there wasn't an error.  Since there isn't a DELETE method (which could easily be added) there isn't a good way to clean up what this test does.

Run the _ApplicationTest_ Functional Test in the Play Framework Web Test Runner:
[http://localhost:9000/@tests?select=ApplicationTest.class](http://localhost:9000/@tests?select=ApplicationTest.class)

Because the test didn't clean up after itself you can now see the JSON from `/bars.json` in your browser by visiting:
[http://localhost:9000/bars.json](http://localhost:9000/bars.json)

**Step 13)** Now it is time to create the actual web UI for this application.  A combination of plain HTML (via Play's Groovy templates) and jQuery will be used.  Play Framework uses a convention to render the HTML from the `app/views/Application/index.html` template when the render method in `Application.index` is called.  In the `index.html` file and you will see:

```
    #{extends 'main.html' /}
    #{set title:'Home' /}
    
    #{welcome /}
```

You can also take a look at the referenced `app/views/main.html` file to see what the base template looks like.  It does the standard HTML page stuff and then inserts the body of the `index.html` page into the `#{doLayout /}` section.  The `main.html` template also loads jQuery and provides a way to insert some JavaScript into the _head_ section of the page.  In the `index.html` file, replace the `#{welcome /}` line with a form that will allow users to create new bars:

```
    #{form @addBar()}
        <input type="text" name="bar.name"></input>
        <input type="submit"></input>
    #{/form}
```

The `#{form @addBar()}` syntax is Groovy that creates a form tag and sets the form action to the URL that corresponds to the `Application.addBar` method.  You can test this out by loading this page in your browser:
[http://localhost:9000/](http://localhost:9000/)

The form should be functional now.  Enter the name of a bar and click the submit button.  Because the `addBar` method calls the `index` method, after the POST, the browser is redirected back to the index page.  You can verify that the data is being saved by loading the [bars.json](http://localhost:9000/bars.json) page again.

Now lets add some Ajax / jQuery to the `index.html` page that will get the JSON data and display it in the page.  Add an empty `ul` tag with an `id` of `bars`:

```html
    <ul id="bars">
    
    </ul>
```

Now we will insert the JavaScript into the correct place in the page by setting the `moreScripts` variable:

```html
    #{set 'moreScripts'}
    <script type="text/javascript">
        $(function() {
            $.get("bars.json", function(data) {
                $.each(data, function(index, item) {
                    $("#bars").append("<li>Bar " + item.name + "</li>");
                });
            });
        });
    </script>
    #{/set}
```

Using jQuery this bit of JavaScript adds a function handler for when the page is loaded, then in that function it makes a get request to "bars.json".  That request has a function handler for when the result comes back from the Ajax request.  Inside that function handler the data is iterated through and each "bar" is appended into the page element with the id of "bars" - the `ul` tag.

Try out the application and make sure that you can still add new bars and see the list of all the bars in the database.

Now that everything works locally, lets deploy the app on the cloud using Heroku.

**Step 1)** [Create an account on Heroku.com](http://heroku.com/signup), install the [Heroku Toolbelt](http://toolbelt.heroku.com) and [git](http://git-scm.org) and then login to Heroku from the command line:

    heroku login

If this is the first time you've done this then new ssh keys for git will be created and associated with your Heroku account.

**Step 2)** Each application on Heroku has a Postgres database for testing.  To use that database when running on Heroku we need to configure it.  Play applications on Heroku run in "prod" mode.  To set the database to use the Heroku database add the following lines to the `conf/application.conf` file:

    %prod.db=${DATABASE_URL}
    %prod.jpa.dialect=org.hibernate.dialect.PostgreSQLDialect
    %prod.jpa.ddl=update

The default way to provide database (and other resource) connection strings to an application on Heroku, is through environment variables.  The `DATABASE_URL` environment variable will contain the database host, name, username, and password.  Play Framework knows how to handle that information and setup the JDBC connections.

**Step 3)** Heroku uses git as a means to uploading applications.  Whether or not you use git for your SCM tool you can use git as the tool to upload an app to Heroku.  In the root directory of your project create git repo, add the files to it, and then commit the files:
    
    git init
    git add app conf public test
    git commit -m init

Note: Instead of doing a selective `git add` you can create a `.gitignore` file containing the files to not add to the git repo.

**Step 4)** Now we will provision a new application on Heroku using the Heroku CLI.  Each application you create gets 750 free "[dyno](http://devcenter.heroku.com/articles/dynos)" hours per month.  So as a developer you can use Heroku for free and only pay when you need to scale beyond one dyno.  On the command line create a new application using the "cedar" stack:

    heroku create -s cedar

This creates an HTTP endpoint and a git endpoint for your application.  You can also use a custom name and point your own domain names at the application.

**Step 5)** The application is ready to be deployed to the cloud.  From a command line do a "git push" to the master branch on Heroku:

    git push heroku master

Once the files have been received by Heroku, Play Framework's precompiler will be run, Heroku will assemble a "slug file", and then the "slug" will be deployed onto a dyno.

**Step 6)** You can now open the application in your browser by navigating to the domain outputted following the `heroku create` or by simply running:

    heroku open

You've built a Play Framework application with JPA, JSON, & jQuery and then deployed that application on the cloud with Heroku!  Now [get the code ](https://github.com/jamesward/playbars) and [check out a demo](http://vivid-sunset-6133.heroku.com/) on Heroku.  Let me know if you have any questions.
