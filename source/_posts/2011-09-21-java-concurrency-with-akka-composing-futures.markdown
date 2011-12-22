---
date: '2011-09-21 08:45:22'
layout: post
slug: java-concurrency-with-akka-composing-futures
status: publish
title: 'Java Concurrency with Akka: Composing Futures'
wordpress_id: '2651'
categories:
- Akka
- Java
---

I've been intrigued by [Akka](http://akka.io/) for a while but finally I was able to take it for a spin.  The first thing I wanted to learn was how to compose Futures.  Composing Futures provides a way to do two (or more) things at the same time and then wait until they are done.  Typically in Java this would be done with an `ExecutorService`.  I put together a quick little demo that shows how to do the same thing with `Futures` in Akka.

All of the code for this demo is on github:  
[http://github.com/jamesward/AkkaFun](http://github.com/jamesward/AkkaFun)

First I setup a Gradle build that pulls in the Akka dependency and will allow me to easily launch the demo app.  Here is the `build.gradle` file:

```
apply plugin:"application"
mainClassName = "com.jamesward.akkafun.SimpleFutures"

repositories {
    mavenCentral()
}

dependencies {
  compile "se.scalablesolutions.akka:akka-actor:1.2-RC6"
}
```

For this demo I also wanted to increase the Akka timeout to 1 minute (the default is 5 seconds).  To do this I created a `src/main/resources/akka.conf` file containing:

```
akka {
    actor {
        timeout = 60
    }
}
```

I then setup a `Callable` class that does some work and then returns it's result.  For this example the work is just to pause for a random amount of time and the result is the amount of time it paused for.  Here is the `src/main/java/com/jamesward/akkafun/RandomPause.java` file:

```java
package com.jamesward.akkafun;

import java.util.concurrent.Callable;

public class RandomPause implements Callable<Long>
{

    private Long millisPause;

    public RandomPause()
    {
        millisPause = Math.round(Math.random() * 8000) + 2000; // 2,000 to 10,000
        System.out.println(this.toString() + " will pause for " + millisPause + " milliseconds");
    }

    public Long call() throws Exception
    {
        Thread.sleep(millisPause);
        System.out.println(this.toString() + " was paused for " + millisPause + " milliseconds");
        return millisPause;
    }
}
```

I used a simple Java app to compose the `RandomPause` futures.  Here is the `src/main/java/com/jamesward/akkafun/SimpleFutures.java` file:

```java
package com.jamesward.akkafun;

import java.util.ArrayList;
import java.util.List;

import akka.dispatch.Future;
import static akka.dispatch.Futures.future;
import static akka.dispatch.Futures.sequence;

public class SimpleFutures
{
    public static void main(String[] args)
    {
        List<Future<Long>> futures = new ArrayList<Future<Long>>();

        System.out.println("Adding futures for two random length pauses");

        futures.add(future(new RandomPause()));
        futures.add(future(new RandomPause()));

        System.out.println("There are " + futures.size() + " RandomPause's currently running");

        // compose a sequence of the futures
        Future<Iterable<Long>> futuresSequence = sequence(futures);

        // block until the futures come back
        Iterable<Long> results = futuresSequence.get();

        System.out.println("All RandomPause's are complete");

        Long totalPause = 0L;
        for (Long result : results)
        {
            System.out.println("One pause was for " + result + " milliseconds");
            totalPause += result;
        }

        System.out.println("Total pause was for " + totalPause + " milliseconds");
    }
}
```

Lets walk through the pieces of this.

First, a place to store the list of Futures is created:

```java
List<Future<Long>> futures = new ArrayList<Future<Long>>();
```

The `Future` object is parameterized with the type of result the `Future` will return - a `Long` in this case. (I'm using the Akka `Future` not the regular Java `Future`.)

The `Futures.future` static method is used to create a new `Future` from an instance of a `Callable` object and that `Future` is added to the list of `Futures`:

```java
futures.add(future(new RandomPause()));
```

In this case a `RandomPause` instance is created.  This is done twice to add two futures to the list.

You may have noticed in `RandomPause` that `Callable` is parameratized with a `Long`:

```java
public class RandomPause implements Callable<Long>
```

The result of the work (the `call` method) returns a `Long` so the `Callable` and the `Future` must be parameratized with a Long.

In order to compose the futures together, another `Future` will be created containing the sequence of the list of futures:

```java
Future<Iterable<Long>> futuresSequence = sequence(futures);
```

The `Future` is parameratized with an `Iterable` which is parameratized with a `Long` to match the result of the `Callable`.  The `Futures.sequence` method is used to create the new `Future` from the list of `Futures`.

Using the `futuresSequence` the applicaiton can wait (or block) until the `RandomPause` objects in `futures` list have all returned, or the timeout was reached:

```java
Iterable<Long> results = futuresSequence.get();
```

Each result is now available.  That seems too easy!  Thanks Akka!

Let me know if you have any questions about this example.
