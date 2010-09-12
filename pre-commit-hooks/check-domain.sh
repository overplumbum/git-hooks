#!/bin/sh
#
# Email domain check
# Arguments: domain.com
#
if [ "`git config --get user.email | cut -d '@' -f 2`" != "$1" ]; then
    echo !!! Authors email is not in @"$1" domain: `git config --get user.email`
    echo !!! Please update it using following commands:
    echo '$' git config --global user.name "Bob"
    echo '$' git config --global user.email you@$1
    exit 1
fi
