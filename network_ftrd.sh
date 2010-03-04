#!/bin/sh
# launch as `sudo networt_ftrd.sh`
ifconfig eth0 10.193.224.150 netmask 255.255.0.0
rm /etc/resolv.conf
ln -s /home/elpy7391/s-alois/resolv.ftrd /etc/resolv.conf
route add default gw 10.193.224.1
