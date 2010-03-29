#!/bin/sh

path="/sys/class/power_supply/BAT0"

full=`cat $path/charge_full`
now=`cat $path/charge_now`

status=$(( 100 * $now / $full ))

if [ $status -lt 10 ]
then
    zenity --warning --title "Battery" --text "Low battery. (status = $status)"
fi
