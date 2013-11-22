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


# from get_google_auth.sh
#google_auth="DQAAAMsAAADF3GChsuhLVEp-ieO8JESXg3LiwsboMSz6H-FoVu3J8OQhLy1EAwqlyxG3VS4KrOzwVzYPGDc0VICeQCPSMWd_IZ7CNAJ6IGnP2bYqDLvAjFXCtIoDqsH3-5JoIvMmsl5aa34sI1HEJanuAQxWLEL6ZXNt4FmD6xCbDWDYXPemQw4Z5fWSTWl8HKH1J2jRTxzq5mVF8kikWgLN-_Nah_oV49jjRabId6ES4irlA6DgGJFDmuT68wgWH45SX7eSISJiD1sgyNrIfF1e_pLjArdn"
gmail_login="louis.plissonneau"
gmail_password="Ilona+Alois"
mails="$(wget --secure-protocol=TLSv1 --timeout=3 -t 1 -q -O - \
https://${gmail_login}:${gmail_password}@mail.google.com/mail/feed/atom \
--no-check-certificate | grep 'fullcount' \
| sed -e 's/.*<fullcount>//;s/<\/fullcount>.*//' 2>/dev/null)"

echo number of unread mails: $mails

#curl --header "Authorization: GoogleLogin auth=DQAAAMsAAADF3GChsuhLVEp-ieO8JESXg3LiwsboMSz6H-FoVu3J8OQhLy1EAwqlyxG3VS4KrOzwVzYPGDc0VICeQCPSMWd_IZ7CNAJ6IGnP2bYqDLvAjFXCtIoDqsH3-5JoIvMmsl5aa34sI1HEJanuAQxWLEL6ZXNt4FmD6xCbDWDYXPemQw4Z5fWSTWl8HKH1J2jRTxzq5mVF8kikWgLN-_Nah_oV49jjRabId6ES4irlA6DgGJFDmuT68wgWH45SX7eSISJiD1sgyNrIfF1e_pLjArdn" "https://mail.google.com/mail/feed/atom"
#| perl -ne 'print "\t" if /<name>/; print "$2\n" if /<(title|name)>(.*)<\/\1>/;'

