#!/usr/bin/env node

// run the same query multiple times to measure query throughput
// NOTE: only works with existing populated globalIndex

const {execSync} = require('child_process');

const TOTAL_QUERIES = 100;
const TERM = 'book'; // term that's in sandbox 3 a lot

const start = Date.now();

for (let i = 0; i < TOTAL_QUERIES; i++) {
  execSync(`./query.js "${TERM}"`, {stdio: 'ignore'});
}

const timePassed = (Date.now() - start) / 1000;

console.log(`finished ${TOTAL_QUERIES} queries in ${timePassed.toFixed(2)}s`);
console.log(`throughput: ${(TOTAL_QUERIES / timePassed).toFixed(2)} queries/sec`);
