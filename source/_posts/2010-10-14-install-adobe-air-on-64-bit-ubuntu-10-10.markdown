---
date: '2010-10-14 07:22:05'
layout: post
slug: install-adobe-air-on-64-bit-ubuntu-10-10
status: publish
title: Install Adobe AIR on 64-bit Ubuntu 10.10
wordpress_id: '2064'
categories:
- Adobe AIR
- Linux
---

Right now Adobe AIR is only officially available for 32-bit Linux.  But it does work on 64-bit Linux with the 32-bit compatibility libraries.  There are several ways to install Adobe AIR on Linux.  My preferred way on Ubuntu is to use the .deb package.  However the .deb package distributed by Adobe can only be installed on 32-bit systems.  Good news is that this can be easily fixed!  To install the Adobe AIR .deb package on a 64-bit system just follow these steps:

1. [Download the Adobe AIR .deb file](http://get.adobe.com/air/)

2. In a terminal window go to the directory containing the adobeair.deb file

3. Create a tmp dir: 
    
        mkdir tmp

4. Extract the deb file to the tmp dir: 
    
        dpkg-deb -x adobeair.deb tmp

5. Extract the control files: 
    
        dpkg-deb --control adobeair.deb tmp/DEBIAN

6. Change the Architecture parameter from "i386" to "all": 
    
        sed -i "s/i386/all/" tmp/DEBIAN/control

7. Repackage the deb file: 
    
        dpkg -b tmp adobeair_64.deb

Now you can install Adobe AIR on a 64-bit system!  From the command line just do: 
    
    sudo dpkg -i adobeair_64.deb

That's it!  Let me know if you have any questions.
