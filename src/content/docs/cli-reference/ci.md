---
title: "nimbus ci"
sidebar:
  order: 4
---

Woodpecker CI status and administration.

## Commands

### crons

Cron entries registered for a repo.

Usage: `nimbus ci crons [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--repo` | text | no | - | owner/name |

### pipelines

Recent pipelines for a repo.

Usage: `nimbus ci pipelines [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--repo` | text | no | - | owner/name |
| `--limit` | integer range | no | `10` |  |

### register-crons

Idempotently create the cron entries the Nimbus task pipelines expect.

Usage: `nimbus ci register-crons [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--repo` | text | no | - | owner/name |
| `--cron` | text | no | - | name=schedule (repeatable). Overrides the default backend EXPECTED_CRONS set — use for consumer-repo crons such as the nightly contract-currency runs (czhaoca/nimbus#306). |

### status

Woodpecker health, version, queue, and the repo's pipelines + crons.

Usage: `nimbus ci status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--repo` | text | no | - | owner/name to inspect (default: WOODPECKER_DEFAULT_REPO) |
