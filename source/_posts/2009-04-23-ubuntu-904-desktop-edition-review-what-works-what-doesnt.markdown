---
date: '2009-04-23 08:47:27'
layout: post
slug: ubuntu-904-desktop-edition-review-what-works-what-doesnt
status: publish
title: Ubuntu 9.04 Desktop Edition Review - What works.  What doesn't.
wordpress_id: '851'
categories:
- Linux
---

Since the days when I installed Slackware Linux via a stack of 3.5" floppies, Linux has been a *nearly* suitable desktop for me.  With some tinkering and with VMWare to run Windows when I need it I've been able to use Linux as my primary desktop OS for around 15 years.  As computers and software have evolved Linux has had to keep up.  In some areas it's done exceptionally well and in others it has struggled.  But based on the improvements in Ubuntu Jaunty I believe the pace of improvement is accelerating.  This means that many of the niche oddities and problems with Linux should soon be ironed out.

With the [recent release of Ubuntu 9.04](http://www.ubuntu.com/news/ubuntu-9.04-desktop) aka Jaunty I wanted to give a brief overview of what works for me and what doesn't.  My requirements for an operating system are not the same as everyone else's.  So some of these may not matter to others.  First let me describe what I primarily use my computer for.  I travel frequently so things like battery life, suspend, and 3G connectivity are important.  My employer uses Exchange so being able to access my email, contacts, and calendar while offline is essential.  I do development on Java and Flex so those development platforms must work.  I regularly present at conferences and user groups so connecting to external displays and solid presentation tools are essential.  So let's see how Jaunty does in these areas:

**Battery Life**

The 9-cell battery on my Lenovo W500 now lasts four to five hours!  This is a significant improvement!  In the past I was never able to get more than about two hours.  Also tools such as PowerTOP help me identify which processes are waking up the processor most frequently.

**Suspend**

I never hibernate to disk so I'm not sure if that works.  But suspend now regularly works when using the Intel video card (my laptop has both Intel and ATI).  The only problem with suspend is that my F3507g doesn't come back after I resume.  I'm not sure if there is a bug for this yet other than [a comment](https://bugs.launchpad.net/ubuntu/+source/network-manager/+bug/287893/comments/16) on another bug.

**3G**

Sometimes 3G dial-up works.  My F3507g card for some reason is a lot slower than using a PCMCIA 3G card.  But strangely I can only get my PCMCIA card to connect occasionally.  I'm not sure if there are bugs for either of these issues.  Overall NetworkManager has led to significant improvements in 3G connection handling.  And more improvements are expected with NetworkManager 0.8, which will include ModemManger.

**Email**

Using Evolution for my personal email via IMAP has always worked fine.  However using Evolution for my work email has been hit and miss over the past few years.  It used to work sometimes before my email account was switched to Exchange 2007.  Since then it has pretty much not worked at all.  I could use IMAP but then I wouldn't be able to access my contacts and calendar.  So unfortunately I've been using Outlook via VMWare.  I do have hope though that the evolution-mapi support will soon stabilize and I can ditch Outlook.  Right now there are a number of [evolution-mapi bugs](https://bugs.launchpad.net/ubuntu/+source/evolution-mapi/+bug/338982), some of them crashers.

**Display**

After a number of problems with my ATI card (performance, suspend, Xrandr, etc.) I gave up and switched over to my Intel card.  So far things have worked much better than they ever have with display drivers on Linux.  Xrandr now actually works to mirror my display when I plug into an external monitor.  However I continue to have problems with gnome-display-properties and compiz.

**Boot Performance**

One of the best improvements with Jaunty is boot performance.  My W500 now boots from the Grub menu to GDM in 16 seconds!  Hopefully the next release of Ubuntu (Karmic Koala) will incorporate the kernel mode setting stuff to trim the boot time down even further.

**Office Productivity**

For some people OpenOffice is a viable alternative to Office, but unfortunately not for me.  The PowerPoint and Word conversions are not 100% perfect.  The reviewing / tracking changes mode in Office is still second to none.  So I've been trying to use online solutions like [Buzzword](http://www.acrobat.com) and [SlideRocket](http://www.sliderocket.com) more.  Once these new platforms support full offline editing I think I'll be able to mostly stop using Office.  But for now I'm stuck with Office via Windows on VMWare.

**Screen Sharing**

I frequently use [Adobe Acrobat Connect](http://acrobat.com) to do remote presentations.  However there isn't a presenter plugin for Linux so this is another thing that keeps me using Windows.  Please [go vote for this](https://na5.brightidea.com/ct/ct_a_view_idea.bix?c=8FBBEA8F-D8E6-4E34-A7C1-7C74FB3B4EFA&idea_id=3F96AA68-9F30-41F3-8727-399E8AA5BD9E) on the Acrobat.com Ideas website.

**Accelerometer**

My laptop has an accelerometer and although the hdaps module is supposed to make it work the module won't load.  There is an [open bug](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/57315) for this one.

**Overall**

Overall Jaunty is a solid release that moves Linux closer to being my full-time desktop.  For the first time I can see on the horizon the day when I no longer have to use Windows (dual-booted or via VMWare).  Thank you Ubuntu and everyone else who builds this great stack of open source software!
