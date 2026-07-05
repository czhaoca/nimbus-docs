---
title: "nimbus-admin deploy"
sidebar:
  order: 5
---

Operator deploy residue: AGENTS.md registry validation.

## Commands

### validate-agents

Validate AGENTS.md registry metadata for governed deployments.

Usage: `nimbus-admin deploy validate-agents [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--path`, `-p` | path | no | `()` | AGENTS.md path to validate. Repeatable. |
| `--json` | boolean | no | `False` | Output JSON |
