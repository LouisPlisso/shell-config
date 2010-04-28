#!/bin/sh

echo Brightness `grep current /proc/acpi/video/VID/LCD/brightness`
if [ "$1" ]
then
    levels=`grep levels /proc/acpi/video/VID/LCD/brightness|cut -d\: -f 2`
    for level in $levels
    do
        if [ $1 = $level ]
        then
            echo setting brightness to level $1
            echo $1 > /proc/acpi/video/VID/LCD/brightness
            exit 0
        fi
    done
    echo "Incorrect level\nChoose from: $levels"
    exit 1
else
    echo setting brightness to level 40
    echo 40 > /proc/acpi/video/VID/LCD/brightness
fi

