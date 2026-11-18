#!/bin/sh
# Stands up the starting state: two Wakapi 2.18.2 servers with existing data.
#   team A -> ~/wakapi-a, http://localhost:3000
#   team B -> ~/wakapi-b, http://localhost:3001
set -e
here="$(cd "$(dirname "$0")" && pwd)"
for t in a b; do
  dest="$HOME/wakapi-$t"
  if [ -e "$dest" ]; then echo "$dest already exists, not touching it"; exit 1; fi
  cp -R "$here/team-$t" "$dest"
  # the server in the container runs as its own user and has to write the database
  chmod -R a+rwX "$dest/data"
  (cd "$dest" && docker compose up -d)
done
echo "waiting for both servers..."
for port in 3000 3001; do
  i=0
  until curl -fs "http://localhost:$port/api/health" >/dev/null 2>&1; do
    i=$((i+1)); [ "$i" -gt 60 ] && { echo "server on port $port did not come up"; exit 1; }
    sleep 2
  done
done
echo "team A: http://localhost:3000   team B: http://localhost:3001"
