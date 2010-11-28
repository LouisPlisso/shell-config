#!/bin/sh - 
#===============================================================================
#
#          FILE:  auto_aptitude.sh
# 
#         USAGE:  ./auto_aptitude.sh 
# 
#   DESCRIPTION:  automatically update and install new packages
#                 set it up to make automatic weekly updates with anacron as
#                 sudo ln -s $PWD/auto_aptitude.sh /etc/cron.weekly/
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (lp), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 02/11/2010 21:04:58 CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

/usr/bin/aptitude update
/usr/bin/aptitude safe-upgrade -y
/usr/bin/aptitude autoclean

