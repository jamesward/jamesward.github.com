---
author: admin
date: '2009-09-29 07:01:00'
layout: post
slug: flex-builder-3-on-eclipse-3-5
status: publish
title: Flex Builder 3 on Eclipse 3.5
wordpress_id: '1235'
categories:
- Flex
---

UPDATE: Flash Builder 4 (the new version of Flex Builder) officially supports
Eclipse 3.5. [Download Flash Builder
4](http://www.adobe.com/go/try_flashbuilder).

I recently tried to upgrade to Eclipse 3.5 on my Ubuntu Linux desktop.
Unfortunately this caused [some
problems](http://bugs.adobe.com/jira/browse/FB-21284) with the [Flex Builder 3
for Linux alpha
4](http://labs.adobe.com/technologies/flex/flexbuilder_linux/). According to
the stack traces in Eclipse the main problems seemed to stem from the
com.adobe.flexbuilder.project.compiler.internal.ProblemManager class. So I
decided to re-write that class from scratch to see if I could make the
problems go away. My new implementation of ProblemManager seems to have fixed
the issues that I was seeing. I've only tested this on Linux so I'm not sure
if it will fix any problems on Mac or Windows. Here are the instructions for
fixing the problems with Flex Builder 3 on Eclipse 3.5 on Linux:

  1. Make sure you have installed Eclipse 3.5 and the Flex Builder 4 for Linux alpha 4
  2. Download the [ProblemManager patch](http://www.jamesward.com/downloads/ProblemManager.zip)
  3. Unzip the ProblemManager patch file
  4. Locate where Flex Builder is installed - in my case: ~/flex_stuff/Adobe_Flex_Builder_Linux
  5. Update the com/adobe/flexbuilder/project/compiler/internal/ProblemManager.class file in <Flex Builder Install Location>/eclipse/plugins/com.adobe.flexbuilder.project_3.0.204732/zornproject.jar with the file extracted from the patch
  6. Start Eclipse 3.5
  7. Smile!
  
UPDATE: Instructions for Windows were [posted on
InsideRIA](http://www.insideria.com/2009/09/fixed-an-internal-build-
error.html) by [Mike Slinn](http://www.mslinn.com). Thanks Mike!

So far this works for me. But I'm sure there are some problems I haven't
discovered with it yet. So please let me know if you have any problems. Also
if someone wants to check this on Windows or Mac let me know if it works
there. If not then feel free to update the ProblemManager.java class so that
it does work.

DISCLAIMER: This patch is totally unsupported by Adobe. Use at your own risk.

