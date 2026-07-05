---
title: "nimbus-admin gcloud"
sidebar:
  order: 10
---

Manage GCP resources (residual in-engine commands).

## Commands

### context clear

Clear the active GCP provider context.

Usage: `nimbus-admin gcloud context clear [OPTIONS]`

_No options._

### context set

Set the active GCP provider context.

Usage: `nimbus-admin gcloud context set [OPTIONS] PROVIDER_ID`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `provider_id` | text | yes | - | GCP provider ID to activate |

### context show

Show the current active GCP provider context.

Usage: `nimbus-admin gcloud context show [OPTIONS]`

_No options._

### cost current

Show GCP spending for the current or requested billing period.

Usage: `nimbus-admin gcloud cost current [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider`, `-p` | text | no | - | GCP provider ID |
| `--period` | text | no | - | Billing period in YYYY-MM format |
| `--format`, `-f` | text | no | `table` | Output format (table/json) |
