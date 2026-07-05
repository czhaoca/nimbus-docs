---
title: "nimbus-admin tasks"
sidebar:
  order: 18
---

Scheduled / on-demand task management.

## Commands

### list

List all registered tasks with schedule and last-run summary.

Usage: `nimbus-admin tasks list [OPTIONS]`

_No options._

### run

Fire a single attempt of a task immediately and print the result.

Usage: `nimbus-admin tasks run [OPTIONS] NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `name` | text | yes | - | Task name from `nimbus tasks list` |
| `--actor` | text | no | `cli` | Caller identifier |
| `--invoked-by` | text | no | `cli` | Override the invoked_by context (e.g. 'woodpecker' for pipeline runs) |
| `--post-callback` | boolean | no | `False` | After running, POST the TaskResult to ${NIMBUS_CALLBACK_URL}/api/task-runs/{name}/callback with bearer ${NIMBUS_API_TOKEN}. Used by Woodpecker pipelines. |

### status

Show the latest status snapshot for a single task.

Usage: `nimbus-admin tasks status [OPTIONS] NAME`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `name` | text | yes | - | Task name from `nimbus tasks list` |
