---
date: '2009-07-17 09:38:53'
layout: post
slug: flex-4-example-halo-component-with-spark-skin
status: publish
title: Flex 4 Example - Halo Component with Spark Skin
wordpress_id: '1057'
categories:
- Flex
---

Lately I've been playing with the [Flex 4 Beta](http://labs.adobe.com/technologies/flashbuilder4/) to better understand the new Spark component set.  Halo is the name being used to describe the Flex 2 and Flex 3 component set.  In Flex 4 you can choose to either use only Halo or use both Spark and Halo together.  Since Spark has some great features like improved skinning and FXG (declarative vector drawing) support it is a great option for creating pixel perfect UIs.  But sometimes you might need to stick with the Halo components.  Luckily it seems that you can use the Spark skinning classes on Halo components.  Here's an example of this technique based on an [earlier demo](/blog/2009/03/09/flex-gumbo-sample-pretty-button-with-fxg/) I built which used only Spark:




Here is the application code:

    
    <mx:application backgroundgradientcolors="[0x0e0e0e,0x0e0e0e]" viewsourceurl="srcview/index.html" backgroundcolor="#0e0e0e" xmlns:mx="http://www.adobe.com/2006/mxml">
        
        <mx:button textselectedcolor="#dddddd" textrollovercolor="#dddddd" color="#bbbbbb" label="hello, world" width="200" skin="PrettyButtonSkin" height="50"></mx:button>
        
    </mx:application>



And here is the skin code:

    
    <sparkskin xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns="library://ns.adobe.com/flex/spark">
      
        <fx:declarations>
          <animatecolor duration="1000" id="colorEffect" targets="{innerBorderColorTop, innerBorderColorTop, fillColorTop, fillColorBottom, labelElement]}"></animatecolor>
        </fx:declarations>
        
      <states>
        <state name="up"></state>
        <state name="over"></state>
        <state name="down"></state>
      </states>
      
      <transitions>
        <transition tostate="over" effect="{colorEffect}" fromstate="up"></transition>
        <transition tostate="up" effect="{colorEffect}" fromstate="over"></transition>
        <transition tostate="up" effect="{colorEffect}" fromstate="down"></transition>
        <transition tostate="over" effect="{colorEffect}" fromstate="down"></transition>
      </transitions>
        
      <rect radiusy="2" radiusx="2" height="100%" id="r1" width="100%">
        <fill>
          <lineargradient rotation="90">
                  <entries>
              <gradiententry color="0x141414" alpha="1" ratio="0" id="innerBorderColorTop" color.down="0x0b0b0b"></gradiententry>
                    <gradiententry color="0x0b0b0b" alpha="1" ratio="1" id="innerBorderColorBottom" color.down="0x0b0b0b"></gradiententry>
                    </entries>
          </lineargradient>
        </fill>
        <stroke>
            <solidcolorstroke color="0x252525" alpha="1" pixelhinting="true"></solidcolorstroke>
        </stroke>
        </rect>
        
      <rect radiusy="2" radiusx="2" height="{r1.height - 3}" width="{r1.width - 3}" y="2" x="2">
        <fill>
          <lineargradient rotation="90">
            <gradiententry ratio="0" color.down="0x0b0b0b" color="0x393939" color.over="0x161616" alpha="1" id="fillColorTop"></gradiententry>
            <gradiententry ratio="1" color.down="0x0b0b0b" color="0x131313" color.over="0x161616" alpha="1" id="fillColorBottom"></gradiententry>
          </lineargradient>
        </fill>      
        </rect>
        
        <simpletext horizontalcenter="0" color.down="#dddddd" color="#bbbbbb" color.over="#dddddd" verticalcenter="0" id="labelElement"></simpletext>
    
    </sparkskin>



You could even use the Spark ButtonSkin on the Halo Button component:

    
    <mx:button textselectedcolor="#dddddd" textrollovercolor="#dddddd" color="#bbbbbb" label="hello, world" width="200" skin="spark.skins.default.ButtonSkin" height="50"></mx:button>



This approach allows for a more incremental adoption of the new features in Flex 4.  I've only tried Button so I'm not sure if this same approach works for other more complex components.  But it seems that in many cases this will help us use FXG for the skins on Halo components.  Let me know what you think.
