## Node and Shell Tips
Quick tips for running and testing this repo from the shell.

### Run a node
```bash
node distribution.js --config '{"ip":"127.0.0.1","port":9001}'
```

### Run tests
```bash
npm test -- -t
```

### Run extra-credit tests
```bash
npm test -- -ec
```

### Typecheck
```bash
npx tsc
```

### Useful Node tricks
Run a one-off script:
```bash
node -e "require('./distribution.js')(); console.log(globalThis.distribution.util.id.getNID({ip:'1.2.3.4', port: 1}))"
```

Start a REPL with the library loaded:
```bash
node
> require('./distribution.js')()
> distribution.local.status.get('nid', console.log)
```

### Shell safety
- Kill stale node processes if ports are stuck: `pkill -f "node .*distribution.js"`.
- Prefer explicit ports to avoid conflicts when running multiple nodes.

### Why `globalThis.distribution` exists
`distribution.js` attaches the library to `globalThis.distribution` so you can
freely plug in either your implementation or the library implementation while
still sharing runtime state. 
For example, RPC relies on a shared remote-to-local (and the inverse) pointer map 
(and other shared state like routes, group config, and node config).
Say, you were using the library's RPC implementation, but your own router service implementation.
This allows the latter to share the same data structures as the former. 

The only thing you should be careful of, is the order in which you assign attributes to `globalThis.distribution`.
Ideally, any assignments should happen before any library code is loaded, so that the library code can use the assigned attributes.
Right now, all assignments happen in `distribution.js` before any other code runs.

This does not create a global singleton in the traditional sense, because the node process is the unit of isolation here.
Each node process initializes its own `globalThis.distribution`, so state does not leak across processes, but it is shared across modules inside the same process.
