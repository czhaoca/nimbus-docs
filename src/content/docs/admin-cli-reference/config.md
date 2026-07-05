---
title: "nimbus-admin config"
sidebar:
  order: 3
---

Configuration import/export.

## Commands

### export

Export Nimbus configuration as JSON.

Usage: `nimbus-admin config export [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--output` | text | no | - | Write to file (default: stdout) |

### get

Get a specific setting value.

Usage: `nimbus-admin config get [OPTIONS] KEY`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `key` | text | yes | - | Setting key to retrieve |

### import

Import Nimbus configuration from a JSON file.

Usage: `nimbus-admin config import [OPTIONS] CONFIG_FILE`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `config_file` | text | yes | - | JSON config file to import |

### list

List all application settings.

Usage: `nimbus-admin config list [OPTIONS]`

_No options._

### set

Set an application setting.

Usage: `nimbus-admin config set [OPTIONS] KEY VALUE`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `key` | text | yes | - | Setting key |
| `value` | text | yes | - | Setting value |
