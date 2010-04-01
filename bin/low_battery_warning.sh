#!/bin/sh

path="/sys/class/power_supply/BAT0"

charging=`cat $path/status`
if [ $charging = "Charging" ]
then
    exit 0
fi

full=`cat $path/charge_full`
now=`cat $path/charge_now`
status=$(( 100 * $now / $full ))

if [ $status -lt 10 ]
then
    export DISPLAY=:0
    zenity --warning --title "Battery" --text "\nLow battery: status = $status"
    #Received $1.
fi
