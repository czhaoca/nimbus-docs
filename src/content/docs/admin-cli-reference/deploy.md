---
title: "nimbus-admin deploy"
sidebar:
  order: 5
---

Operator deploy residue: AGENTS.md registry validation, image GC keep-list.

## Commands

### image-keep-list

Print the docker-image GC keep-list, one image ref per line (#318).

Usage: `nimbus-admin deploy image-keep-list [OPTIONS]`

_No options._

### validate-agents

Validate AGENTS.md registry metadata for governed deployments.

Usage: `nimbus-admin deploy validate-agents [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--path`, `-p` | path | no | `()` | AGENTS.md path to validate. Repeatable. |
| `--json` | boolean | no | `False` | Output JSON |
