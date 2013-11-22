#!/bin/bash -
#===============================================================================
#
#          FILE:  gcj_full.sh
#
#         USAGE:  ./gcj_full.sh small 0
#
#   DESCRIPTION:  download the problem, run the code and upload solution
#                 checks for correct dir to launch
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Louis Plissonneau (LP), louis.plissonneau@a3.epfl.ch
#       COMPANY: Orange Labs
#       CREATED: 21/05/2011 16:50:20 CEST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

die() {
    err=$1
    shift
    printf "%s\n" "$*"
    exit $err
}

if [[ $# -lt 2 ]]; then
    die 1 "not enough arguments: provide set_size and attempt_nb"
fi

set_size=$1
attempt_nb=$2
problem=`basename $PWD`

input_file="${problem}-${set_size}-${attempt_nb}.in"

gcj_download_input.py $problem $set_size $attempt_nb && time ./template.py -t $input_file && gcj_submit_solution.py $problem $set_size $attempt_nb
