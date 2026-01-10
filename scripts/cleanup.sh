#!/usr/bin/env bash

top=$(git rev-parse --show-toplevel)

kill_by_pattern() {
    pattern="$1"
    if command -v pkill; then
        pkill -f "$pattern"
    fi
}

kill_by_port() {
    port="$1"
    lsof -ti tcp:"$port" | xargs -r kill
}

all_ports=$(grep -Rho 'port: [0-9]\+' "$top/test" | cut -d' ' -f2 | sort -n  | uniq)

# Try to stop spawned nodes that run the project entrypoints.
kill_by_pattern "node .*distribution.js"
kill_by_pattern "node .*config.js"
for port in $all_ports; do
    kill_by_port "$port"
done
