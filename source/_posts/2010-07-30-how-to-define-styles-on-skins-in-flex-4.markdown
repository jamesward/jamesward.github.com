---
author: admin
date: '2010-07-30 07:49:38'
layout: post
slug: how-to-define-styles-on-skins-in-flex-4
status: publish
title: How to Define Styles on Skins in Flex 4
wordpress_id: '1932'
categories:
- Flex
---

The new component / skin separation in Flex 4 (the Spark Architecture) is
pretty nifty. But if you want to add a configurable style to a skin then that
style must be defined on the component. For instance if you want to add a
backgroundColor style to a Button skin then you need to first create a new
Button component with the style on it:

    
    
    package
    {
    import spark.components.Button;  
    [Style(name="backgroundColor", type="uint", format="Color")]
    public class SButton extends Button
    {  
    }
    }
    

  
Then create a new Button skin that uses the style:

    
    
    
      
      
        import mx.utils.ColorUtil;
        
      
        
        
        
        
      
        
          
        
        
        
    
    

  
Then you can use the new Button and skin:

    
    
      
      
    

  
The reason that we had to create a new base class just to hold the style is
because there would be no other way to set the style in MXML. We could have
set the style via CSS or setStyle. Button does not have a style named
"backgroundColor" so if we hadn't created SButton and tried to just set a
backgroundColor property on a Button instance via MXML, the compiler would
have thrown an error.

So I (with the help of [Ryan Frishberg](http://frishy.blogspot.com/) and [Mike
Labriola](http://blogs.digitalprimates.net/codeslinger/)) came up with a nifty
little way to set styles on skins without having to create new base classes to
hold the styles. The idea is that styles should be defined on the skins and
you can use a property on the base components to set those styles via MXML. To
make it happen I had to Monkey Patch a property named "style" onto
UIComponent. In the setter for that style I just parse a string of HTML-ish
styles and call setStyle. The cool thing is that I'm calling setStyle on the
component but since skins inherit the styles of their host component the skin
gets the styles. This also means that the styles don't really need to be
defined on the skins. Just used in the skins. Using the example above to set
the backgroundColor on the Button I could just do:

    
    
      
    

  
I didn't need a new Button class just to set the backgroundColor style. Here
is a more complex example with more styles on the skin:

All of those buttons are using the same skin and the base Spark Button! The
code for this example is [on
github](http://github.com/jamesward/Styles4Skins). So check it out, fork it,
and have fun. Let me know if you have any questions.

