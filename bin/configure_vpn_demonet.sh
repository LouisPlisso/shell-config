#!/bin/bash -
#===============================================================================
#
#          FILE:  configure_vpn_demonet.sh
#
#         USAGE:  ./configure_vpn_demonet.sh
#
#   DESCRIPTION:  configure the network on the VPN
#               launch as sudo configure_vpn_demonet.sh
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (LP), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 03/05/2013 15:09:09 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

die() {
    err=$1
    shift
    printf "%s\n" "$*"
    exit $err
}

#ifconfig eth0 192.168.57.131/24
dhclient eth0
route add default gw 192.168.57.1
cat $MY_CONFIG_DIR/resolv.google > /etc/resolv.conf

ping -c 3 www.google.com

echo "to connect on probes: see /home/louis/pytomo/ibnf/machines.txt"
