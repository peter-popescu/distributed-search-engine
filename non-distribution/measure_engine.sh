#!/bin/bash
# This is the main entry point of the search engine.
cd "$(dirname "$0")" || exit 1

while read -r url; do

  if [[ "$url" == "stop" ]]; then
    # stop the engine if it sees the string "stop" 
    echo "[engine] stopping"
    exit;
  fi

  # measure crawl throughput
  echo "[engine] crawling $url">/dev/stderr
  start_crawl=$(date +%s%N)
  ./crawl.sh "$url" >d/content.txt
  end_crawl=$(date +%s%N)
  crawl_ms=$(( (end_crawl - start_crawl) / 1000000 ))
  echo "crawler,$url,$crawl_ms" >> d/benchmark.csv

  # measure index throughput
  echo "[engine] indexing $url">/dev/stderr
  start_index=$(date +%s%N)
  ./index.sh d/content.txt "$url"
  end_index=$(date +%s%N)
  index_ms=$(( (end_index - start_index) / 1000000 ))
  echo "indexer,$url,$index_ms" >> d/benchmark.csv

  if  [[ "$(cat d/visited.txt | wc -l)" -ge "$(cat d/urls.txt | wc -l)" ]]; then
      # stop the engine if it has seen all available URLs
      echo "[engine] seen all URLs"
      break;
  fi

done < <(tail -f d/urls.txt)
