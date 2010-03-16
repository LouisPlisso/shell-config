#!/bin/sh
# launch as `sudo networt_ftrd.sh`
rm /etc/resolv.conf
ln -s $MY_CONFIG_DIR/resolv.google /etc/resolv.conf
