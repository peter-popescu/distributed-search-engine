#!/bin/bash
# This is a student test

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/../../$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}
DIFF_PERCENT=${DIFF_PERCENT:-0}

cat /dev/null > d/global-index.txt

cat /dev/null | c/merge.js d/global-index.txt > d/temp-global-index.txt
mv d/temp-global-index.txt d/global-index.txt

if $DIFF <(sort d/global-index.txt) <(cat /dev/null) >&2;
then
    echo "$0 success: global indexes are identical"
    exit 0
else
    echo "$0 failure: global indexes are not identical"
    exit 1
fi
