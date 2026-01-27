#!/bin/bash
# This is a student test

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/../../$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}
DIFF_PERCENT=${DIFF_PERCENT:-0}

EXIT=0

# merge empty with empty

cat /dev/null > d/global-index.txt

cat /dev/null | c/merge.js d/global-index.txt > d/temp-global-index.txt
mv d/temp-global-index.txt d/global-index.txt

if $DIFF <(sort d/global-index.txt) <(cat /dev/null) >&2;
then
    echo "$0 success: global indexes are identical"
else
    echo "$0 failure: global indexes are not identical"
    EXIT=1
fi

# merge empty with something

FILE="$T_FOLDER"/d/m1.txt

cat /dev/null > d/global-index.txt

cat "$FILE" | c/merge.js d/global-index.txt > d/temp-global-index.txt
mv d/temp-global-index.txt d/global-index.txt

if $DIFF <(sort d/global-index.txt) <(cat "$FILE") >&2;
then
    echo "$0 success: global indexes are identical"
else
    echo "$0 failure: global indexes are not identical"
    EXIT=1
fi

# merge something with empty

FILE="$T_FOLDER"/d/m1.txt

cat "$FILE" > d/global-index.txt

cat /dev/null | c/merge.js d/global-index.txt > d/temp-global-index.txt
mv d/temp-global-index.txt d/global-index.txt

if $DIFF <(sort d/global-index.txt) <(cat "$FILE") >&2;
then
    echo "$0 success: global indexes are identical"
else
    echo "$0 failure: global indexes are not identical"
    EXIT=1
fi

exit $EXIT
