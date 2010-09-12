#!/bin/sh
#
# Checks that changed lines does not contain any tab characters
# Arguments: file names to check pattern (optional)
#
against=HEAD #todo

pattern="$1"
if [ -z "$pattern" ]; then
    pattern='.*[.](?:php|js|css|tpl|htm|sh|html|phpt)$'
fi

txtfiles=`
    git diff --cached $against --name-only --diff-filter=AM |
    grep -E "$pattern"
`
badfound="0"
for f in $txtfiles ; do
    git diff --cached $against -- "$f" |
        grep -E '^[+]' | # filtering new versions of lines
        sed -e "s|^I|*I|g" | # cleaning output from ^I symbols
        cat -n -T | # highlighting tabs as ^I
        sed -e "s|^|$f line |" | # adding file name
        grep -F '^I' # filtering for lines with tabs

    if [ "$?" == "0" ] ; then
        badfound="1"
    fi
done
if [ "$badfound" == "1" ] ; then
    echo '!!!' Commit check failed.
    echo '!!!' TAB symbols found. You should use 4 spaces instead.
    exit 1
fi

