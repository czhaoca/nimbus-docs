---
title: "Set Up Budgets"
sidebar:
  order: 2
---

# How To: Set Up Budgets

Create budget rules, configure enforcement thresholds, and monitor cloud spending.

## Prerequisites

- Nimbus engine running
- At least one provider registered with resources tracked
- API authentication token with operator-level access

## Create a Budget Rule

```bash
# CLI -- per-provider rule
nimbus budget add --provider my-oci --limit 50.00 --threshold 0.8 --action alert

# CLI -- global rule across all providers
nimbus budget add --limit 200.00 --threshold 0.9 --action scale_down

# API
curl -X POST http://localhost:8000/api/budget/rules \
  -H "Content-Type: application/json" \
  -d '{"provider_id": "my-oci", "monthly_limit": 50.00, "alert_threshold": 0.8,
       "action_on_exceed": "alert", "is_active": true}'
```

In the **UI**, navigate to **Budget**, click **Add Rule**, and fill in the form.

## Threshold and Action Options

| Action | Behavior |
|--------|----------|
| `alert` | Log an alert -- no resources modified |
| `scale_down` | Stop non-critical, auto-terminable running resources |
| `terminate_ephemeral` | Terminate resources with `protection_level=ephemeral` |
| `firewall_lockdown` | Block all non-critical resources (broadest scope) |

Set `alert_threshold` (0.0--1.0) to trigger warnings before the limit is reached. Default is 0.8 (80%).

## Enforcement Cascade

When `POST /api/budget/enforce` runs, the engine:

1. Evaluates every active budget rule against current spending for the period (YYYY-MM).
2. Skips rules where utilization < 100%.
3. For exceeded rules, selects enforceable resources -- excludes `protection_level=critical`,
   filters by `auto_terminate=true` for scale_down/terminate, targets highest cost first.
4. Creates an `ActionLog` entry for each enforcement action.

```bash
# Trigger enforcement manually
curl -X POST http://localhost:8000/api/budget/enforce

# Filter to a single provider
curl -X POST "http://localhost:8000/api/budget/enforce?provider_id=my-oci"
```

## Sync Spending from Providers

```bash
# Pull actual spend from all providers' billing APIs
curl -X POST http://localhost:8000/api/budget/sync-spending

# Record spending manually (for providers without billing API)
curl -X POST "http://localhost:8000/api/budget/spending?provider_id=my-oci&amount=32.50"
```

Records are stored per provider per billing period and are idempotent (upsert on provider_id + period).

## View Budget Status

```bash
# CLI
nimbus budget status
nimbus budget status --provider my-oci

# API
curl http://localhost:8000/api/budget/status
# Returns: [{"provider_id": "my-oci", "period": "2026-02", "total_spent": 32.50,
#            "monthly_limit": 50.0, "utilization": 0.65, "status": "ok", ...}]
```

The **UI** Budget page shows color-coded gauges (green/yellow/red) and a spending chart per provider.

## Update or Deactivate a Rule

```bash
# Update threshold and action
curl -X PUT http://localhost:8000/api/budget/rules/{rule_id} \
  -H "Content-Type: application/json" \
  -d '{"alert_threshold": 0.7, "action_on_exceed": "scale_down"}'

# Deactivate (soft delete)
curl -X PUT http://localhost:8000/api/budget/rules/{rule_id} -d '{"is_active": false}'

# Delete permanently
curl -X DELETE http://localhost:8000/api/budget/rules/{rule_id}
```

:::info[API Reference]
Full endpoint documentation: [API Reference -- Budget](/api/budget)
:::


## Official Documentation

- [AWS Cost Explorer API](https://docs.aws.amazon.com/cost-management/latest/userguide/ce-api.html)
- [OCI Usage API](https://docs.oracle.com/en-us/iaas/Content/Billing/Concepts/billingoverview.htm)
- [GCP Cloud Billing](https://cloud.google.com/billing/docs)
- [Azure Cost Management](https://learn.microsoft.com/en-us/azure/cost-management-billing/)
