---
date: '2010-05-07 07:57:37'
layout: post
slug: flex-and-java-differences-getters-setters
status: publish
title: 'Flex and Java Differences: Getters & Setters'
wordpress_id: '1715'
categories:
- ActionScript
- Flex
- Java
---

In Java it has become a standard practice to use a getter & setter notation to provide a consistent interface to an object's properties.  There is a reason why we don't do the following in Java:

    
    
    public String fullName;
    


The code above essentially creates an interface (or contract) between the class and the implementors of this class that does not allow us to change the underlying implementation of what gets returned when the fullName property is accessed on an instance of the class.  So if someone has Java code that accesses the fullName property:

    
    
    blah = obj.fullName;
    


Or sets the fullName property:

    
    
    obj.fullName = "blah";
    


Then in Java there is no way to change the behavior of getting or setting the fullName property.  If the author of the class wanted to change the underlying behavior of the getting or setting they would have to change how the implementors of the class interact with the class.  That is obviously not ideal so in Java we typically hide properties with get and set functions.  The Java language doesn't yet have Java properties so we use methods to hide the implementation.  So our Java class instead would be:

    
    
    private String fullName;
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    


This allows the class author to change the behavior of getting and setting the fullName property without changing the external interface.

In Flex it is not usually necessary to create the wrapper getter and setting functions on an object because ActionScript supports properties.  This means that you can usually just create public properties like:

    
    
    public var fullName:String;
    



If the internal implementation of getting or setting the fullName property needs to change, then the class can be adapted to have getter and setter functions without changing the external interface of the class:

    
    
    private var _fullName:String;
    
    public function get fullName():String {
        return _fullName;
    }
    
    public function set fullName(_fullName:String):void {
        this._fullName = _fullName;
    }
    



To the class implementor the property fullName could still be get and set through the normal notations:

    
    
    // getters
    blah = obj.fullName;
    blah = obj['fullName'];
    // setters
    obj.fullName = "blah";
    obj['fullName'] = "blah";
    



Getting or setting the property would call the getter and setter functions instead of accessing the property directly.  This allows the interface of the object to stay the same even if the underlying implementation of getting and setting the property changes.  This also allows a class to dispatch events when properties change (this is how Data Binding works internally in Flex).

I see a lot of Java developers who are wary of public properties on ActionScript classes.  Don't be!  ActionScript supports real properties so you shouldn't ever need property getters and setters unless you are doing something out of the ordinary.  And you can switch to getters and setters without changing the interface to the object.

If you would like to learn more about the differences between ActionScript and Java check out my [AS34J: ActionScript 3 for Java Developers eSeminar](http://www.adobe.com/cfusion/event/index.cfm?event=detail&id=1489921&loc=en_us&sdid=EUQZQ) next week!

UPDATE: Watch the [ recording of my eSeminar presentation](http://www.jamesward.com/2010/05/17/watch-as34j-actionscript-3-for-java-developers/).
