---
date: '2006-11-27 13:26:50'
layout: post
slug: howto-reduce-the-size-of-your-flex-app
status: publish
title: 'HowTo: Reduce the size of your Flex app'
wordpress_id: '74'
categories:
- Flex
- Open Source
- RIA
---

Flex 2 added a neat little feature which allows you to load Runtime Shared Libraries, from other domains.  And since the browser caches these libraries in theory we could all point to a central set of Flex 2 Framework RSLs and users of your application would only have to download the RSLs the first time they went to an application which used them.  Before I show you how to make this work, lets talk about the caveats...  First and most important, THIS IS UNSUPPORTED BY ADOBE.  While the Flex team is working on a better, more permanent solution to this problem, this is really a hack and despite the fact that I am using this in my applications, neither I or Adobe warranty or support the use of this in any way.  Second, since there is no failover mechanism, until we find a better home for the RSLs, if you choose to point to my hosted RSLs, your application will be at the mercy of my web server.  Third, if someone hacks my web server and uploads new cracked malware RSLs, or uses a man-in-the-middle attack to replace the RSLs in flight, then you (and I) have been [p0wned](http://www.urbandictionary.com/define.php?term=p0wned).  Fourth, I, James Ward, may have included modified Flex framework files which do bad things, like track user behavior/input and report them back to my server.  While I promise I have not done this, if you choose to use these RSLs, you are putting your trust in my promise.

So despite the caveats, I still think this hack is sufficient enough for many applications.  Flex engineering is really working hard to make this work for everyone.  In the mean time what is outlined here may likely help you to dramatically reduce SWF size.  Read on to find out how.


**Quick Start**

I've created 3 RSLs, a small one, with just the dependencies of mx.core.Application and a medium one with what I guessed were the 20 or so most commonly used components, and then a large one with over 30 other components.  Each RSL does not include the contents of the smaller RSLs.  So if you want to take advantage of this technique using the medium RSL, then you will need to use the medium AND the small RSL.  Here is table with the information about the RSLs:





RSLSizeSWCLinker SourceSWC Catalog




[small


106K


[Download SWC](http://ws.jamesward.org/framework-2_0_1_b-small.swc)


[smallLinker.as](http://flexapps.cvs.sourceforge.net/flexapps/hosted_rsls/src/smallLinker.as?view=log)


[Catalog XML](http://ws.jamesward.org/framework-2_0_1_b-small.xml)






[medium


160K


[Download SWC](http://ws.jamesward.org/framework-2_0_1_b-medium.swc)


[mediumLinker.as](http://flexapps.cvs.sourceforge.net/flexapps/hosted_rsls/src/mediumLinker.as?view=log)


[Catalog XML](http://ws.jamesward.org/framework-2_0_1_b-medium.xml)






[large


141K


[Download SWC](http://ws.jamesward.org/framework-2_0_1_b-large.swc)


[largeLinker.as](http://flexapps.cvs.sourceforge.net/flexapps/hosted_rsls/src/largeLinker.as?view=log)


[Catalog XML](http://ws.jamesward.org/framework-2_0_1_b-large.xml)




Once you have decided which RSL to use, follow these instructions:
1) Download the SWC for the RSL(s) you want to use from [ws.jamesward.org](http://ws.jamesward.org)
2) Fix your build path
2.1) If you are compiling via Ant or the command line, then specify your external-library-path and runtime-shared-libraries like:



`flex2-sdk/bin/mxmlc \
  -external-library-path+=build/framework-2_0_1_b-small.swc,build/framework-2_0_1_b-medium.swc  \
  -runtime-shared-libraries=http://ws.jamesward.org/framework-2_0_1_b-small.swf,http://ws.jamesward.org/framework-2_0_1_b-medium.swf\
  -o=build/testHostedFlexLibs-medium.swf \
  -file-specs=test/testHostedFlexLibs.mxml
`




2.2) If you are using Flex Builder then go to Project -> Properties -> Flex Build Path -> Library Path -> Add SWC -> [Enter or browse to the first SWC] -> Add all the SWCs you will be using.  Then select a SWC's RSL URL and select the Edit button.  Change the Link Type to "Runtime shard library (RSL)", set the RSL URL to the correct swf url on ws.jamesward.org, deselect the "Auto extract checkbox", and then select the OK button.  Repeat this for each SWC.  When done, select the OK button to exit the Project Properties.  Here is what my Build Path looks like:
![Build Path](http://www.jamesward.org/wordpress/wp-content/uploads/2006/11/buildpath.png)

2.3) If you are using FDS, then just add the SWC(s) to your flex/user_classes dir and update the runtime-shared-libraries accordingly in the flex-config.xml file.

3) Recompile your Flex app (if Flex Builder didn't do this for you automatically) and the file size should be significantly lower!

4) One more caveat...  You have to actually load your application from a web server for it to work.  This is due to the Flash local OR network sandbox.  Maybe someone can suggest a better workaround.

**How It Works**

This all starts with the Preloader.  The out of the box preloader doesn't support cross domain loaded RSLs.  If you use my hosted RSL(s) then you don't need to worry about this since it includes the patched Preloader.  However, if you are interested in really knowing how this all works, or if you want to download the source code and play with it, then here is what you need to do.  In order for your application to be able to use the classes in the crossdomain loaded RSL, the Preloader needs to specify the securityDomain for the loaderContext of the RSLs.  So in the loadRSL function of my patched mx/preloaders/Preloader.as file I have:



`loaderContext.securityDomain = SecurityDomain.currentDomain;
loaderContext.applicationDomain = ApplicationDomain.currentDomain;
`




The source code I use to build the RSLs is available on [Source Forge](http://sourceforge.net/projects/flexapps).  If you want to play with the code, then you will need to copy the Preloader.as from the Flex SDK's source code, update the RSL loaderContext as noted above, and add the import for the flash.system.SecurityDomain class.

You can also see that I have a [wildcard crossdomain.xml](http://ws.jamesward.org/crossdomain.xml) policy file on ws.jamesward.org which allows Flash player to load the RSLs no matter what domain the requesting application is hosted on.  One quick note on crossdomain policy files, since I don't think it is said clearly enough, and often enough...
DO NOT EVER PUT A WILDCARD CROSSDOMAIN POLICY FILE ON A DOMAIN IF EITHER OF THE FOLLOWING APPLY:
 - THE DOMAIN IS USED FOR COOKIE BASED OR BASIC AUTHENTICATION
 - THE DOMAIN IS ON AN INTERNAL NETWORK

Now about the small, medium, and large RSLs...  For now I opted to use just three RSLs to keep it simple.  I am using just simple linker classes and compc to create the SWCs, then expanding the SWCs to get the SWF, which is the RSL.  You can see all this in the source code, specifically, the [build.sh](http://flexapps.cvs.sourceforge.net/flexapps/hosted_rsls/build.sh?view=log) file.  I have also guessed at the best way to organize the RSLs (as far as what classes go where), but definitely want to hear what others think.

Now the fun part...  To prove this all works, first go to the [test app](http://www.jamesward.org/testHostedFlexLibs-large-1.swf) on www.jamesward.org and watch as the RSLs are loaded from ws.jamesward.org.  You should now have all 3 RSLs in your browser cache and if you now go to another [test app](http://www.thebetterside.com/testHostedFlexLibs-large-1.swf) on a different domain the application should load much faster since it only needs to load 72K instead of what would have been over 400K (my test app doesn't use all the classes in the three RSLs).

**The Future?**

I'd really like to hear feedback if this is a viable hack for those looking to reduce Flex app size.  Let me know if you plan to use this technique, or if you don't, why?  What should be different?  Also, I think someone could further hack the preloader to support failover and md5 checksums.  Any takers?

Thanks in advance for your feedback!
