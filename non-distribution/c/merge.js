#!/usr/bin/env node

/*
Merge the current inverted index (assuming the right structure) with the global index file
Usage: input > ./merge.js global-index > output

The inverted indices have the different structures!

Each line of a local index is formatted as:
  - `<word/ngram> | <frequency> | <url>`

Each line of a global index is be formatted as:
  - `<word/ngram> | <url_1> <frequency_1> <url_2> <frequency_2> ... <url_n> <frequency_n>`
  - Where pairs of `url` and `frequency` are in descending order of frequency
  - Everything after `|` is space-separated

-------------------------------------------------------------------------------------
Example:

local index:
  word1 word2 | 8 | url1
  word3 | 1 | url9
EXISTING global index:
  word1 word2 | url4 2
  word3 | url3 2

merge into the NEW global index:
  word1 word2 | url1 8 url4 2
  word3 | url3 2 url9 1

Remember to error gracefully, particularly when reading the global index file.
*/

const fs = require('fs');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
});

// 1. Read the incoming local index data from standard input (stdin) line by line.
let localIndex = '';
rl.on('line', (line) => {
  localIndex += line + '\n';
});

rl.on('close', () => {
  // 2. Read the global index name/location, using process.argv
  // and call printMerged as a callback
  fs.readFile(process.argv[2], 'utf-8', printMerged);
});

const printMerged = (err, data) => {
  if (err) {
    console.error('Error reading file:', err);
    return;
  }

  // Split the data into an array of lines
  const localIndexLines = localIndex.split('\n');
  const globalIndexLines = data.split('\n');

  localIndexLines.pop();
  globalIndexLines.pop();

  const local = {};
  const global = {};

  // 3. For each line in `localIndexLines`, parse them and add them to the `local` object
  // where keys are terms and values store a url->freq map (one entry per url).
  for (const line of localIndexLines) {
    const [terms, freq, url] = line.trim().split(' | ');
    local[terms] = {[url]: Number(freq)};
  }

  // 4. For each line in `globalIndexLines`, parse them and add them to the `global` object
  // where keys are terms and values are url->freq maps (one entry per url).
  // Use the .trim() method to remove leading and trailing whitespace from a string.
  for (const line of globalIndexLines) {
    const [terms, urlFreqs] = line.trim().split(' | ');
    const urlFreqsSplit = urlFreqs.split(' ');
    for (let i = 0; i < urlFreqsSplit.length; i += 2) {
      const [url, freq] = urlFreqsSplit.slice(i, i+2);
      if (terms in global) {
        global[terms][url] = Number(freq);
      } else {
        global[terms] = {[url]: Number(freq)};
      }
    }
  }

  // 5. Merge the local index into the global index:
  // - For each term in the local index, if the term exists in the global index:
  //     - Merge by url so there is at most one entry per url.
  //     - Sum frequencies for duplicate urls.
  // - If the term does not exist in the global index:
  //     - Add it as a new entry with the local index's data.
  for (const [terms, localUrlFreqMap] of Object.entries(local)) {
    if (terms in global) {
      const globalUrlFreqMap = global[terms];
      for (const [url, localFreq] of Object.entries(localUrlFreqMap)) {
        if (url in globalUrlFreqMap) {
          globalUrlFreqMap[url] += localFreq;
        } else {
          globalUrlFreqMap[url] = localFreq;
        }
      }
    } else {
      global[terms] = localUrlFreqMap;
    }
  }

  // 6. Print the merged index to the console in the same format as the global index file:
  //    - Each line contains a term, followed by a pipe (`|`), followed by space-separated pairs of `url` and `freq`.
  //    - Terms should be printed in alphabetical order.
  const sortedTerms = Object.entries(global).sort((a, b) => a[0].localeCompare(b[0]));
  for (const [terms, urlFreqMap] of sortedTerms) {
    const sortedUrls = Object.entries(urlFreqMap).sort((a, b) => b[1] - a[1]);
    const urlString = sortedUrls
        .map(([url, freq]) => `${url} ${freq}`)
        .join(' ');
    console.log(`${terms} | ${urlString}`);
  }
};
