---
date: '2011-07-28 08:13:31'
layout: post
slug: setup-play-framework-with-scala-in-intellij
status: publish
title: Setup Play Framework with Scala in IntelliJ
wordpress_id: '2480'
categories:
- Play Framework
- Scala
---

Yesterday at the [Programming Summer Camp](https://sites.google.com/site/programmingsummercamp/) a group of us were working together to learn the [Play Framework](http://www.playframework.org/).  Once we were able to get the basics working we wanted to get everything working in [IntelliJ IDEA](http://www.jetbrains.com/idea/).  Due to a lack of good documentation on the subject things did not go smoothly until we figured out the right "magical incantations".  We did eventually get it working so I wanted to document the steps we took.

**Step 1)** Add Scala support to Play:

    play install scala

**Step 2)** Create a new Play project with Scala support:

    play new foo --with scala

**Step 3)** Have Play create an IntelliJ Module Descriptor:

    play idealize foo

**Step 4)** Run the app:

    play run foo

**Step 5)** Access the app in a browser to generate some source files we will use later:  
[http://localhost:9000](http://localhost:9000)

**Step 6)** Shutdown the Play server.

**Step 7)** Currently the Play Scala Module (version 0.9.1) only supports Scala 2.8.1 so [download](http://www.scala-lang.org/node/165) and extract that version.

**Step 8)** Create a new project (from scratch) in IntelliJ.  The location should be the same as the directory where the Play project was created.  Un-check the "Create module" option.
![](/wp/uploads/2011/07/1.png)

**Step 9)** In the Project Structure window, with "Modules" selected, click the "+" button to add a new module to the project.

**Step 10)** Select the "Import existing module" option and then point it to the generated .iml file.
![](/wp/uploads/2011/07/2.png)

**Step 11)** With the module now selected, select the content root block for the module (mine is `/home/jamesw/projects/foo`).  Then select the `tmp/generated` directory in the tree on the right and press the "Sources" button.  The HTML template pages are converted to `.scala` source files by Play and we need these source files to be included in the project along with the regular source files in the app directory.
![](/wp/uploads/2011/07/3.png)

**Step 12)** Select "Global Libraries" in the Platform Settings on the left and add a new Java Library named `scala-compiler-2.8.1`.  Then press the "Attach Classes..." button and navigate to the `lib` directory in your Scala 2.8.1 directory.  Then select the `scala-compiler.jar` and `scala-library.jar` files.

**Step 13)** Add another Global Library named `scala-library-2.8.1` containing the `scala-dbc.jar`, `scala-library.jar`, and `scala-swing.jar` files.
![](/wp/uploads/2011/07/6.png)

**Step 14)** Press the "Apply" button to save the Global Libraries configuration.

**Step 15)** Select "Modules" and then the "Dependencies" tab.  Press the "Add..." button and select "Library" to add a new library to the module.  Select `scala-library-2.8.1` and then press the "Add Selected" button to add it to the Dependencies.
![](/wp/uploads/2011/07/7.png)

**Step 16)** Select the "Scala" Facet in the module and set the Compiler library to the `scala-compiler-2.8.1` option.
![](/wp/uploads/2011/07/8.png)

**Step 17)** Save the Project Structure by pressing the "Ok" button.  Make sure the project now builds without any errors.

**Step 18)** To run the Play server from IntelliJ a new Run Configuration must be configured.  To create a new Run Configuration select "Run" from the main IntelliJ menu and then select "Edit Configurations".

**Step 19)** Press the "+" button and select "Application" from the list of Run Configuration types.

**Step 20)** Set the name to `Play Server`.

**Step 21)** Set the Main class to `play.server.Server`.

**Step 22)** Set the VM Parameters to:

    -Dapplication.path="."

**Step 23)** De-select the "Make" option in the "Before Launch" section.

**Step 24)** Press the "Ok" button to save the configuration.
![](/wp/uploads/2011/07/9.png)


**Step 25)** Run the Play Server by selecting "Run" from the "Run" IntelliJ menu and verify that the application still works by opening the application in a browser.

It is so much easier to figure this stuff out with a group of people.  That is just one of the many reasons why the Programming Summer Camp is a great event!

Let me know if you have any questions or problems.
