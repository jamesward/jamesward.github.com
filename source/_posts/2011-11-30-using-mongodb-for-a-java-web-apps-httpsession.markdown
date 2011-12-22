---
date: '2011-11-30 15:02:21'
layout: post
slug: using-mongodb-for-a-java-web-apps-httpsession
status: publish
title: Using MongoDB for a Java Web App's HttpSession
wordpress_id: '2833'
categories:
- Heroku
- Java
---

Since the web's inception we've been using it as a glorified green screen.  In this model all web application interactions and the state associated with those interactions, is handled by the server.  This model is a real pain to scale.  Luckily the model is shifting to more of a Client/Server approach where the UI state moves to the client (where it should be).  But for many of today's applications we still have to deal with server-side state.  Typically that state is just stored in memory.  It's fast but if we need more than one server (for failover or load-balancing) then we usually need to replicate that state across our servers.  To keep web clients talking to the same server (usually for performance and consistency) our load-balancers have implemented sticky sessions.  Session replication and sticky sessions are really just a by-product of putting client state information in memory.  Until we all move to stateless web architectures we need to find more scalable and maintainable ways to handle session state.

Jetty has [recently added support for a pluggable session state manager](http://webtide.intalio.com/2011/08/nosql-sessions-with-jetty7-and-jetty8/).  This allows us to move away from sticky sessions and session replication and instead use external systems to store session state.  Jetty provides a MongoDB implementation out-of-the-box but presumably it wouldn't be very hard to add other implementations like Memcached.  Jetty has some [good documentation on how to configure this with XML](http://wiki.eclipse.org/Jetty/Tutorial/MongoDB_Session_Clustering).  Lets walk through a sample application using Jetty and MongoDB for session state and then deploy that application on the cloud with Heroku.

First lets cover some Heroku basics.  Heroku runs applications on "dynos".  You can think of dynos as isolated execution environments for your application.  An application on Heroku can have web dynos and non-web dynos.  Web dynos will be used for handling HTTP requests for your application.  Non-web dynos can be used for background processing, one-off processes, scheduled jobs, etc.  HTTP (or HTTPS) requests to your application are automatically load balanced across your web dynos.  Heroku does not use sticky sessions so it is up to you to insure that if you have more than one web dyno or if a dyno is restarted, that your users' sessions will not be lost.

Heroku does not have any special/custom APIs and does not dictate which app server you use.  This means you have to bring your app server with you.  There are a variety of ways to do that but the preferred approach is to specify your app server as a dependency in your application build descriptor (Maven, sbt, etc).

You must tell Heroku what process needs to be run when a new dyno is started.  This is defined in a file called "Procfile" that must be in the root directory of your project.

Heroku provides a really nifty and simple way to provision new external systems that you can use in your application.  These are called "add-ons".  There are [tons of Heroku add-ons](http://addons.heroku.com) but for this example we will be using the [MongoHQ add-on](http://addons.heroku.com/mongohq) that provides a MongoDB instance.

With that in mind lets walk through a simple application that uses Jetty's MongoDB-backed sessions.  You can [get all of this code from github](https://github.com/jamesward/jetty-mongo-session-test) or just clone the github repo:

    git clone git://github.com/jamesward/jetty-mongo-session-test.git

First lets setup a Maven build that will include the Jetty and MongoDB driver dependencies.  We will use `appassembler-maven-plugin` to generate a script that starts the Jetty server.  Here is the pom.xml Maven build descriptor:


```xml
    <project xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://maven.apache.org/POM/4.0.0" xsi:schemalocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelversion>4.0.0</modelversion>
        <groupid>com.heroku.test</groupid>
        <version>1.0-SNAPSHOT</version>
        <name>jettySessionTest</name>
        <artifactid>jettySessionTest</artifactid>
        <packaging>jar</packaging>
    
        <dependencies>
            <dependency>
                <groupid>org.eclipse.jetty</groupid>
                <artifactid>jetty-webapp</artifactid>
                <version>8.0.3.v20111011</version>
            </dependency>
            <dependency>
                <groupid>org.eclipse.jetty</groupid>
                <artifactid>jetty-nosql</artifactid>
                <version>8.0.3.v20111011</version>
            </dependency>
            <dependency>
                <groupid>org.mongodb</groupid>
                <artifactid>mongo-java-driver</artifactid>
                <version>2.6.5</version>
            </dependency>
        </dependencies>
    
        <build>
            <plugins>
                <plugin>
                    <groupid>org.codehaus.mojo</groupid>
                    <artifactid>appassembler-maven-plugin</artifactid>
                    <version>1.1.1</version>
                    <executions>
                        <execution>
                            <phase>package</phase>
                            <goals>
                                <goal>assemble</goal>
                            </goals>
                            <configuration>
                                <assembledirectory>target</assembledirectory>
                                <programs>
                                    <program>
                                        <mainclass>com.heroku.test.Main</mainclass>
                                        <name>webapp</name>
                                    </program>
                                </programs>
                            </configuration>
                        </execution>
                    </executions>
                </plugin>
            </plugins>
        </build>
    </project>
```

The `appassembler-maven-plugin` references a class "com.heroku.test.Main" that hasn't been created yet.  We will get to that in a minute.  First lets create a simple servlet that will store an object in the session.  Here is the servlet from the `src/main/java/com/heroku/test/servlet/TestServlet.java` file:


```java
    package com.heroku.test.servlet;
    
    
    import java.io.IOException;
    import java.io.Serializable;
    import java.util.Date;
    
    import javax.servlet.ServletException;
    import javax.servlet.http.HttpServlet;
    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;
    import javax.servlet.http.HttpSession;
    
    public class TestServlet extends HttpServlet {
         
        private class CountHolder implements Serializable {
    
            private static final long serialVersionUID = 1L;
            private Integer count;
            private Date time;
    
            public CountHolder() {
                count = 0;
                time = new Date();
            }
            
            public Integer getCount() {
                return count;
            }
            
            public void plusPlus() {
                count++;
            }
            
            public void setTime(Date time) {
                this.time = time;
            }
        }
        
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp)
                throws ServletException, IOException {
            
            HttpSession session = req.getSession();
            
            CountHolder count;
            
            if(session.getAttribute("count") != null) {            
                count = (CountHolder) session.getAttribute("count");
            } else {
                count = new CountHolder();
            }
            
            count.setTime(new Date());
            count.plusPlus();
            
            System.out.println("Count: " + count.getCount());
            
            session.setAttribute("count", count);
            
            resp.getWriter().print("count = " + count.getCount());
        }
    
    }
```

As you can see there is nothing special here.  We are using the regular `HttpSession` normally, storing and retrieving a `Serializable` object named `CountHolder`.  The application simply displays the number or times the servlet has been accessed by a user (where "user" really means a request that passes the same `JSESSIONID` cookie as a previous request).

Now lets map that servlet to the `/` URL pattern in the web app descriptor (`src/main/webapp/WEB-INF/web.xml`):


```xml
    <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemalocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" version="2.5">
        
        <servlet>
            <servlet-name>Test Servlet</servlet-name>
            <servlet-class>com.heroku.test.servlet.TestServlet</servlet-class>
        </servlet>
    
        <servlet-mapping>
            <servlet-name>default</servlet-name>
            <url-pattern>*.ico</url-pattern>
        </servlet-mapping>
    
        <servlet-mapping>
            <servlet-name>Test Servlet</servlet-name>
            <url-pattern>/</url-pattern>
        </servlet-mapping>
    
    </web-app>
```

I put a servlet mapping in for `.ico` because some browsers automatically request `favicon.ico`, and those requests if not mapped to something will map to our servlet and make the count appear to jump.

Now lets create that `com.heroku.test.Main` class that will configure Jetty and start it.  One reason we are using a Java class to start Jetty is because we are trying to avoid putting the MongoDB connection information in a text file.  Heroku add-ons place their connection information for the external systems in environment variables.  We could copy that information into a plain XML Jetty config file but that is an anti-pattern because if the add-on provider needs to change the connection information (perhaps for failover purposes) then our application would stop working until we manually updated the config file.  So our simple Main class will just read the connection information from an environment variable and configure Jetty at runtime.  Here is the source for the `src/main/java/com/heroku/test/Main.java` file:

```java
    package com.heroku.test;
    
    import java.util.Date;
    import java.util.Random;
    
    import org.eclipse.jetty.nosql.mongodb.MongoSessionIdManager;
    import org.eclipse.jetty.nosql.mongodb.MongoSessionManager;
    import org.eclipse.jetty.server.Server;
    import org.eclipse.jetty.server.session.SessionHandler;
    import org.eclipse.jetty.webapp.WebAppContext;
    
    import com.mongodb.DB;
    import com.mongodb.MongoURI;
    
    public class Main {
    
        public static void main(String[] args) throws Exception{
            String webappDirLocation = "src/main/webapp/";
    
            String webPort = System.getenv("PORT");
            if(webPort == null || webPort.isEmpty()) {
                webPort = "8080";
            }
    
            Server server = new Server(Integer.valueOf(webPort));
            WebAppContext root = new WebAppContext();
    
            MongoURI mongoURI = new MongoURI(System.getenv("MONGOHQ_URL"));
            DB connectedDB = mongoURI.connectDB();
    
            if (mongoURI.getUsername() != null) {
                connectedDB.authenticate(mongoURI.getUsername(), mongoURI.getPassword());
            }
    
            MongoSessionIdManager idMgr = new MongoSessionIdManager(server, connectedDB.getCollection("sessions"));
    
            Random rand = new Random((new Date()).getTime());
            int workerNum = 1000 + rand.nextInt(8999);
    
            idMgr.setWorkerName(String.valueOf(workerNum));
            server.setSessionIdManager(idMgr);
    
            SessionHandler sessionHandler = new SessionHandler();
            MongoSessionManager mongoMgr = new MongoSessionManager();
            mongoMgr.setSessionIdManager(server.getSessionIdManager());
            sessionHandler.setSessionManager(mongoMgr);
    
            root.setSessionHandler(sessionHandler);
            root.setContextPath("/");
            root.setDescriptor(webappDirLocation+"/WEB-INF/web.xml");
            root.setResourceBase(webappDirLocation);
            root.setParentLoaderPriority(true);
    
            server.setHandler(root);
    
            server.start();
            server.join();
        }
    
    }
```

As you can see the `MongoSessionManager` is being configured based on the `MONGOHQ_URL` environment variable, the Jetty server is being configured to use the `MongoSessionManager` and pointed to the web app location, and then Jetty is started.

Now lets give it a try!  If you want to run everything locally then you will need to have [Maven 3](http://maven.apache.org/) and [MongoDB](http://www.mongodb.org/) installed and started.  Then run the Maven build

    mvn package

This will use the `appassembler-maven-plugin` to generate the start script which sets up the `CLASSPATH` and then runs the `com.heroku.test.Main` class.  Before we run we need to set the environment variable to point to our local MongoDB:

  * On Windows:

        set MONGOHQ_URL=mongodb://127.0.0.1:27017/test
    
  * On Linux/Mac:
    
        export MONGOHQ_URL=mongodb://127.0.0.1:27017/test

Now run the generated start script:

  * On Windows:

        target\bin\webapp.bat

  * On Linux/Mac:

        sh target/bin/webapp

Test the app in your browser by visiting:  
[http://localhost:8080/](http://localhost:8080/)

Refresh the page a few times to verify that the count is increasing.

This is just testing one instance of the application which isn't very exciting since part of the purpose of moving the session out of memory and into an external system is to handle scalability.  So lets start up another instance of the app on a different port and make sure that the session is consistent between both servers.  In another terminal window / command prompt start up a second server on port 9090:

  * On Windows:
    
        set MONGOHQ_URL=mongodb://127.0.0.1:27017/test
        set PORT=9090
        target\bin\webapp.bat

  * On Linux/Mac:

        export MONGOHQ_URL=mongodb://127.0.0.1:27017/test
        export PORT=9090
        sh target/bin/webapp

Now in your browser make a few requests to:  
[http://localhost:9090/](http://localhost:9090/)

Verify that the session is consistent between the two servers.

Now lets deploy this app on the cloud with Heroku.  As mentioned earlier we need a file named `Procfile` in the root directory that will tell Heroku what process to run when a dyno is started.  Here is the Procfile for this application:

    web: sh target/bin/webapp

To create and deploy the application you will need to install [git](http://git-scm.com/) & the [Heroku Toolbelt](http://toolbelt.heroku.com), create an [Heroku](http://heroku.com/signup), and since we will be using add-ons you will need to [verify your Heroku account](http://heroku.com/verify).  Each application your create on Heroku gets 750 free dyno hours per month.  So as long as you don't go above that and you stick with the free tier of the MongoHQ add-on, then you won't be billed for anything.

Login to Heroku using the heroku command line interface:

    heroku login

If you haven't already setup an SSH key for Heroku then the login process will walk you through that.

In the root directory of this project create the app on Heroku with the "cedar" stack and the free MongoHQ add-on:

    heroku create --stack cedar --addons mongohq:free
    
Upload your application to Heroku using git:

    git push heroku master
    
Open the application in your browser:

    heroku open
    
If you want to add more dynos handling web requests then run:

    heroku scale web=2

To see what is running on Heroku run:

    heroku ps

If you want to turn off all of the dynos for your application just scale to 0:

    heroku scale web=0

To see the logging information for your application run:

    heroku logs

To see a live version of this demo visit:  
[http://young-wind-7462.herokuapp.com/](http://young-wind-7462.herokuapp.com/)

Well, there you go.  You've learned how to avoid sticky sessions and session replication by moving session state to an external MongoDB system that can be scaled independently of the web tier.  You've also learned how to run this on the cloud with Heroku.  Let me know if you have any questions.

BTW: I'd like to thank [John Simone](https://twitter.com/j_simone/) from Heroku for writing most of the code for this demo.
