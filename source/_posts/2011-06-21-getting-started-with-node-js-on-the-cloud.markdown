---
author: admin
date: '2011-06-21 10:21:22'
layout: post
slug: getting-started-with-node-js-on-the-cloud
status: publish
title: Getting Started with Node.js on The Cloud
wordpress_id: '2376'
categories:
- Cloud
- Heroku
- JavaScript
- Node.js
---

In my new job at salesforce.com I'm incredibly exited about getting into
[Heroku](http://www.heroku.com), a Platform as a Service provider / Cloud
Application Platform. In a future blog post I'll provide more details on what
Heroku is and how it works. But if you are like me the first thing you want to
do when learning a new technology is to take it for a test drive. I decided to
take my Heroku test drive using the [recently announced Node.js
support](http://devcenter.heroku.com/articles/node-js). I'm new to Node.js,
but at least I know JavaScript. Heroku also offers Ruby / Rails support but I
don't know Ruby - yet. So let me walk you through the steps I took (and that
you can follow) to get started with Node.js on the Heroku Cloud.

(If you have already signed up for Heroku, installed the heroku command line
client, and installed git then skip ahead to Step 6.)

Step 1) [Sign up for Heroku](http://www.heroku.com/signup)

Step 2) Install the heroku command line client

All of the Heroku management tasks are exposed through a RESTful API. The
easiest way to call those APIs is using the [heroku open source command
line](https://github.com/heroku/heroku) Ruby app. To install the heroku
command line I first had to install Ruby. I'm on Ubuntu Linux so this process
will be slightly different if you are on Windows or Mac but the [Heroku Dev
Center](http://devcenter.heroku.com/articles/quickstart) provides more
information on how to do this on Windows and Mac. On Ubuntu you can install
Ruby with apt-get (or various other tools):

    
    
    sudo apt-get install ruby
    

Now [download RubyGems](http://rubygems.org/pages/download), unpack, and then
install it:

    
    
    sudo ruby setup.rb
    

This installs the gem utility at /usr/bin/gem1.8 but I also created a symlink
to it so I can run it with just the "gem" command:

    
    
    sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
    

Now the heroku gem can be installed:

    
    
    sudo gem install heroku
    

Heroku should now run from the command line:

    
    
    heroku
    

  
You should see something like:

    
    
    Usage: heroku COMMAND [--app APP] [command-specific-options]  
    Primary help topics, type "heroku help TOPIC" for more details:  
      auth      # authentication (login, logout)
      apps      # manage apps (create, destroy)
      ps        # manage processes (dynos, workers)
      run       # run one-off commands (console, rake)
      addons    # manage addon resources
      config    # manage app config vars
      releases  # view release history of an app
      domains   # manage custom domains
      logs      # display logs for an app
      sharing   # manage collaborators on an app  
    Additional topics:  
      account      # manage heroku account options
      db           # manage the database for an app
      help         # list commands and display help
      keys         # manage authentication keys
      maintenance  # toggle maintenance mode
      pg           # manage heroku postgresql databases
      pgbackups    # manage backups of heroku postgresql databases
      plugins      # manage plugins to the heroku gem
      ssl          # manage ssl certificates for an app
      stack        # manage the stack for an app
      version      # display version
    

  
Step 3) Login to Heroku via the command line

You can verify that everything is setup correctly by logging into Heroku
through the heroku command line. This will save an API key into a
~/.heroku/credentials file. That key will be used for authenticating you on
subsequent requests. Just run the following command and enter your Heroku
credentials:

    
    
    heroku auth:login
    

  
Step 4) Install git

The git tool is used to transfer apps to Heroku. On Ubuntu I installed it by
doing:

    
    
    sudo apt-get install git
    

  
Step 5) Setup your SSH key

Heroku uses SSH keys to authenticate you when you push files through git. If
you don't already have a SSH key then you will need to generate one (I used
ssh-keygen).

Step 6) Create an app on Heroku

A new app needs to be provisioned on Heroku. Since Heroku supports multiple
application provisioning stacks you will need to tell it the stack you want to
use, unless it's the default. For Node.js we need to use the "cedar" stack
which is not the default since it's still in beta. To do that run:

    
    
    heroku create -s cedar
    

A default / random app name is automatically assigned to your app. It will be
somethingunique.herokuapp.com. You can change the name either through the
[Heroku web admin](https://api.heroku.com/myapps) or via the command line:

    
    
    heroku apps:rename --app somethingunique hellofromnodejs
    

When the app was created your SSH key should have also been uploaded to Heroku
for git access. You can manage the keys associated with an app using the
"heroku keys" commands. Check out "heroku help keys" for more details.

Now that the app is provisioned it needs something to actually run! So lets
build a Node.js app and then upload it to Heroku.

Step 7) Install Node.js

On Ubuntu I installed Node.js through apt-get. But first I had to add a PPA so
that I could get the latest version.

    
    
    sudo apt-add-repository ppa:jerome-etienne/neoip
    sudo apt-get update
    sudo apt-get install nodejs
    

  
For other platforms, check out the [Node.js Download
page](http://nodejs.org/#download).

Step 8) Create a Node.js app

I started by building a very simple "hello, world" Node.js app. In a new
project directory I created two new files. First is the package.json file
which specifies the app metadata and dependencies:

    
    
    {
      "name": "heroku_hello_world",
      "version": "0.0.1",
      "dependencies": {
        "express": "2.2.0"
      }
    }
    

