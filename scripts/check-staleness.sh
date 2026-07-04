#!/usr/bin/env bash
# check-staleness.sh — ADVISORY drift check: compare the vendored contract
# version (openapi.json info.version) against the backend repo's latest v*
# tag. Warns on mismatch; always exits 0 (delivery lag is expected between a
# backend tag and the next bot delivery). Needs GITHUB_TOKEN while the
# backend repo is private.
set -uo pipefail

vendored=$(python3 -c "import json; print(json.load(open('openapi.json'))['info']['version'])" 2>/dev/null)
if [ -z "${vendored:-}" ]; then
  echo "advisory: could not read vendored contract version"; exit 0
fi

auth=()
[ -n "${GITHUB_TOKEN:-}" ] && auth=(-H "Authorization: Bearer $GITHUB_TOKEN")
latest=$(curl -sS "${auth[@]}" \
  "https://api.github.com/repos/czhaoca/nimbus/tags?per_page=20" 2>/dev/null \
  | python3 -c "
import json, sys
try:
    tags = [t['name'] for t in json.load(sys.stdin) if t['name'].startswith('v')]
    print(tags[0] if tags else '')
except Exception:
    print('')")

if [ -z "$latest" ]; then
  echo "advisory: could not list backend tags (token missing or API unreachable)"; exit 0
fi

if [ "v$vendored" = "$latest" ]; then
  echo "contract fresh: vendored v$vendored == backend $latest"
else
  echo "ADVISORY: vendored contract v$vendored != backend latest tag $latest — a delivery may be pending"
fi
exit 0
