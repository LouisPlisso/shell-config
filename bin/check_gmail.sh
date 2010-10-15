#!/bin/sh - 
#===============================================================================
#
#          FILE:  check_gmail.sh
# 
#         USAGE:  ./check_gmail.sh 
# 
#   DESCRIPTION:  Gives the number of unread messages in gmail
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (lp), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 08/09/2010 12:28:08 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


gmail_login="louis.plissonneau"
gmail_password="Ilona0702"
mails="$(wget --secure-protocol=TLSv1 --timeout=3 -t 1 -q -O - \
https://${gmail_login}:${gmail_password}@mail.google.com/mail/feed/atom \
--no-check-certificate | grep 'fullcount' \
| sed -e 's/.*<fullcount>//;s/<\/fullcount>.*//' 2>/dev/null)"

echo number of unread mails: $mails
