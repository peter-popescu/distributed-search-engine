#!/bin/bash
# This is a student test

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/../../$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

EXIT=0

# empty body

if $DIFF <(cat "$T_FOLDER"/d/sd0.txt | c/getText.js | sort) <(cat /dev/null) >&2;
then
    echo "$0 success: texts are identical"
else
    echo "$0 failure: texts are not identical"
    EXIT=1
fi

# empty document

if $DIFF <(cat /dev/null | c/getText.js | sort) <(cat /dev/null) >&2;
then
    echo "$0 success: texts are identical"
else
    echo "$0 failure: texts are not identical"
    EXIT=1
fi

exit $EXIT
