# nimbus-docs

Public documentation site for the [Nimbus](https://github.com/czhaoca/nimbus)
infrastructure platform. Astro + Starlight.

## Artifact-consumer model (ADR-0008)

This repo builds **only from vendored contract artifacts** committed at the
repo root — it never imports or references the Nimbus engine:

| Artifact | Contents |
| --- | --- |
| `openapi.json` | REST surface (rendered by starlight-openapi) |
| `ops.json` | Operation-registry surface (also the MCP contract) |
| `ws-events.json` | Typed `/ws` event catalog |
| `src/content/docs/cli-reference/` | Generated CLI reference pages |

The artifacts are **generated in the backend repo** (`scripts/gen-contracts.sh`
there) and **delivered here by backend CI** as bot commits stamped with the
contract version (`info.version` in `openapi.json`, mirrored in
`package.json`'s `nimbusContract`). Never edit them by hand; a manual edit
will be overwritten by the next delivery.

## Develop

```bash
pnpm install
pnpm dev        # local dev server
pnpm build      # production build (the CI gate)
```

## Contract staleness

`scripts/check-staleness.sh` compares the delivered contract stamp
(`package.json` → `nimbusContract`) against the backend's latest
`contract-vX.Y.Z` release tag and **fails (exit 1)** on a mismatch — a red
nightly run means the bot delivery is behind a cut release
(czhaoca/nimbus#307). Legacy `v*` tags are ignored by design (frozen
pre-scheme milestones). Tokenless or pre-first-release runs stay
advisory-green; the nightly cron activates once the owner stages the
`github_token` read secret and registers the cron (czhaoca/nimbus#308).

## Versioning

The site tracks the backend's `CONTRACT_VERSION` (semver, `/api/v1` URL
namespace). Breaking-change policy and the deprecation window are documented
in the backend repo's `design/shared/api-versioning.md`.
