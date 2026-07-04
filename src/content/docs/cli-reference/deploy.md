---
title: "nimbus deploy"
sidebar:
  order: 11
---

Environment registry, target inventory, and access manifests.

## Commands

### all

Deploy all active projects with a reserved slot for an environment.

Usage: `nimbus deploy all [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--env` | text | yes | - | Env type: dev/prod; aliases normalize to canonical values |
| `--slot` | text | no | `default` | Slot key |
| `--dry-run` | boolean | no | `False` | Plan without deploying |
| `--ssh-user` | text | no | `root` | SSH user on target |
| `--ssh-key` | text | no | `` | Path to SSH private key |
| `--domain` | text | no | `` | Domain for HestiaCP deploy |

### check-ports

Check for port conflicts across projects on the same target.

Usage: `nimbus deploy check-ports [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--target` | text | no | - | Target ID to check |

### compose

Generate a docker-compose.yml from registry data.

Usage: `nimbus deploy compose [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--project` | text | yes | - | Project name |
| `--env` | text | no | `dev` | Env type: dev/prod |
| `--template` | boolean | no | `False` | Placeholder mode for public repos |
| `--output` | text | no | - | Write to file |

### create-pool

Create an explicit port pool for a target.

Usage: `nimbus deploy create-pool [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--target` | text | yes | - | Target inventory ID |
| `--name` | text | yes | - | Pool name |
| `--start` | integer | yes | - | Port range start |
| `--end` | integer | yes | - | Port range end |
| `--desc` | text | no | `` | Description |
| `--default` | boolean | no | `False` | Mark as default pool |

### down

Stop a deployed project on its target.

Usage: `nimbus deploy down [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--project` | text | yes | - | Project name |
| `--env` | text | yes | - | Env type: dev/prod; aliases normalize to canonical values |
| `--slot` | text | no | `primary` | Slot key |
| `--ssh-user` | text | no | `root` | SSH user on target |
| `--ssh-key` | text | no | `` | Path to SSH private key |

### events

List recent allocation audit events.

Usage: `nimbus deploy events [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--limit` | integer | no | `20` | Max events to show |

### list

List the current environment access registry.

Usage: `nimbus deploy list [OPTIONS]`

_No options._

### manifest

Render the access registry manifest as JSON or Markdown.

Usage: `nimbus deploy manifest [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--format` | text | no | `md` | json or md |
| `--output` | text | no | - | Write manifest to a file |

### onboard-cicd

Register Woodpecker CI and/or SonarQube CE as governed apps.

Usage: `nimbus deploy onboard-cicd [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--target` | text | yes | - | Target inventory ID |
| `--pool` | text | yes | - | Port pool ID |
| `--actor` | text | no | `onboard-cicd` | Actor label |
| `--app` | text | no | `all` | Which app to onboard: all \| woodpecker \| sonarqube. reserve_slot upserts (re-points an existing slot to --target), so single-app selection is how a re-target avoids moving the other app's slot (#237). |

### pools

List configured port pools.

Usage: `nimbus deploy pools [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--target` | text | no | - | Filter by target inventory ID |

### register

Register a project in the environment registry.

Usage: `nimbus deploy register [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--name` | text | yes | - | Project name |
| `--desc` | text | no | `` | Description |
| `--repo` | text | no | `` | Repository URL |

### release

Release a reserved environment slot and free its endpoints.

Usage: `nimbus deploy release [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--project` | text | yes | - | Project name |
| `--env` | text | yes | - | Env type: dev/prod; aliases normalize to canonical values |
| `--slot` | text | no | `default` | Slot key |
| `--actor` | text | no | `` | Actor label |

### reserve

Reserve a typed environment slot on an explicit target and port pool.

Usage: `nimbus deploy reserve [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--project` | text | yes | - | Project name |
| `--env` | text | yes | - | Env type: dev/prod; aliases normalize to canonical values |
| `--target` | text | yes | - | Target inventory ID |
| `--pool` | text | yes | - | Port pool ID |
| `--slot` | text | no | `default` | Slot key |
| `--repo` | text | no | `` | Repository URL |
| `--desc` | text | no | `` | Project description |
| `--base-url` | text | no | `` | Optional canonical access URL |
| `--requested-by` | text | no | `` | Actor label |
| `--service` | text | no | `()` | SERVICE:CONTAINER_PORT[:PROTOCOL]. Repeat per service. |

### sync-targets

Sync target inventory from a provider (Proxmox or OCI).

Usage: `nimbus deploy sync-targets [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | yes | - | Provider ID (Proxmox or OCI) |

### target-config

Update a target's allocatable flag and access metadata.

Usage: `nimbus deploy target-config [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--target` | text | yes | - | Target inventory ID |
| `--allocatable`, `--no-allocatable` | boolean | no | - |  |
| `--public-address` | text | no | - | Public hostname or IP |
| `--notes` | text | no | - | Notes |

### targets

List synced deploy targets.

Usage: `nimbus deploy targets [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--provider` | text | no | - | Filter by provider ID |

### up

Deploy a governed project to its registry-assigned target.

Usage: `nimbus deploy up [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--project` | text | yes | - | Project name |
| `--env` | text | yes | - | Env type: dev/prod; aliases normalize to canonical values |
| `--slot` | text | no | `primary` | Slot key |
| `--ssh-user` | text | no | `root` | SSH user on target |
| `--ssh-key` | text | no | `` | Path to SSH private key |
| `--domain` | text | no | `` | Domain for HestiaCP deploy |

### validate

Validate that a project/env slot is ready for deployment.

Usage: `nimbus deploy validate [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--project` | text | yes | - | Project name |
| `--env` | text | no | `dev` | Env type: dev/prod |
| `--slot` | text | no | `default` | Slot key |
| `--json` | boolean | no | `False` | Output JSON |

### validate-agents

Validate AGENTS.md registry metadata for governed deployments.

Usage: `nimbus deploy validate-agents [OPTIONS]`

| Flag | Type | Required | Default | Help |
| --- | --- | --- | --- | --- |
| `--path`, `-p` | path | no | `()` | AGENTS.md path to validate. Repeatable. |
| `--json` | boolean | no | `False` | Output JSON |
