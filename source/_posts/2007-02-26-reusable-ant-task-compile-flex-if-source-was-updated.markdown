---
author: admin
date: '2007-02-26 11:37:43'
layout: post
slug: reusable-ant-task-compile-flex-if-source-was-updated
status: publish
title: 'Reusable Ant Task: Compile Flex If Source Was Updated'
wordpress_id: '100'
categories:
- Flex
- Java
---

I'm working on a project that compiles 11 Flex applications. My Ant build file
was getting pretty messy and I was continually commenting out files that I
didn't want to build. By using an Ant macro and some uptodate trickery I was
able to significantly decrease my build times when I am only updating files
for a single application. The macro also helped to make the build much more
manageable.

  
You can find the whole build here: [http://flexapps.cvs.sourceforge.net/flexap
ps/census/build.xml?revision=1.14&view;=markup](http://flexapps.cvs.sourceforg
e.net/flexapps/census/build.xml?revision=1.14&view=markup)

First I setup a macro:

    
      <macrodef name="compileflex">
        <attribute name="src"/>
        <attribute name="dest"/>
        <element name="uptodatefiles" optional="true"/>
        <sequential>
          <uptodate property="@{src}.uptodate" targetfile="@{dest}">
            <srcfiles file="@{src}"/>
            <srcfiles file="build/base.swc"/>
            <srcfiles file="${src.flex.dir}/flex.css"/>
            <uptodatefiles/>
          </uptodate>
          <antcall target="compilemxml">
            <param name="src" value="@{src}"/>
            <param name="dest" value="@{dest}"/>
          </antcall>
        </sequential>
      </macrodef>

  
The macro calls the "compilemxml" target when the swf is not up-to-date. The
compilemxml target is a pretty plain Ant target:

    
      <target name="compilemxml" unless="${src}.uptodate">
        <java jar="${flex.sdk.dir}/lib/mxmlc.jar" fork="true" maxmemory="128m">
          <jvmarg value="-Dapplication.home=${flex.sdk.dir}"/>
          <arg value="-external-library-path+=build/base.swc"/>
          <arg value="-runtime-shared-libraries=base.swf"/>
          <arg value="-licenses.license" />
          <arg value="charting"/>
          <arg value="${charting}"/>
          <arg value="-compiler.services" />
          <arg value="etc/flex/services-config.xml" />
          <arg value="-compiler.context-root" />
          <arg value="/census" />
          <arg value="-file-specs" />
          <arg value="${src}" />
          <arg value="-output" />
          <arg value="${dest}" />
        </java>
      </target>

  
The macro is simple to use:

    
      <compileflex src="${src.flex.dir}/flex_soap_as.mxml" dest="build/census.war/flex_soap_as.swf"/>

  
In that instance, the uptodate check will check the src file, the swc, and the
css to see if they are uptodate. If any of them were updated more recently
than the swf, then compilemxml will be called. If you have other unique files
which need to also be checked, you can pass those in a uptodatefiles element:

    
      <compileflex src="${src.flex.dir}/index.mxml" dest="build/census.war/index.swf">
          <uptodatefiles>
            <srcfiles file="${src.flex.dir}/Test.as"/>
            <srcfiles dir="${src.flex.dir}" includes="Wizard*"/>
            <srcfiles file="${src.flex.dir}/IFrame.mxml"/>
            <srcfiles file="${src.flex.dir}/BarItemRenderer.as"/>
            <srcfiles file="${src.flex.dir}/ChartBackgroundFill.as"/>
            <srcfiles file="${src.flex.dir}/ChartLegendCombo.mxml"/>
            <srcfiles file="${src.flex.dir}/CustomAxisRenderer.mxml"/>
            <srcfiles file="${src.flex.dir}/DataGridHeaderSeparator.as"/>
          </uptodatefiles>
        </compileflex>

  
The one kinda-hack I had to do to make this work, was to make sure that the
property which gets set by the uptodate task is unique for each time
compileflex is called. I used the ${src}.uptodate property name to accomplish
this.

This build is pretty catered to my needs, however, you should be able to
easily customize it to fit your needs. I hope you find this useful. Let me
know if you have any questions!

