#!/bin/sh - 
#===============================================================================
#
#          FILE:  fix-resolution.sh
# 
#         USAGE:  ./fix-resolution.sh 
# 
#   DESCRIPTION:  change resolution for external screen and also relaunch the trayer (which is unaligned)
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (lp), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 24/06/2010 08:49:36 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

EXTERNAL_OUTPUT=VGA1
INTERNAL_OUTPUT=LVDS1

# same as ext-screen alias
xrandr --auto --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT

# relaunch trayer
pgrep trayer | xargs kill
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
        --expand true --width 10 --transparent true --height 8 --tint 0x191970 & #

# relaunch keynav
pgrep keynav | xargs kill
keynav &

