---
date: '2009-09-01 19:00:59'
layout: post
slug: building-rich-cloud-applications-with-force-com-and-flex
status: publish
title: Building Rich Cloud Applications with Force.com and Flex
wordpress_id: '1156'
categories:
- Flex
- Salesforce.com
---

Combining the power of the cloud and the client allows developers to have the best of both worlds - easy deployment and full client capabilities.  Salesforce.com's cloud platform, called Force.com, and the Flash Platform are two proven and reliable choices for building these types of Rich Cloud Applications.  Last week I co-hosted a webinar called "Developing Rich User Interfaces on Force.com Using Adobe Flex" in which Ryan Marples (from Salesforce.com) and I walked through the two platforms and how to use them together to build great software.  If you didn't have the chance to join the webinar then please go watch [the recording](https://admin.acrobat.com/_a13852757/p23759608/) and let us know what you think.

In the webinar we didn't have a chance to walk through all of the details of building Rich Cloud Applications with Force.com and Flex so here is a tutorial and the [source code](/demos/CarIncident.zip) for the highly desired car insurance demo.

**Overview**

With Rich Cloud Applications the back-end and front-end are distinctly different pieces.  The first step when building these types of applications is to identify the domain model that will be used on the back-end for longterm persistence.  Force.com will take care of all the details around scalability, reliability, disaster recovery, constraints, security, etc.  All we need to do is describe the model in Force.com.  In this case the model is for a piece of the insurance demo I frequently do.  Here is a screenshot:

![insuricorp](http://www.jamesward.com/blog/wp-content/uploads/2009/09/insuricorp.jpg)

The information we need to store for this demo is the coordinates of all four cars and the coordinates of the crash indicator.  In the next section we will describe that data model on Force.com.

Since the front-end will be built with Flex you will need either [Flex Builder](http://www.adobe.com/go/flex_trial) (60 day trial available) or the [open source Flex SDK](http://opensource.adobe.com).  This tutorial will assume you are using Flex Builder.  Flex contains many out-of-the-box components but the car dragging UI used in the insurance demo is not one of them.  The section about building the front-end will walk through some of the Flex code used to create that UI.  If you want to learn more about creating custom components in Flex there is great documentation on the [Adobe Developer Connection](http://www.adobe.com/devnet/flex/components.html).  Also if you want to see the components that are available in Flex then check out [Tour de Flex](http://flex.org/tour).

Once the Flex application has been built, this tutorial will walk through the steps to put it up on the Force.com cloud.

**Setting up the Back-end**

To begin setting up the back-end on Force.com you will need a [developer account](http://developer.force.com).  Once logged in you can go into the Setup mode by clicking on the "Setup" link at the top of the page.  Setup mode is where you will configure the back-end data model on Force.com and deploy the Flex application after it's built.  On the left side of the Setup page you will see a section titled App Setup and underneath that a link titled "Create".  Click that link and then click the "Objects" link which will now appear in the list. This is where custom objects on Force.com are created and configured.

Add a new custom object titled "AccidentReport".  Then on that object create a few custom fields:




  * Date_of_Accident  -  The type is Date.  This field will store the date the accident happened.


  * IncidentX  -  The type is Number.  This field will store the X coordinate of the crash indicator.


  * IncidentY  -  The type is Number.  This field will store the Y coordinate of the crash indicator.



Next create another custom object titled "IncidentCar".  On that object create these custom fields:


  * StartX  -  The type is Number.  This field will store the X coordinate of the starting car's position.


  * StartY  -  The type is Number.  This field will store the Y coordinate of the starting car's position.


  * EndX  -  The type is Number.  This field will store the X coordinate of the ending car's position.


  * EndY  -  The type is Number.  This field will store the Y coordinate of the ending car's position.


  * AccidentReport  -  This is a Master-Detail Relationship where the relationship is to the AccidentReport.



The data model has now been configured on Force.com and is ready for use.  You may want to add a few fake records (an AccidentReport with two cars) manually to test the data model.

**Building the Flex Client**

Now that the Force.com back-end is configured we can begin building the Flex client.  The client can run in three ways:




  1. Embedded in a Force.com page


  2. On your own server


  3. As a desktop application using Adobe AIR



In this tutorial we will use option 1.  The details for deploying the application will be covered in the next section.

In order to connect to Force.com we need to download the [Force.com Toolkit for Adobe AIR and Flex](http://developer.force.com/flextoolkit).

Start by creating a new Flex Project in Flex Builder.  Then copy the force-flex.swc file from the Toolkit into the project's libs folder.  In your application start with something simple like:

```mxml
<mx:Application xmlns:mx="http://www.adobe.com/2006/mxml" xmlns:salesforce="http://www.salesforce.com/">

  <mx:Script>
    import com.salesforce.AsyncResponder;
    import com.salesforce.objects.LoginRequest;
    import com.salesforce.results.LoginResult;
    import com.salesforce.results.QueryResult;
  </mx:Script>

  <mx:applicationComplete>
    var lr:LoginRequest = new LoginRequest();
      lr.username = "YOUR USER NAME";
      lr.password = "YOUR PASSWORD";
      lr.callback = new AsyncResponder(
        function(result:LoginResult):void {
          conn.query("Select Id, IncidentX__c, IncidentY__c, Date_of_Accident__c from AccidentReport__c",
            new AsyncResponder(function(result:QueryResult):void {
              dg.dataProvider = result.records;
            }));
      });
      conn.login(lr);
  </mx:applicationComplete>

  <salesforce:Connection id="conn"/>

  <mx:DataGrid id="dg"/>

</mx:Application>
```

Give it a try by running the application.  This simply logs in, fetches the AccidentReports and displays them in a DataGrid.  Make sure that you have some sample data on Force.com before you run this.  Otherwise you will get an error.  That is a simple read-only view of some data on the Force.com cloud!  However the full Car Incident application requires quite a bit more code.  You can [download the code](/demos/CarIncident.zip) and then copy and paste the files into your project.

Let's walk through the application requirements:




  1. Retrieve a list of AccidentReports


  2. Allow the user to select an AccidentReport


  3. Retrieve the IncidentCars for the selected AccidentReport


  4. Allow the user to create a new AccidentReport


  5. Allow the user to position the crash indicator and cars in the AccidentReport


  6. Save the changes to Force.com



When we started building our back-end we modeled the data in Force.com.  Now we need a client-side model of the data.  The two value objects for this purpose are AccidentReport.as and Car.as.  Those two value objects contains public properties corresponding to the values we need to hold once we get data back from Force.com.  They also have a constructor that can map the data format from Force.com to the value object's properties.  For instance the Car value object's constructor does the following:

```actionscript
        public function Car(o:Object=null)
        {
          if (o != null)
          {
            id = o.Id;
            startX = o.StartX__c;
            startY = o.StartY__c;
            endX = o.EndX__c;
            endY = o.EndY__c;
          }
        }
```

This simply sets the properties on an instance of Car to the data values retrieved from Force.com.  Later on you will see where those values come from and how we create new Car value objects.

Now that the client-side data model has been created we need a central place that will hold our value objects.  The easiest way to do this is to create a Singleton called Model.  You can find it in the Model.as class.  The model contains properties which store information about the current state of the Flex application.  In this case the state properties our application needs are:




  * statusMessage:String  -  Holds messages related to server communication


  * loggedIn:Boolean  -  Specifies whether or not the user is logged in


  * accidentReports:ArrayCollection  -  Stores all of the AccidentReports that get fetched from the server


  * selectedAccidentReport:AccidentReport  -  The AccidentReport selected by the user (if any)



Next we will setup a Controller that manages the communication to Force.com and updates the Model.  You can find the source code in the Controller.as class.  This class contains an instance of the Connection object from the Toolkit, which will actually do the communication to Force.com's SOAP API.  It also contains a reference to the Singleton Model.  The controller exposes several public methods that support the requirements listed above.  These are:


  * login(sessionId:String, serverUrl:String):void  -  A method that logs into Force.com based on the sessionId and serverUrl provided by the Force.com page.  Flex applications running outside of Force.com (on your own website or as a desktop application) will not have a sessionId so they will need to set the username and password instead.


  * getAccidentReports():void  -  Does a query for the AccidentReports owned by the authenticated user.


  * createAccidentReport():void  -  Creates a new AccidentReport.


  * getAccidentReport(accidentReport:AccidentReport):void  -  Fetches the IncidentCars for a given AccidentReport.


  * saveAccidentReport(accidentReport:AccidentReport):void  -  Updates an AccidentReport and its associated IncidentCars.



All network requests in Flex happen asynchronously.  This means that all requests to Force.com also happen asynchronously; so while the methods listed above can make the request, other private functions are used to actually handle the server response and then update the Model.  For instance when the response from the query in getAccidentReports returns, the model is updated in the following way:

```actionscript
        private function getAccidentReportsResult(qr:QueryResult):void
        {
          model.accidentReports = new ArrayCollection();
    
          // store AccidentReports
          for each (var o:Object in qr.records)
          {
            model.accidentReports.addItem(new AccidentReport(o));
          }
        }
```

Notice that the records returned from the server are typed as Objects.  In the for loop we use the mapping in AccidentReport's constructor to convert the Object to a typed AccidentReport.

Now that the Model and Controller are setup the next task is to build the UI.  The UI is built with a number of components:




  * CarShape.as  -  A class that draws a single car.


  * DraggableCars.as  -  Has two CarShapes and draws a curved line between them.  Also has a Car value object which is used to position the CarShapes.  When the user drags a CarShape the underlying Car is updated.


  * Accident.mxml  -  Has an AccidentReport value object, two DraggableCars, and a crash indicator.  The cars stored on the AccidentReport are passed to the DraggableCars.  When the crash indicator is moved the AccidentReport value object is updated.


  * AccidentReportView.mxml  -  Contains the Controller, a DataGrid that displays the list of all AccidentReports, an Accident that is displayed when the user selects an item in the DataGrid, and buttons that allow the user to create, save, or close an AccidentReport.


  * CarIncident.mxml  -  The main application that contains an AccidentReportView and does the login when the application loads.



Describing how the custom UI components work is beyond the scope of this article.  However it's important to describe how the Model, View, and Controller interact.  In the AccidentReportView the Accident uses data binding to setup an observer on the model.  When the observer observes a change it lets the view know so that it can refresh its view of the model.  The instance of the Accident uses data binding for two things:

```mxml
<cars:Accident id="accident" accidentReport="{Model.getInstance().selectedAccidentReport}" visible="{Model.getInstance().selectedAccidentReport != null}"/>
```    

First the accidentReport value object of the Accident is set to data bind to the Model's selectedAccidentReport.  When that value changes the data binding observer will notify the Accident about the change.  Second, the Accident is only visible when the Model's selectedAccidentReport is not null.

The AccidentReportView also interacts with the controller by calling its public methods.  Here's an example:

```mxml    
        <mx:Button label="Save">
          <mx:click>
            controller.saveAccidentReport(accident.accidentReport);

            accidentReportDataGrid.selectedItem = null;
            Model.getInstance().selectedAccidentReport = null;
          </mx:click>
        </mx:Button>
```

When the user clicks the save button, the event handler calls the Controller's saveAccidentReport method passing it the currently selected AccidentReport.  Since the components internally have made changes to the AccidentReport those changes are then propagated to Force.com by calling the Connection's update method.  The save button's event handler also deselects the currently selected item in the DataGrid and sets the selectedAccidentReport on the Model to null.

Now that you have a fully functional Rich Cloud Application built with Force.com and Flex the next step is to make that application available on the cloud.


**Deploying the Flex Client**

When in the development phase it may be convenient to hard code your username and password into the application like we did in the simple example above.  However, you should never do that in a production application.  If you are deploying on a Force.com page then you can use the session_id.  Here is an example:

```actionscript
          conn.serverUrl = parameters.server_url;
    
          var lr:LoginRequest = new LoginRequest();
          lr.session_id = parameters.session_id;
          lr.server_url = parameters.server_url;
          lr.callback = new AsyncResponder(loginResult, loginFault);
          conn.login(lr);
```

The parameters are available on the main Application and are passed into the application using the apex:flash VisualForce tag, which we will setup later.

Once your application is set up to use the session_id then you will need to create a release build of the Flex project.  To do that follow the Export -> Flex -> Release Build wizard.  This will create a smaller SWF file (the application) that will later be uploaded to Force.com.

To deploy the application go into the Force.com Setup mode, click on Develop under App Setup, and then click on Static Resources.  Create a new resource called "CarIncident" and upload the application's SWF file found in the bin-release folder under the project.  Then under Develop, click Pages and add a new Page called "AccidentReport".  Put the following code in the page:

```xml    
<apex:page>
    <apex:pageBlock>
        <apex:flash src="{!$Resource.CarIncident}" width="500" height="500" flashvars="session_id={!$Api.Session_ID}&server_url={!$Api.Partner_Server_URL_150}"/>
    </apex:pageBlock>
</apex:page>
```

Save the page and then you should be able to access it by going to:
[https://na1.salesforce.com/apex/AccidentReport](https://na1.salesforce.com/apex/AccidentReport)

If my instructions are accurate then hopefully you will now see the CarIncident application on the cloud pulling data from Force.com like this screenshot:
![carincident](http://www.jamesward.com/blog/wp-content/uploads/2009/09/carincident.jpg)

This is just a basic walk through of how to build Rich Cloud Applications with Force.com and Flex.  There are tons of additional features and configuration changes you can make on both the back-end and front-end.  But hopefully this helps you get started building Rich Cloud Applications with Force.com and Flex.  Let me know how it goes!
