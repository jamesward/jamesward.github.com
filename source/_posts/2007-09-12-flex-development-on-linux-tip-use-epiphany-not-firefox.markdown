---
author: admin
date: '2007-09-12 14:07:54'
layout: post
slug: flex-development-on-linux-tip-use-epiphany-not-firefox
status: publish
title: 'Flex Development on Linux Tip: Use Epiphany not Firefox'
wordpress_id: '166'
categories:
- Flex
- Linux
---

I am usually on Linux when I develop Flex applications and I recently
discovered a cool trick that makes development even easier. Use Epiphany as
the browser you run / test your applications in instead of Firefox. Here's a
few reasons: - If Epiphany crashes because your app goes crazy it doesn't take
your normal browser and all its sessions down with it. - Epiphany uses inotify
or a file watch and automatically refreshes when your application changes. It
saves quite a bit of time to have the application already loaded before I can
even switch to my browser. - Flash works the same in Epiphany as it does in
any other browser.

I hope others find this useful.

