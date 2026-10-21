#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROP_SRC="$ROOT/unicentaopos.properties"
PROP_HOME="${HOME}/unicentaopos.properties"
# Sinkronkan template lab ke home (format URL + schema harus benar)
if [[ -f "$PROP_SRC" ]]; then
  cp -a "$PROP_SRC" "$PROP_HOME"
fi
exec "$ROOT/unicenta/opt/unicenta-opos/bin/unicenta-opos"
