#!/bin/bash - 
#===============================================================================
#
#          FILE:  pdfcrop_dir.sh
# 
#         USAGE:  ./pdfcrop_dir.sh 
# 
#   DESCRIPTION:  apply pdfcrop to all pdf files of directory
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau
#       COMPANY: Orange Labs
#       CREATED: 16/05/2010 19:39:23 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

dir=$1

for f in `ls $dir | grep ".pdf"`
do 
    pdfcrop $f tmp; mv tmp $f
done
