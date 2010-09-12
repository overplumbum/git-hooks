#!/bin/sh
#
# Do not allow direct commits into the branch specified
# Arguments: simple branch name without any refs/ or heads/
#

branch=`git symbolic-ref HEAD`
if [ $branch == "refs/heads/$1" ]; then
    echo !!! Direct commits to the branch "$1" are not allowed
    exit 1
fi
