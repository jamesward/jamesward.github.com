---
date: '2011-09-13 08:00:39'
layout: post
slug: sending-play-framework-file-uploads-to-amazon-s3
status: publish
title: Sending Play Framework File Uploads to Amazon S3
wordpress_id: '2608'
categories:
- Heroku
- Java
- Play Framework
---

A couple of questions [[1](http://stackoverflow.com/questions/7314106/handling-file-uploads-in-play-framework-on-heroku/7334400), [2](http://stackoverflow.com/questions/7258965/store-blob-in-heroku-or-similar-cloud-services)] on StackOverflow.com led me to look into how we can send file uploads in a Play Framework application to [Amazon S3](http://aws.amazon.com/s3/) instead of the local disk.  For applications running on Heroku this is especially important because the local disk is not persistent.  Persistent disk storage makes it hard to scale apps.  Instead of using the file system, it's better to use an external service which is independent of the web tier.

While at JavaZone I sat down with [Peter Hilton](https://twitter.com/peterhilton) and [Nicolas Leroux](https://twitter.com/nicolasleroux) to come up with a way to handle this.  It only took us 30 minutes to get something working - start to finish - including setup time.  This is what is so compelling about Play Framework.  I've built many Java web apps and it always seems like I spend too much time setting up builds, IDEs, and plumbing.  With Play we were setup and working on the actual app in less than a minute.  After getting everything working locally it took another minute to actually run it on the cloud with Heroku.  The combination of Play Framework and Heroku is a developer's dream for fast-paced development and deployment.

All of the code for the sample application is on github:
[https://github.com/jamesward/plays3upload](https://github.com/jamesward/plays3upload)

The basics of what we did was this:

    
    
    public static void doUpload(String comment, File attachment)
    {
        AWSCredentials awsCredentials = new BasicAWSCredentials(System.getenv("AWS_ACCESS_KEY"), System.getenv("AWS_SECRET_KEY"));
        AmazonS3 s3Client = new AmazonS3Client(awsCredentials);
        s3Client.createBucket(BUCKET_NAME);
        String s3Key = UUID.randomUUID().toString();
        s3Client.putObject(BUCKET_NAME, s3Key, attachment);
        Document doc = new Document(comment, s3Key, attachment.getName());
        doc.save();
        listUploads();
    }
    



This uses a JPA Entity to persist the metadata about the file upload (for some reason we named it 'Document') and a reference to the file's key in S3.  But there was a sexier way, so my co-worker [Tim Kral](https://github.com/tkral) added a new [S3Blob](https://github.com/jamesward/plays3upload/blob/master/app/s3/storage/S3Blob.java) type that could be used directly in the JPA Entity.  Tim also cleaned up the configuration to make it more Play Framework friendly.  So lets walk through the entire app so you can see the pieces.

The [app/models/Document.java](https://github.com/jamesward/plays3upload/blob/master/app/models/Document.java) JPA Entity has three fields - the file being of type S3Blob:

    
    
    package models;
    
    import javax.persistence.Entity;
    
    import play.db.jpa.Model;
    import s3.storage.S3Blob;
    
    @Entity
    public class Document extends Model
    {
        public String fileName;
        public S3Blob file;
        public String comment;
    }
    



The S3Blob is now doing all of the work to talk to the Amazon S3 APIs to persist and fetch the actual file.

Configuration of S3 is done by adding a plugin to the [conf/play.plugins](https://github.com/jamesward/plays3upload/blob/master/conf/play.plugins) file:

    
    
    0: s3.storage.S3Plugin
    



The [S3Plugin](https://github.com/jamesward/plays3upload/blob/master/app/s3/storage/S3Blob.java) handles reading the AWS credentials from the [conf/application.conf](https://github.com/jamesward/plays3upload/blob/master/conf/application.conf) file, setting up the S3Client, and creating the S3 Bucket - if necessary.

In the [conf/application.conf](https://github.com/jamesward/plays3upload/blob/master/conf/application.conf) file, environment variables are mapped to the configuration parameters in the Play application:

    
    
    aws.access.key=${AWS_ACCESS_KEY}
    aws.secret.key=${AWS_SECRET_KEY}
    s3.bucket=${S3_BUCKET}
    



The values could be entered into the conf file directly but I used environment variables so they would be easier to change when running on Heroku.

The Amazon AWS API must be added to the [conf/dependencies.yml](https://github.com/jamesward/plays3upload/blob/master/conf/dependencies.yml) file:

    
    
    require:
        - play
        - com.amazonaws -> aws-java-sdk 1.2.7
    



The sample application has a new controller in [app/controllers/Files.java](https://github.com/jamesward/plays3upload/blob/master/app/controllers/Files.java) that can display the upload form, handle the file upload, display the list of uploads, and handle the file download:

    
    
    package controllers;
    
    import java.io.File;
    import java.io.FileInputStream;
    import java.io.FileNotFoundException;
    import java.util.List;
    
    import models.Document;
    import play.libs.MimeTypes;
    import play.mvc.Controller;
    import s3.storage.S3Blob;
    
    public class Files extends Controller
    {
    
      public static void uploadForm()
      {
        render();
      }
    
      public static void doUpload(File file, String comment) throws FileNotFoundException
      {
        final Document doc = new Document();
        doc.fileName = file.getName();
        doc.comment = comment;
        doc.file = new S3Blob();
        doc.file.set(new FileInputStream(file), MimeTypes.getContentType(file.getName()));
        
        doc.save();
        listUploads();
      }
    
      public static void listUploads()
      {
        List<document> docs = Document.findAll();
        render(docs);
      }
    
      public static void downloadFile(long id)
      {
        final Document doc = Document.findById(id);
        notFoundIfNull(doc);
        response.setContentTypeIfNotSet(doc.file.type());
        renderBinary(doc.file.get(), doc.fileName);
      }
    
    }
    



The **uploadForm()** method just causes the [app/views/Files/uploadForm.html](https://github.com/jamesward/plays3upload/blob/master/app/views/Files/uploadForm.html) page to be displayed.

The **doUpload()** method handles the file upload and creates a new **Document** object that stores the file in S3 and the comment in a database.  After storing the file and comment it runs the **listUploads()** method. Of-course a database must be configured in the [conf/application.conf](https://github.com/jamesward/plays3upload/blob/master/conf/application.conf) file.  For running on Heroku the database is provided and just needs to be configured with the following values:

    
    
    db=${DATABASE_URL}
    jpa.dialect=org.hibernate.dialect.PostgreSQLDialect
    jpa.ddl=update
    



The **listUploads()** method fetches all **Document** objects out of the database and then displays the [apps/views/files/listUploads.html](https://github.com/jamesward/plays3upload/blob/master/app/views/Files/listUploads.html) page.

If a user selects a file from the list then the **downloadFile()** method is called which finds the file in S3 and sends it back to the client as a binary stream.  An alternative to this would be to get the file directly from Amazon using either the [S3 generatePresignedUrl()](file:///home/jamesw/aws-java-sdk-1.2.6/documentation/javadoc/com/amazonaws/services/s3/AmazonS3Client.html#generatePresignedUrl(java.lang.String, java.lang.String, java.util.Date)) method or via [CloudFront](http://aws.amazon.com/cloudfront/).

Finally in the [conf/routes](https://github.com/jamesward/plays3upload/blob/master/conf/routes) file, requests to "/" have been mapped to the **Files.uploadForm()** method:

    
    
    GET     /                                       Files.uploadForm
    



That's it!  Now we have an easy way to persist file uploads in an external system!



## Running the Play! app on Heroku



If you'd like to run this example on Heroku, here is what you need to do:

Install the heroku command line client on [Linux](http://toolbelt.herokuapp.com/linux/readme), [Mac](http://toolbelt.herokuapp.com/osx/download), or [Windows](http://toolbelt.herokuapp.com/windows/download).


Login to Heroku via the command line:

    
    
    heroku auth:login
    



Clone the git repo:

    
    
    git clone git@github.com:jamesward/plays3upload.git
    



Move to the project dir:

    
    
    cd plays3upload
    



Create the app on Heroku:

    
    
    heroku create -s cedar
    



Set the AWS environment vars on Heroku:

    
    
    heroku config:add AWS_ACCESS_KEY="YOUR_AWS_ACCESS_KEY" AWS_SECRET_KEY="YOUR_AWS_SECRET_KEY" S3_BUCKET="AN_AWS_UNIQUE_BUCKET_ID"
    



Upload the app to Heroku:

    
    
    git push heroku master
    



Open the app in the browser:

    
    
    heroku open
    



Let me know if you have any questions or problems.  And thanks to Peter, Nicolas, and Tim for helping with this!
