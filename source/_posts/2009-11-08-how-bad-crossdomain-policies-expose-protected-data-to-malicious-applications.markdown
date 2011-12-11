---
author: admin
date: '2009-11-08 03:15:22'
layout: post
slug: how-bad-crossdomain-policies-expose-protected-data-to-malicious-applications
status: publish
title: How Bad Crossdomain Policies Expose Protected Data to Malicious Applications
wordpress_id: '1323'
categories:
- Flash Player
- Flex
- Security
---

The web's success has been partially due to the sandbox it provides users.
Users do not generally have to entirely trust every website they visit because
malicious web sites should be sandboxed from doing the user harm. One way that
web sites are sandboxed is through a same-origin policy. By default any code
that runs inside a web browser can only access data from the domain in which
the code originated from. So if code (JavaScript, Flash, etc) loads from the
foo.com domain then it can't access data on the bar.com domain. The code may
be able to make requests to bar.com but the code from foo.com shouldn't be
able to read or access the results of those requests.

Since Rich Internet Applications built with Flex, Silverlight, etc usually try
to do more on the client side, for example mash-up data from multiple sites,
the same-origin policy presents a problem.

In most cases Flash Player sticks with the typical browser sandbox concepts.
But there are a few places where it goes outside this boundary such as with
microphone and webcam access. Another area is by allowing opt-in to cross-
domain communication bypassing the browser's regular same-origin policy. Other
plugins such as Silverlight and JavaFX also do this. This cross-domain
capability is powerful but also [very
dangerous](http://tech.slashdot.org/story/09/11/05/1552204/Facebook-and-
MySpace-Backdoors-Found-Fixed). The primary reason it's dangerous is that a
malicious application can potentially make requests on behalf of the user and
access data from domains that the application didn't originate from. To
protect against these types of attacks Flash Player and other plugins have
implemented a cross-domain policy system. This policy system is one of the
most misunderstood aspects of web security.

To illustrate the problem I've create a few demos. Let's say that I'm building
an application for www.jamesward.com that will fetch [some
data](http://www.firststepsinflex.com/data.php) from the
www.firststepsinflex.com site.

[Here's that application](http://www.jamesward.com/demos/crossdomainDashboard/
crossdomainDashboard.html) on www.jamesward.com - open it in a new window.

The application correctly pulled the data from the
[www.firststepsinflex.com](http://www.firststepsinflex.com) site but in order
to allow the request I blindly put a [crossdomain.xml policy
file](http://www.firststepsinflex.com/crossdomain.xml) on
www.firststepsinflex.com that looks like this:

    
    
    
    
        
        
    

  
What this policy file does is instruct Flash Player to allow requests from any
website to get around the same-origin policy and make requests to
www.firststepsinflex.com - on behalf of the user. Sounds harmless, right? At
this point it is, as long as all of the data on www.firststepsinflex.com is
publicly available data. But let's suppose that not all of the data should be
publicly available. Perhaps I'm protecting access to some data though cookie
authentication or HTTP basic authentication. In this case I am (for the
purpose of the demo).

See the protected data by opening up [http://www.firststepsinflex.com/private/
bankaccounts.html](http://www.firststepsinflex.com/private/bankaccounts.html)
using "username" and "password" (without quotes) for the user name and
password.

Now imagine that someone starts posting Twitter links (obfuscated through a
URL shortener) phishing for people to open a [malicious application](http://ww
w.drunkonsoftware.com/crossdomainHacker/crossdomainHacker.html) (open it in a
new window - I promise it doesn't do anything bad).

So let's recap... There is a [protected
resource](http://www.firststepsinflex.com/private/bankaccounts.html) that only
you should be able to see in your browser. Other applications should NOT be
able to see that data. But a [malicious application](http://www.drunkonsoftwar
e.com/crossdomainHacker/crossdomainHacker.html) was able to load that same
data and do whatever it wants with it. Scary.

Here's how it works... The malicious application requests the [protected
page](http://www.firststepsinflex.com/private/bankaccounts.html). It was able
to make the request because you were authenticated already. And the malicious
application can now read the data contained in the page and do whatever it
wants with it (probably send it back to a server somewhere).

OK. Now do you understand why crossdomain.xml policy files are dangerous?
Imagine if Facebook, MySpace, or YouTube had a misconfigured policy file on
their servers! Well they have - but they've since been fixed. Imagine if your
bank or a corporate intranet had a misconfigured policy file. There are some
very serious ramifications to these types of attacks.

There are also some great uses of crossdomain policy files. For instance,
api.flickr.com has an [open crossdomain.xml policy
file](http://api.flickr.com/crossdomain.xml). This allows applications loaded
from anywhere to access Flickr data and it's safe because api.flickr.com
doesn't use cookies or basic auth - they use web service tokens, which are not
automatically transmitted by the browser and are only known to the application
that performed the authentication.

I often hear from Flex / Flash developers that when they run into security
sandbox issues the first thing they try is to open things up with a global
(i.e. "*") policy file. I hope this article discourages that practice.
Developers should understand why the security error is happening and consider
alternatives before blindly opening up their website to the possible attacks.
One alternative is to leverage a server proxy. A server proxy can be
configured so that an application doesn't violate the same-origin policy. For
instance, if an application on foo.com needs data from bar.com then a proxy
can be configured such that requests to foo.com/bar are forwarded on the
server to the bar.com site. This helps avoid attacks because users' cookies
(or basic auth tokens) will not be sent to bar.com since all requests are
actually being made to the foo.com site. But be careful not to expose intranet
servers through proxies. Here is a sample Apache config for setting up a
forward proxy:

    
      ProxyRemote  /bar/*  http://bar.com/
      ProxyPass /bar http://bar.com
      ProxyPassReverse /bar http://bar.com

  
[BlazeDS](http://opensource.adobe.com/blazeds) also includes a proxy service.

If you really need to use a crossdomain policy file then be very careful!
NEVER put a crossdomain policy file on a site that uses cookie or basic auth
and NEVER put a crossdomain policy file on an intranet site - unless you
really know what you are doing. To learn how to safely use crossdomain policy
files here are some great resources:

  * [Policy file changes in Flash Player 9 and Flash Player 10](http://www.adobe.com/devnet/flashplayer/articles/fplayer9_security.html)
  * [Cross-domain policy file specification](http://www.adobe.com/devnet/articles/crossdomain_policy_file_spec.html)
  
I hope this helps create better understanding of web security. Please let me
know if you have any questions.

