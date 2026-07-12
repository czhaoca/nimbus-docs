#!/usr/bin/env bash
# check-staleness.sh — contract staleness gate (czhaoca/nimbus#307): compare
# the delivered contract stamp (package.json nimbusContract) against the
# backend's latest contract-vX.Y.Z release tag.
#
# Exit semantics:
#   token present + latest release known + mismatch -> exit 1 (stale: the bot
#     delivery is behind a cut release — check the backend contract-delivery
#     pipeline)
#   match -> exit 0
#   GITHUB_TOKEN missing / API unreachable / no contract-v* releases yet
#     -> advisory, exit 0 (public forks and tokenless local runs never go red)
#
# Legacy v1.0.0–v1.3.0 tags are frozen pre-scheme milestones and are ignored
# by design — only contract-v* names carry the release invariant (see the
# backend's design/shared/api-versioning.md §Contract release tags).
set -uo pipefail

vendored=$(python3 -c "import json; print(json.load(open('package.json')).get('nimbusContract',''))" 2>/dev/null)
if [ -z "${vendored:-}" ]; then
  echo "advisory: could not read package.json nimbusContract"; exit 0
fi

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "advisory: GITHUB_TOKEN not set — staleness not verifiable (delivered contract: $vendored)"; exit 0
fi

latest=$(curl -sS -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/czhaoca/nimbus/tags?per_page=100" 2>/dev/null \
  | python3 -c "
import json, sys
try:
    names = [t['name'] for t in json.load(sys.stdin) if t['name'].startswith('contract-v')]
    names.sort(key=lambda n: [int(x) for x in n[len('contract-v'):].split('.')])
    print(names[-1] if names else '')
except Exception:
    print('')")

if [ -z "$latest" ]; then
  echo "advisory: no contract-v* release tags found (pre-first-release, or API unreachable)"; exit 0
fi

if [ "contract-v$vendored" = "$latest" ]; then
  echo "contract fresh: delivered $vendored == backend latest $latest"
  exit 0
fi

echo "STALE: delivered contract $vendored != backend latest release $latest — check the backend contract-delivery pipeline" >&2
exit 1
