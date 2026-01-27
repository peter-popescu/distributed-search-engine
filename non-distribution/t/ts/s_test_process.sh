#!/bin/bash
# This is a student test

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/../../$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

EXIT=0

# processing empty is empty

if $DIFF <(cat /dev/null | c/process.sh) <(cat /dev/null) >&2;
then
    echo "$0 success: processing empty is empty"
else
    echo "$0 failure: processing empty not empty"
    EXIT=1
fi

# processing stop words is empty

if $DIFF <(echo "and or of the" | c/process.sh) <(cat /dev/null) >&2;
then
    echo "$0 success: processing stop words empty"
else
    echo "$0 failure: processing stop words not empty"
    EXIT=1
fi

exit $EXIT
