#!/bin/sh

# reference: https://stackoverflow.com/questions/2615378/how-to-use-git-properly-with-xcode
# if merge got some issue, plz read it.


    projectfile=`find -d . -name 'project.pbxproj'`
    projectdir=`echo *.xcodeproj`
    projectfile="${projectdir}/project.pbxproj"
    tempfile="${projectdir}/project.pbxproj.out"
    savefile="${projectdir}/project.pbxproj.mergesave"

    cat $projectfile | grep -v "<<<<<<< HEAD" | grep -v "=======" | grep -v "^>>>>>>> " > $tempfile
    cp $projectfile $savefile
    mv $tempfile $projectfile
