---
date: '2011-08-23 08:59:30'
layout: post
slug: war-less-java-web-apps
status: publish
title: WAR-less Java Web Apps
wordpress_id: '2522'
categories:
- Java
---

Have you ever thought about why in Java we package up web apps into WAR files (or WAR directory structures)? It certainly is a convenient way to move an application and its dependencies from one place to another. But wouldn't it be nice if everything could just stay in its original location and there wouldn't be any moving of files around? Wouldn't it also be nice if you specified your required version of Jetty or Tomcat just like you do with every other dependency? The WAR-less approach is one that is catching on as emerging Java web frameworks like [Play!](http://www.playframework.org/) ditch the WAR files. With standard Java web apps we can also ditch the WAR files by simply launching an embedded Jetty or Tomcat server. Let's give this a try and see how it goes.

For this experiment I'm going to use Maven and Jetty. This will still use the same standard source structure for a WAR file (_src/main/java_, _src/main/webapp_, etc). The major difference is that I will actually startup Jetty using a good-old _static void main_. This is similar to using the _jetty:run_ goal but will allow us to have the same exact setup in development and in production. The static stuff will be in _src/main/webapp_, the compiled classes will be in target/classes, and the dependencies will be right were Maven downloaded them to. First, here is a little Java class (_src/main/java/foo/Main.java_) that sets up a Jetty server and starts it:

    
    
    package foo;
    
    import java.io.File;
    import java.net.URL;
    import java.util.jar.Attributes;
    import java.util.jar.JarFile;
    
    import org.eclipse.jetty.server.Server;
    import org.eclipse.jetty.server.handler.*;
    import org.eclipse.jetty.util.StringUtil;
    import org.eclipse.jetty.webapp.WebAppContext;
    
    public class Main
    {
    
      public static void main(String[] args) throws Exception
      {
        String webappDirLocation = "src/main/webapp/";
    
        Server server = new Server(8080);
        WebAppContext root = new WebAppContext();
    
        root.setContextPath("/");
        root.setDescriptor(webappDirLocation + "/WEB-INF/web.xml");
        root.setResourceBase(webappDirLocation);
    
        root.setParentLoaderPriority(true);
    
        server.setHandler(root);
    
        server.start();
        server.join();
      }
    }
    



As you can see, Main just references the webapp directory so I don't have to copy the stuff from there to another place. Next I have a little test servlet (_src/main/java/foo/HelloServlet.java_):

    
    
    package foo;
    
    import java.io.IOException;
    import java.io.PrintWriter;
    
    import javax.servlet.ServletException;
    import javax.servlet.http.*;
    
    public class HelloServlet extends HttpServlet
    {   
    
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
      {
        PrintWriter out = resp.getWriter();
        out.println("hello, world");
        out.close();
      }
    }
    



And now the _web.xml_ file (_src/main/webapp/WEB-INF/web.xml_):

    
    
    
    <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:web="http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemalocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" version="2.5">
      <servlet>
        <servlet-name>HelloServlet</servlet-name>
        <servlet-class>foo.HelloServlet</servlet-class>
      </servlet>
      <servlet-mapping>
        <servlet-name>HelloServlet</servlet-name>
        <url-pattern>/</url-pattern>
      </servlet-mapping>
    </web-app>
    



And finally a _pom.xml_ file that specifies Jetty as a dependency and provides an easy way to run the Main class:

    
    
    
    <project xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://maven.apache.org/POM/4.0.0" xsi:schemalocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    
      <modelversion>4.0.0</modelversion>
      <groupid>com.jamesward</groupid>
      <version>1.0-SNAPSHOT</version>
      <name>warless_java_web_app</name>
      <artifactid>warless_java_web_app</artifactid>
      <packaging>jar</packaging>
    
      <properties>
        <jettyversion>7.3.1.v20110307</jettyversion>
      </properties>
    
      <dependencies>
        <dependency>
          <groupid>org.eclipse.jetty</groupid>
          <artifactid>jetty-server</artifactid>
          <version>${jettyVersion}</version>
        </dependency>
        <dependency>
          <groupid>org.eclipse.jetty</groupid>
          <artifactid>jetty-webapp</artifactid>
          <version>${jettyVersion}</version>
        </dependency>
        <dependency>
          <groupid>org.eclipse.jetty</groupid>
          <artifactid>jetty-servlet</artifactid>
          <version>${jettyVersion}</version>
        </dependency>
      </dependencies>
    
      <build>
        <plugins>
          <plugin>
            <groupid>org.codehaus.mojo</groupid>
            <artifactid>exec-maven-plugin</artifactid>
            <version>1.2</version>
            <configuration>
              <mainclass>foo.Main</mainclass>
            </configuration>
          </plugin>
        </plugins>
      </build>
    </project>
    



And now simply run:

    
    
    mvn compile exec:java
    



Maven compiles my Java classes into _target/classes_ and then the _exec:java_ goal runs the Main which finds the other WAR assets in the _src/main/webapp_ directory. If you have been following along, make a request to [http://localhost:8080/](http://localhost:8080/) to verify that it works (which it should).

There are two alternatives to running Jetty from Maven. You can use the Maven appassembler plugin to create start scripts containing the correct _CLASSPATH_ references and then launch Main class using the generated scripts. Or you can use the Maven assembly or shade plugin to create a JAR containing the application and all of its dependencies.

Here is an example section of a _pom.xml_ file for using the appassembler plugin:

    
    
      <plugin>
        <groupid>org.codehaus.mojo</groupid>
        <artifactid>appassembler-maven-plugin</artifactid>
        <version>1.1.1</version>
        <configuration>
          <assembledirectory>target</assembledirectory> 
          <generaterepository>false</generaterepository>
          <programs>
            <program>
              <mainclass>foo.Main</mainclass>
              <name>main</name>
            </program>
          </programs>
        </configuration>
        <executions>
          <execution>
            <phase>package</phase>
            <goals>
              <goal>assemble</goal>
            </goals>
          </execution>          
        </executions>
      </plugin>
    



To generate the start scripts simply run:

    
    
    mvn install
    



Then to run the script set the REPO environment variable to your Maven repository:

    
    
    export REPO=~/.m2/repository
    



And then simply run the script:

    
    
    sh target/bin/main
    



All of the code for this example is on github.com:
[https://github.com/jamesward/warless_java_web_apps](https://github.com/jamesward/warless_java_web_apps)

To make all of this even easier, Jetty has a Maven archetype for generating everything for you. To create a new project containing this setup run:

    
    
    mvn archetype:generate -DarchetypeGroupId=org.mortbay.jetty.archetype -DarchetypeArtifactId=jetty-archetype-assembler -DarchetypeVersion=7.5.0-SNAPSHOT
    



And now you are ready to build a WAR-less Java web app!

This setup is really the bare minimum required to handle web resource and servlet requests you will need to do a little more work if you want to add JSP support. Find out more about this in the [Jetty documentation](http://wiki.eclipse.org/Jetty/Tutorial/Embedding_Jetty#Embedding_JSP).

So... What do you think about Java Web apps without WAR files & WAR packaging? I'd love to hear your thoughts!
