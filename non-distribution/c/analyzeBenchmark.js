#!/usr/bin/env node

// analyze d/benchmark.csv and calculate throughput from the log

const fs = require('fs');

const data = fs.readFileSync('./d/benchmark.csv', 'utf-8');
const lines = data.split('\n');

const stats = {
  crawler: {count: 0, totalMs: 0},
  indexer: {count: 0, totalMs: 0},
};

lines.forEach((line) => {
  const [component,, duration] = line.split(',');
  const ms = parseFloat(duration);

  if (component in stats) {
    stats[component].count += 1;
    stats[component].totalMs += ms;
  }
});

for (const [name, data] of Object.entries(stats)) {
  const totalSeconds = data.totalMs / 1000;
  const throughput = (data.count / totalSeconds).toFixed(2);

  console.log(`[${name}]`);
  console.log(`  processed:  ${data.count} items`);
  console.log(`  total time: ${totalSeconds.toFixed(2)}s`);
  console.log(`  throughput: ${throughput} pages/sec`);
  console.log('');
}
