#!/bin/bash
# This is a student test

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/../../$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}
DIFF_PERCENT=${DIFF_PERCENT:-0}

# empty (just has stop)

cat /dev/null > d/visited.txt
cat /dev/null > d/global-index.txt

echo "stop" > d/urls.txt

./engine.sh

EXIT=0

if $DIFF <(sort d/visited.txt) <(cat /dev/null) >&2;
then
    echo "$0 success: visited urls are identical"
else
    echo "$0 failure: visited urls are not identical"
    EXIT=1
fi

if $DIFF <(sort d/global-index.txt) <(cat /dev/null) >&2;
then
    echo "$0 success: global-index is identical"
else
    echo "$0 failure: global-index is not identical"
    EXIT=1
fi

exit $EXIT
