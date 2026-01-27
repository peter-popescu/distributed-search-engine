#!/bin/bash
# This is a student test

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/../../$R_FOLDER" || exit 1

DIFF=${DIFF:-diff}

cat "$T_FOLDER"/d/d7.txt > d/global-index.txt

# querying stop word gives nothing

term="a"

if $DIFF <(./query.js "$term") <(cat /dev/null) >&2;
then
    echo "$0 success: querying stop word empty"
    exit 0
else
    echo "$0 failure: query stop word not empty"
    exit 1
fi

# redirect d4 into it (gives all terms)

if $DIFF <(./query.js <"$T_FOLDER"/d/d4.txt) <(cat "$T_FOLDER"/d/d7.txt) >&2;
then
    echo "$0 success: search results are identical"
    exit 0
else
    echo "$0 failure: search results are not identical"
    exit 1
fi

# more specific query gives single line (matches trigram)

term="check stuff level"

if $DIFF <(./query.js "$term") <(grep -F "$term" "$T_FOLDER"/d/d7.txt) >&2;
then
    echo "$0 success: search results match trigram"
    exit 0
else
    echo "$0 failure: search results don't match trigram"
    exit 1
fi

