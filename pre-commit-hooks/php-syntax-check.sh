#!/bin/sh
#
# Checks all added and modified php files for syntax
# if command-line php interpretator is available
#
if command -v php > /dev/null ; then
    errors=`echo $amfiles | sed 's/ /\n/g' \
            | grep -E '.*[.]php$'  \
            | xargs --no-run-if-empty -n 1 php -l  2>&1  \
            | grep -vE '^No syntax errors detected' \
    `
    if [ ! -z "$errors" ]; then
        echo '!!!' PHP Syntax errors found:
        echo "$errors"
        exit 1
    fi
fi
