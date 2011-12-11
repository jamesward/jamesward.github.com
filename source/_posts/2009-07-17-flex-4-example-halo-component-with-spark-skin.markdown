---
author: admin
date: '2009-07-17 09:38:53'
layout: post
slug: flex-4-example-halo-component-with-spark-skin
status: publish
title: Flex 4 Example - Halo Component with Spark Skin
wordpress_id: '1057'
categories:
- Flex
---

Lately I've been playing with the [Flex 4
Beta](http://labs.adobe.com/technologies/flashbuilder4/) to better understand
the new Spark component set. Halo is the name being used to describe the Flex
2 and Flex 3 component set. In Flex 4 you can choose to either use only Halo
or use both Spark and Halo together. Since Spark has some great features like
improved skinning and FXG (declarative vector drawing) support it is a great
option for creating pixel perfect UIs. But sometimes you might need to stick
with the Halo components. Luckily it seems that you can use the Spark skinning
classes on Halo components. Here's an example of this technique based on an
[earlier demo](/blog/2009/03/09/flex-gumbo-sample-pretty-button-with-fxg/) I
built which used only Spark:

  
Here is the application code:

    
    
        
        
        
    

  
And here is the skin code:

    
    
      
        
          
        
        
      
        
        
        
      
      
      
        
        
        
        
      
        
      
        
          
                  
              
                    
                    
          
        
        
            
        
        
        
      
        
          
            
            
          
              
        
        
          
    

  
You could even use the Spark ButtonSkin on the Halo Button component:

  
This approach allows for a more incremental adoption of the new features in
Flex 4. I've only tried Button so I'm not sure if this same approach works for
other more complex components. But it seems that in many cases this will help
us use FXG for the skins on Halo components. Let me know what you think.

