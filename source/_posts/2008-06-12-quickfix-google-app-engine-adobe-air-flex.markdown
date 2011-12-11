---
author: admin
date: '2008-06-12 15:09:13'
layout: post
slug: quickfix-google-app-engine-adobe-air-flex
status: publish
title: Need a QuickFix? Try Google App Engine, Adobe AIR, and Flex
wordpress_id: '284'
categories:
- Adobe AIR
- Flex
- Google App Engine
- Python
---

Last week I spent a few hours with Dick Wall of the [Java
Posse](http://www.javaposse.com/) working on an application which combines
Google App Engine, Adobe AIR, and Flex. This was a fun experiment that turned
into a pretty cool application. The application, named QuickFix, sends an
image to Google App Engine which does an "I'm Feeling Lucky" transformation on
the image and sends it back. Here's a screenshot of it fixing one of the
photos I took at the Java Posse Roundup this past winter:
[![](http://www.jamesward.com/wordpress/wp-
content/uploads/2008/06/quickfix.png)](http://airquickfix.appspot.com/)

You can get the application by going to:
[http://airquickfix.appspot.com/](http://airquickfix.appspot.com/)

All of the source code can be found in the [air-quick-fix
project](http://code.google.com/p/air-quick-fix/) on Google Code.

The division of work between Dick and I worked really well. Dick worked on the
back-end code in Python while I worked in Flex on the front-end. We used PyAMF
to connect the back-end to the front-end. PyAMF made the whole process very
easy. The only challenge was in figuring out how to transform the data types
correctly. The first version of the application came together in a couple of
hours.

The back-end Python code is really simple. Here is the method that is called
from the client (trimmed down a bit):

    
    def fiximage(data):  
      image_in = Image(str(data))
      image_in.im_feeling_lucky()
      
      image_out = ByteArray()
      image_out.write(image_in.execute_transforms())  
      return image_out

  
In this code, the data which is passed to the method is just a ByteArray
containing the image. The data is turned into an Image, the im_feeling_lucky
transform is specified, then run - taking the bytes and sending them back to
the client.

The front-end Flex code that sends the image to the back-end is also really
simple:

The RemoteObject (AMF networking API in Flex) is defined as:

  
The function which actually makes the request to the back-end is:

    
    var stream:FileStream = new FileStream();
    stream.open(startFile, FileMode.READ);
    var imageData:ByteArray = new ByteArray();
    stream.readBytes(imageData);
    ro.fiximage(imageData);

  
In this Flex code the image file is opened, read into a ByteArray, then sent
to the fiximage method on the back-end.

There is a bunch of other Flex code that creates the UI, handles selecting,
saving, and dragging and dropping images but is all pretty straightforward.

Dick and I really enjoyed creating this application together. It shows off
some of the strengths of each technology well and shows how easy it is to use
the technologies together. Let us know what you think about the application.

