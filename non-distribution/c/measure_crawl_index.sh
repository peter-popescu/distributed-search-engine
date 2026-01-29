#!/bin/bash

# log time taken to index and crawl each file and store in d/benchmark.csv

T_FOLDER=${T_FOLDER:-t}
R_FOLDER=${R_FOLDER:-}

cd "$(dirname "$0")/..$R_FOLDER" || exit 1

cat /dev/null > d/visited.txt
cat /dev/null > d/global-index.txt
cat /dev/null > d/benchmark.csv

echo "https://cs.brown.edu/courses/csci1380/sandbox/3" > d/urls.txt

./measure_engine.sh

