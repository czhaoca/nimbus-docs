---
title: "nimbus init"
sidebar:
  order: 17
---

Declarative VM init profiles (cloud-init).

## Commands

### profile list

List available init profiles.

Usage: `nimbus init profile list [OPTIONS]`

_No options._

### profile render

Render an init profile to a cloud-init document.

Usage: `nimbus init profile render [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--profile` | text | no | `default` | Profile name |
| `--var` | text | no | - | Variable as KEY=VALUE (repeatable, e.g. __HOSTNAME__=vm) |
| `--provider` | text | no | `` | Target provider (recorded as __PROVIDER__) |
| `--arch` | text | no | `` | Target arch arm\|x86 (recorded as __ARCH__) |
