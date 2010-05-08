#!/bin/sh
# launch as `sudo dns_google.sh`
rm /etc/resolv.conf
ln -s $MY_CONFIG_DIR/resolv.google /etc/resolv.conf
