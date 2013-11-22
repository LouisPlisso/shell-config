#!/bin/bash - 
#===============================================================================
#
#          FILE:  get_google_auth.sh
#
#         USAGE:  ./get_google_auth.sh 
#
#   DESCRIPTION:  Get Google Authenitcation token
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (LP), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 17/02/2012 10:03:02 CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

die() {
    err=$1
    shift
    printf "%s\n" "$*"
    exit $err
}

gmail_login="louis.plissonneau"
gmail_password="Ilona0702"

curl https://www.google.com/accounts/ClientLogin \
--data-urlencode Email=$gmail_login --data-urlencode Passwd=$gmail_password \
-d accountType=GOOGLE \
-d source=Google-cURL-Example \
-d service=lh2

