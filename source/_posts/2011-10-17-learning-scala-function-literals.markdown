---
date: '2011-10-17 08:16:13'
layout: post
slug: learning-scala-function-literals
status: publish
title: 'Learning Scala: Function Literals'
wordpress_id: '2694'
categories:
- Scala
---

I've gradually been learning Scala over the past few months and I really have been enjoying it.  For me Scala is like Shakespeare.  It seems familiar and totally foreign at the same time.  I don't enjoy Shakespeare plays nearly as much as someone who has taken the time to learn the language of Shakespeare.  Some have interpreted Scala being "familiar yet totally foreign" as Scala being "hard" but I'd say it's just different.  With Scala there is probably more about programming that I need to unlearn than to learn.  My perspectives on programming languages have been shaped by the ones I've used most (Java, ActionScript, etc).  And now my perspecives are being reshaped.  It might take some time and work but I believe that using Scala will soon be very enjoyable for me.

Ok, enough fluff lets see some code!

My friend [Mike Slinn](http://www.mslinn.com/blog/) and I have been learning [BlueEyes](https://github.com/jdegoes/blueeyes) - a lightweight Scala web 3.0 framework.  We encountered a piece of Scala that seemed strange and unfamiliar to us:

```scala
    get { request =>
      // do something
    }
```

To a Java developer like me this was pretty foreign.  I was able to understand this after I encountered _Function Literals_ in the free [Scala for the Impatient](http://typesafe.com/resources/scala-for-the-impatient) book.  So let me break down what is happening here with another example.  Lets start with writing a regular function that takes a `Char` parameter and returns a `Boolean` if the provided `Char` was the letter "l":

```scala
    def lls(p: Char): Boolean = { p == 'l' }
```

This is a pretty straight forward (albeit slightly verbose) function definition.  Oh, and I should mention that if you [download Scala](http://www.scala-lang.org/downloads) and run the REPL (a command line interpreter), then you can actually try this code yourself.  To start the Scala REPL just run the "scala" command.

Ok, lets test out that function:

```scala
    lls('p') // outputs false
    lls('l') // outputs true
```

That should all be somewhat familiar looking for a Java developer.  But here is where things begin to look more foreign.  The [StringOps](http://www.scala-lang.org/api/current/index.html#scala.collection.immutable.StringOps) class in Scala has a `count` method that takes something very peculiar looking.  From the ScalaDoc:

```scala
    def count (p: (Char) ⇒ Boolean): Int
```

That is saying that `count` takes a function as an argument.  Scala is this wonderful blend of Object Oriented and Functional so this is instantly strange to the Java developer in me.  In this case the function that `count` is taking must have a single parameter of type `Char` and then return a `Boolean`.  So lets try to pass the `lls` function to `count` on a `StringOps` instance.  Somehow with Scala's Type Inference system we can just use a regular double-quoted `String` and Scala will figure out that we need a `StringOps` instead.  So let's create a `StringOps` object and call count on it passing it the `lls` function:

```scala
    "Hello".count(lls) // outputs 2
```

I could have assigned "Hello" to a variable and done it that way but opted to just make the `count` call without assigning it.  So `count` correctly took the `lls` function and used it to count the number of "l" `Chars` in the `String` (or `SpringOps`).  That all works as expected.

But, there is another (prettier) way to do the same thing:

```scala
    "Hello" count lls // outputs 2
```

We can drop the dot operator and parenthesis and everything still works.  But there is another way...  Instead of referencing a function we can just pass the function definition directly into the count method:

```scala
    "Hello" count { p:Char => p == 'l' } // outputs 2
```

This is a **Function Literal** - or as Dick Wall tells me, a predicate in this case since it returns a `Boolean`.  A Function Literal is a short way to define a function that takes only one parameter and returns what is needed by whatever the function is being passed to.  In this case the function parameter is still a Char with an identifier of "p" and the function body simply compares "p" with the 'l' `Char`.  In Scala the value of the last statement in a function is returned.  So the `Boolean` is returned from the function.  That type is inferred.  And the `Char` type declaration on "p" could have been left off and inferred making it:

```scala
    "Hello" count { p => p == 'l' } // outputs 2
```

Now that code I started with is making a lot more sense!

But it doesn't stop there.  With Scala we can be even more concise:

```scala
    "Hello" count { _ == 'l' } // still outputs 2
```

Now I must admit that I haven't really learned what that `_` thing does.  So I don't totally understand this code yet.  But like learning to understand Shakespeare we have to take it one step at a time.  I will leave that to another day and maybe another blog post.  I hope this was helpful for other Scala noobs.  Let me know what you think and if you have any questions.
