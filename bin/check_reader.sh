#!/bin/bash - 
#===============================================================================
#
#          FILE:  check_read.sh
#
#         USAGE:  ./check_read.sh 
#
#   DESCRIPTION:  Give the number of unread feed in Google reader
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (LP), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 17/02/2012 09:57:20 CET
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

die() {
    err=$1
    shift
    printf "%s\n" "$*"
    exit $err
}

# from get_google_auth.sh
google_auth="DQAAAMsAAADF3GChsuhLVEp-ieO8JESXg3LiwsboMSz6H-FoVu3J8OQhLy1EAwqlyxG3VS4KrOzwVzYPGDc0VICeQCPSMWd_IZ7CNAJ6IGnP2bYqDLvAjFXCtIoDqsH3-5JoIvMmsl5aa34sI1HEJanuAQxWLEL6ZXNt4FmD6xCbDWDYXPemQw4Z5fWSTWl8HKH1J2jRTxzq5mVF8kikWgLN-_Nah_oV49jjRabId6ES4irlA6DgGJFDmuT68wgWH45SX7eSISJiD1sgyNrIfF1e_pLjArdn"
#feeds=`curl -s -H "Authorization: GoogleLogin auth=$(curl -sd "Email=$gmail_login&Passwd=$gmail_password&service=reader" https://www.google.com/accounts/ClientLogin | grep Auth | sed 's/Auth=\(.*\)/\1/')" "http://www.google.com/reader/api/0/unread-count?output=json" | tr '{' '\n' | sed 's/.*"count":\([0-9]*\),".*/\1/' | grep -E ^[0-9]+$ | tr '\n' '+' | sed 's/\(.*\)+/\1\n/' | bc`
curl -s -H "Authorization: GoogleLogin auth=$google_auth" "http://www.google.com/reader/api/0/unread-count?output=json" | tr -d '\n' | tr '{' '\n' | grep 'id.:.feed/' | sed 's/.*"count":\([0-9]*\),".*/\1/' | grep "^[0-9]*$" | grep -v "^$" | tr '\n' '+' | sed 's/\(.*\)+/\1\n/' | bc

# or try:
# curl -s -H "Authorization: GoogleLogin auth=$(curl -sd "Email=$email&Passwd=$password&service=reader" https://www.google.com/accounts/ClientLogin | grep Auth | sed 's/Auth=\(.*\)/\1/')" "http://www.google.com/reader/api/0/unread-count?output=json" | tr '{' '\n' | sed 's/.*"count":\([0-9]*\),".*/\1/' | grep -E ^[0-9]+$ | tr '\n' '+' | sed 's/\(.*\)+/\1\n/' | bc'"}'

