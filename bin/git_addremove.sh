#!/bin/sh - 
#===============================================================================
#
#          FILE:  git_addremove.sh
# 
#         USAGE:  ./git_addremove.sh 
# 
#   DESCRIPTION:  Adds all untracked files in a repository and remove missing ones
#                 From web: http://importantshock.wordpress.com/2008/08/07/git-vs-mercurial/
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (lp), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 22/10/2010 09:50:58 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# git-addremove
git add .
git ls-files -deleted | xargs git rm


