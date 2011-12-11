---
author: admin
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

Yesterday at the [Programming Summer
Camp](https://sites.google.com/site/programmingsummercamp/) a group of us were
working together to learn the [Play Framework](http://www.playframework.org/).
Once we were able to get the basics working we wanted to get everything
working in [IntelliJ IDEA](http://www.jetbrains.com/idea/). Due to a lack of
good documentation on the subject things did not go smoothly until we figured
out the right "magical incantations". We did eventually get it working so I
wanted to document the steps we took.

  1. Add Scala support to Play: 
    
    
    play install scala
    

  2. Create a new Play project with Scala support: 
    
    
    play new foo --with scala
    

  3. Have Play create an IntelliJ Module Descriptor: 
    
    
    play idealize foo
    

  4. Run the app: 
    
    
    play run foo
    

  5. Access the app in a browser to generate some source files we will use later: [http://localhost:9000](http://localhost:9000)
  6. Shutdown the Play server.
  7. Currently the Play Scala Module (version 0.9.1) only supports Scala 2.8.1 so [download](http://www.scala-lang.org/node/165) and extract that version.
  8. Create a new project (from scratch) in IntelliJ. The location should be the same as the directory where the Play project was created. Un-check the "Create module" option.![](http://www.jamesward.com/wp/uploads/2011/07/1.png)
  9. In the Project Structure window, with "Modules" selected, click the "+" button to add a new module to the project.
  10. Select the "Import existing module" option and then point it to the generated .iml file.![](http://www.jamesward.com/wp/uploads/2011/07/2.png)
  11. With the module now selected, select the content root block for the module (mine is /home/jamesw/projects/foo). Then select the "tmp/generated" directory in the tree on the right and press the "Sources" button. The HTML template pages are converted to .scala source files by Play and we need these source files to be included in the project along with the regular source files in the app directory.![](http://www.jamesward.com/wp/uploads/2011/07/3.png)
  12. Select "Global Libraries" in the Platform Settings on the left and add a new Java Library named "scala-compiler-2.8.1". Then press the "Attach Classes..." button and navigate to the "lib" directory in your Scala 2.8.1 directory. Then select the "scala-compiler.jar" and "scala-library.jar" files.
  13. Add another Global Library named "scala-library-2.8.1" containing the "scala-dbc.jar", "scala-library.jar", and "scala-swing.jar" files.![](http://www.jamesward.com/wp/uploads/2011/07/6.png)
  14. Press the "Apply" button to save the Global Libraries configuration.
  15. Select "Modules" and then the "Dependencies" tab. Press the "Add..." button and select "Library" to add a new library to the module. Select "scala-library-2.8.1" and then press the "Add Selected" button to add it to the Dependencies.![](http://www.jamesward.com/wp/uploads/2011/07/7.png)
  16. Select the "Scala" Facet in the module and set the Compiler library to the "scala-compiler-2.8.1" option.![](http://www.jamesward.com/wp/uploads/2011/07/8.png)
  17. Save the Project Structure by pressing the "Ok" button. Make sure the project now builds without any errors.
  18. To run the Play server from IntelliJ a new Run Configuration must be configured. To create a new Run Configuration select "Run" from the main IntelliJ menu and then select "Edit Configurations".
  19. Press the "+" button and select "Application" from the list of Run Configuration types.
  20. Set the name to "Play Server".
  21. Set the Main class to "play.server.Server".
  22. Set the VM Parameters to: 
    
    
    -Dapplication.path="."
    

  23. De-select the "Make" option in the "Before Launch" section.
  24. Press the "Ok" button to save the configuration. ![](http://www.jamesward.com/wp/uploads/2011/07/9.png)
  25. Run the Play Server by selecting "Run" from the "Run" IntelliJ menu and verify that the application still works by opening the application in a browser.
  
It is so much easier to figure this stuff out with a group of people. That is
just one of the many reasons why the Programming Summer Camp is a great event!

Let me know if you have any questions or problems.