Then the actual app itself contained in a file named web.js:

    
    
    var express = require('express');  
    var app = express.createServer(express.logger());  
    app.get('/', function(request, response) {
      response.send('hello, world');
    });  
    var port = process.env.PORT || 3000;
    console.log("Listening on " + port);  
    app.listen(port);
    

This app simply maps requests to "/" to a function that sends a simple string
back in the response. You will notice that the port to listen on will first
try to see if it has been specified through an environment variable and then
fallback to port 3000. This is important because Heroku can tell our app to
run on a different port just by giving it an environment variable.

Step 9) Install the Node.js app dependencies

My simple Node.js app requires the [Express Node.js
library](http://expressjs.com/). In order to install Express, the [Node
Package Manager](http://npmjs.org/) (npm) is required. Installing npm on
Ubuntu was a bit trickey because I didn't feel the regular method followed
good security practices. So I followed the alternative install instructions by
just cloning npm from github and then installed it from source:

    
    
    git clone git://github.com/isaacs/npm.git
    cd npm
    sudo make install
    

  
Now we can install the node dependencies into the local project directory.
Just run:

    
    
    npm install .
    

  
This uses the package.json to figure out what dependencies the app needs and
then copies them into a "node_modules" directory.

Step 10) Try to run the app locally

From the command line run:

    
    
    node web.js
    

  
You should see "Listening on 3000" to indicate that the Node.js app is
running! Try to open it in your browser:
[http://localhost:3000/](http://localhost:3000/)

Hopefully you will see "hello, world".

Step 11) Create a Procfile

Heroku uses a "Procfile" to determine how to actually run your app. Here I
will just use a Procfile to tell Heroku what to run in the "web" process. But
the Procfile is really the foundation for telling Heroku how to run your
stuff. I won't go into detail here since Adam Wiggins has done a great [blog
post about the purpose and use of a Procfile](http://blog.heroku.com/archives/
2011/6/20/the_new_heroku_1_process_model_procfile/). Create a file named
"Procfile" in the project directory with the following contents:

    
    
    web: node web.js
    

  
This will instruct Heroku to run the web app using the node command and the
web.js file as the main app. Heroku can also run workers (non-web apps) but
for now we will just deal with web processes.

Note: Once you have a Procfile you can [run your application locally using For
eman](http://devcenter.heroku.com/articles/procfile#developing_locally_with_fo
reman). This allows you to simulate locally how Heroku will run your app based
on your Procfile.

Step 12) Store the project files in a local git repo

In order to send the app to Heroku the files must be in a local git
repository. Of course you can also put them in a remote git repo (like
github.com). To create the local git repo run the following inside of your
project directory:

    
    
    git init
    

  
Now add the three files you've created to the git repo:

    
    
    git add package.json Procfile web.js
    

  
Note: Make sure you don't add the node_modules directory to the git repo! You
can have git ignore it by creating a .gitignore file containing just
"node_modules".

And commit the files to the local repo:

    
    
    git commit -m "initial commit"
    

  
Step 13) Push the project files to Heroku

Now we need to tell git about the remote repository on Heroku which we will
push the app to. When you provisioned the app on Heroku it gave you a web URL
and a git URL. If you don't have the git URL anymore you can determine it
either by running the "heroku apps" command or by navigating to the [app on
heroku.com](https://api.heroku.com/myapps). The git URL will be something like
"git@heroku.com:somethingunique.git" where the "somethingunique" is your app's
name on Heroku. Once you have the git URL add the remote repo:

    
    
    git remote add heroku git@heroku.com:somethingunique.git
    

  
Note: If we had created the git repo before creating the Heroku app then the
heroku command line client would have automatically added the remote repo to
your git configuration.

Now you can push your app to Heroku! Just run:

    
    
    git push heroku master
    

  
You should see something like:

    
    
    Counting objects: 6, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (4/4), done.
    Writing objects: 100% (6/6), 617 bytes, done.
    Total 6 (delta 0), reused 6 (delta 0)  
    -----> Heroku receiving push
    -----> Node.js app detected
    -----> Vendoring node 0.4.7
    -----> Installing dependencies with npm 1.0.8
           express@2.2.0 ./node_modules/express 
           ├── mime@1.2.2
           ├── connect@1.4.4
           └── qs@0.1.0
           Dependencies installed
    -----> Discovering process types
           Procfile declares types -> web
    -----> Compiled slug size is 3.1MB
    -----> Launching... done, v4
           http://somethingunique.herokuapp.com deployed to Heroku  
    To git@heroku.com:somethingunique.git
     * [new branch]      master -> master
    

  
Now you should be able to connect to your app in the browser! You can also get
some diagnostic information out of the heroku command line. To see your app
logs (provisioning, management, scaling, and system out messages) run:

    
    
    heroku logs
    

  
To see your app processes run:

    
    
    heroku ps
    

  
And best of all, if you want to add more Dynos* just run:

    
    
    heroku scale web=2
    

* Dynos are the isolated containers that run your web and other processes. They are managed by the Heroku Dyno Manifold. [Learn more about Dynos](http://devcenter.heroku.com/articles/dynos).  
That increases the number of Dynos running the app from one to two.
Automatically Heroku will distribute the load across those two Dynos, detect
dead Dynos, restart them, etc! That is seriously easy app scalability!

There is much more to Heroku and I'll be continuing to write about it here.
But in the meantime, check out all of the great docs in the [Heroku Dev
Center](http://devcenter.heroku.com/). And please let me know if you have any
questions or problems. Thanks!

