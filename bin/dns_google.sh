#!/bin/sh
# launch as `sudo dns_google.sh`
cat $MY_CONFIG_DIR/resolv.google > /etc/resolv.conf
