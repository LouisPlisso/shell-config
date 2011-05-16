#!/bin/sh - 
#===============================================================================
#
#          FILE:  to_gray.sh
# 
#         USAGE:  ./to_gray.sh 
# 
#   DESCRIPTION:  converts pdf to grayscale
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (lp), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 17/04/2011 23:37:01 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

infile=$1
outfile=`basename $1 .pdf`_gray.pdf
gs -sOutputFile=$outfile -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH $infile 
