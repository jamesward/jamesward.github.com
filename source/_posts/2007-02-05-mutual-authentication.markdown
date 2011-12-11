---
author: admin
date: '2007-02-05 10:57:44'
layout: post
slug: mutual-authentication
status: publish
title: 'Mutual Authentication: Prevents Phishing Attacks?'
wordpress_id: '93'
categories:
- Security
---

One of my credit card companies just implemented Mutual Authentication for
their web site. I think this is a fantastic idea since it can help to protect
users from phishing attacks. The hard part will be training users to not enter
their credentials unless they see the tokens they selected.

Continue reading to see how Juniper implemented Mutual Authentication.

After Juniper implemented this new feature I logged in and had to select an
image and a phrase: ![](http://www.jamesward.org/wordpress/wp-
content/uploads/2007/02/cc_enroll.jpg)

Now every time I login, after I enter my username, I should see the image and
phrase I selected: ![](http://www.jamesward.org/wordpress/wp-
content/uploads/2007/02/cc_login.jpg)

I really like the concept of this. But I think it could be implemented in such
a way that users wouldn't have to understand the concept of Mutual
Authentication and why they shouldn't enter their password if they don't see
the image/phrase they selected. What if the password was a combination of a
strong, user-selected token, and something the user has to identify from an
image they selected, that only they would know. For instance if the image I
selected was a map of the United States and the website asked me to enter my
password, plus, select on the map where I got married, then phishing is more
difficult. To make this work there would have to be a few different picture
question options that I selected when I first setup the mutual authentication.
Other ideas for picture question passwords: "Circle your brother in the
picture above" "Pick your favorite color in the picture above" "Select your
favorite flower in the picture above" "Select the style of car you drive in
the picture above"

What do you think? Would this sort of thing help prevent phishing attacks?

