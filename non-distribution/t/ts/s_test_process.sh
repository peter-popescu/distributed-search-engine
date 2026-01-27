#!/bin/bash
# This is a student test

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/../../$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}


# processing stop words is empty

if $DIFF <(echo "and or of the" | c/process.sh) <(cat /dev/null) >&2;
then
    echo "$0 success: processing stop words empty"
    exit 0
else
    echo "$0 failure: processing stop words not empty"
    exit 1
fi

