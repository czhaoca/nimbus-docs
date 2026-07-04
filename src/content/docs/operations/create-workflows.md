---
title: "Create Workflows"
sidebar:
  order: 3
---

# How To: Create Workflows

Define multi-step orchestration workflows in YAML, execute with dry-run, and schedule or trigger via webhooks.

:::note[Implemented With Narrow Action Set]
Workflow CRUD, dry-run, runs, and webhook triggers are implemented.
The available actions are limited to the adapter methods wired in the workflow
engine. Provider-specific workflow depth is still governed by each provider's
roadmap. See the **Schedule a Workflow** section for the current
schedule-execution caveat.
:::

## Prerequisites

- Nimbus engine running
- Providers registered for each provider referenced in workflow steps
- API authentication token with admin-level access (workflow CRUD requires admin)

## YAML Workflow Structure

```yaml
name: provision-web-stack
description: Provision a VM and create a DNS record
parameters:
  - vm_name
  - dns_record
steps:
  - id: create-vm
    action: provision_vm
    provider_id: my-oci
    config:
      display_name: "{{ param.vm_name }}"
      resource_type: instance
    on_failure: fail
  - id: create-dns
    action: create_dns
    provider_id: my-cloudflare
    config:
      name: "{{ param.dns_record }}"
      content: "{{ steps.create-vm.ip_address }}"
    depends_on: [create-vm]
```

**Step fields**: `id` (unique), `action` (see below), `provider_id`, `config` (key-value pairs),
`depends_on` (list of step IDs), `on_failure` (`fail` | `continue`).

**Available actions**: `provision_vm`, `terminate_vm`, `stop_vm`, `health_check`, `create_dns`, `update_dns`.

**Parameter references**: `{{ param.<name> }}` for runtime params, `{{ steps.<id>.<field> }}` for
previous step outputs. Steps execute in topological order based on `depends_on`.

## Create a Workflow

```bash
curl -X POST http://localhost:8000/api/workflows \
  -H "Content-Type: application/json" \
  -d '{"name": "provision-web-stack", "description": "VM + DNS workflow",
       "yaml_definition": "name: provision-web-stack\nsteps:\n  - id: create-vm\n    action: provision_vm\n    provider_id: my-oci\n    config:\n      display_name: web-01"}'
```

Invalid YAML returns HTTP 422 with a descriptive error. Duplicate names return HTTP 409.

## Dry-Run Mode

Preview what a workflow would do without making changes:

```bash
curl -X POST http://localhost:8000/api/workflows/{workflow_id}/run \
  -H "Content-Type: application/json" \
  -d '{"parameters": {"vm_name": "web-01"}, "dry_run": true}'
```

Each step in the response will have `"status": "planned"` instead of being executed.

## Execute a Workflow

```bash
curl -X POST http://localhost:8000/api/workflows/{workflow_id}/run \
  -H "Content-Type: application/json" \
  -d '{"parameters": {"vm_name": "web-01"}, "dry_run": false}'
```

Returns a `WorkflowRun` with `status` (`success` | `failed` | `dry_run`) and per-step results.

## Schedule a Workflow

```bash
# Run daily at 06:00 (interpreted in NIMBUS_TIMEZONE, default UTC)
curl -X POST http://localhost:8000/api/workflows/{workflow_id}/schedules \
  -H "Content-Type: application/json" \
  -d '{"cron_expression": "0 6 * * *", "is_active": true}'

# List schedules
curl http://localhost:8000/api/workflows/{workflow_id}/schedules

# Delete a schedule
curl -X DELETE http://localhost:8000/api/workflows/schedules/{schedule_id}
```

### How scheduling works

The `workflow-scheduler` task runs every minute via a Woodpecker cron
pipeline (`.woodpecker/cron-workflow-scheduler.yml`) inside the engine
container. Each tick:

1. Queries `WorkflowSchedule` rows where `is_active = True`.
2. For each schedule whose `next_run_at` has elapsed, fires
   `execute_workflow(..., trigger="scheduled")` against the parent
   workflow.
3. Updates `last_run_at`, advances `next_run_at` to the next future
   fire computed via `croniter`, and increments `run_count`.

The cron expression is interpreted in the timezone named by the
`NIMBUS_TIMEZONE` environment variable. The default is `UTC`; setting
`NIMBUS_TIMEZONE=America/Vancouver` makes `"0 6 * * *"` fire at
06:00 Pacific. All persisted timestamps (`last_run_at`, `next_run_at`,
the resulting `WorkflowRun.started_at`) remain in UTC.

### Missed-tick policy

If the engine or Woodpecker pipeline was down at the moment a schedule
should have fired, the scheduler **skips the missed run** (matching
cron(8) semantics). On the next tick after recovery, `next_run_at`
advances to the next future fire — there is no catch-up storm. If a
missed run is operationally important, trigger the workflow manually
via `POST /api/workflows/{workflow_id}/run`.

### Single-instance deployment assumption

The current scheduler design assumes a single engine instance. The
Woodpecker cron itself guarantees one tick per minute at the dispatch
layer, but the engine's other in-process background loops (health
probes, billing guardian, etc.) all assume single-instance. Multi-
instance HA — including a leader-election story for the in-process
loops — is tracked as **GAP-016** in
`requirements/REQUIREMENT_GAPS.md`. Until that lands, do not deploy
multiple engine replicas behind the same database.

## Webhook Triggers

Trigger a workflow by name from external systems (optionally secured with HMAC-SHA256):

```bash
curl -X POST http://localhost:8000/api/workflows/trigger/provision-web-stack \
  -H "Content-Type: application/json" \
  -H "X-Webhook-Signature: <hmac-sha256-hex>" \
  -d '{"parameters": {"vm_name": "web-02"}}'
```

## Monitor Workflow Runs

```bash
# List recent runs (default: last 20)
curl "http://localhost:8000/api/workflows/{workflow_id}/runs?limit=10"

# Get a specific run with step-by-step results
curl http://localhost:8000/api/workflows/{workflow_id}/runs/{run_id}
```

In the **UI**, navigate to **Workflows** to see run history with status indicators and
expandable step details.

:::info[API Reference]
Full endpoint documentation: [API Reference -- Workflows](/api/workflows)
:::
