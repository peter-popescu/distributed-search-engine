#!/bin/bash

tmp_file="$(mktemp d/crawl.XXXXXX)"

if ! curl -skL --retry 3 --retry-delay 1 --retry-connrefused "$1" >"$tmp_file"; then
  rm -f "$tmp_file"
  exit 1
fi

echo "$1" >>d/visited.txt

# c/getURLs.js "$1" <"$tmp_file" | grep -vxf d/visited.txt >>d/urls.txt
# c/getText.js <"$tmp_file"

c/getURLs.js "$1" <"$tmp_file" 2>&1 1> >(grep -vxf d/visited.txt >>d/urls.txt)

rm -f "$tmp_file"
