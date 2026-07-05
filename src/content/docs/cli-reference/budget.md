---
title: "nimbus budget"
sidebar:
  order: 3
---

Manage budget rules and spending.

## Commands

### add

Add a budget rule.

Usage: `nimbus budget add [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Provider ID (omit for global) |
| `--limit` | float | no | `0` | Monthly spend limit (USD) |
| `--threshold` | float | no | `0.8` | Alert threshold (0.0-1.0) |
| `--action` | text | no | `alert` | Action when budget exceeded |

### status

Show current budget status.

Usage: `nimbus budget status [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider ID |
