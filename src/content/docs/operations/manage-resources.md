---
title: "Manage Resources"
sidebar:
  order: 1
---

# How To: Manage Resources

Track, sync, and operate on cloud resources across all registered providers.

## Prerequisites

- Nimbus engine running (`docker compose up -d` or `nimbus serve`)
- At least one provider registered (see [Getting Started](../getting-started.md))
- API authentication token (pass via `Authorization: Bearer <token>` header)

## Register a Provider First

```bash
# CLI
nimbus providers add --id my-oci --type oci --name "OCI Production" --region us-ashburn-1

# API
curl -X POST http://localhost:8000/api/providers \
  -H "Content-Type: application/json" \
  -d '{"id": "my-oci", "provider_type": "oci", "display_name": "OCI Production", "region": "us-ashburn-1"}'
```

## Create a Resource

```bash
# CLI (interactive prompts for provider, type, name, status, protection)
nimbus resources create

# API
curl -X POST http://localhost:8000/api/resources \
  -H "Content-Type: application/json" \
  -d '{"provider_id": "my-oci", "resource_type": "compute", "external_id": "ext-abc123",
       "display_name": "web-server-01", "status": "running", "protection_level": "standard",
       "monthly_cost_estimate": 12.50, "tags": {"env": "prod"}}'
```

In the **UI**, navigate to **Resources** in the sidebar and click **Add Resource**.

## Sync Resources from a Provider

Pull the current state of all resources from a cloud provider into Nimbus:

```bash
# CLI
nimbus resources sync my-oci
# Output: Found 14 resources from my-oci -- Synced: 3 created, 11 updated

# API
curl -X POST http://localhost:8000/api/resources/sync/my-oci
```

Sync is idempotent -- it matches on `provider_id` + `external_id` and updates existing records.

## List and Search Resources

```bash
# CLI -- list with filters
nimbus resources list --provider my-oci --type compute --format table

# CLI -- full-text search
nimbus resources search "web-server"

# API -- filter by provider, type, status, or tag
curl "http://localhost:8000/api/resources?provider_id=my-oci&tag=env:prod"

# API -- search
curl "http://localhost:8000/api/resources/search?q=web-server"
```

## Run a Health Check

```bash
curl -X POST http://localhost:8000/api/resources/{resource_id}/action \
  -H "Content-Type: application/json" \
  -d '{"action": "health_check"}'
```

The adapter queries the provider to verify the resource is reachable. Results are recorded
in the action log at `GET /api/resources/{resource_id}/logs`.

## Bulk Operations

```bash
# API -- apply start/stop/tag to multiple resources
curl -X POST http://localhost:8000/api/resources/bulk/action \
  -H "Content-Type: application/json" \
  -d '{"resource_ids": ["res-001", "res-002"], "action": "stop"}'

# CLI -- batch with dry-run support
nimbus resources batch --action stop --ids "res-001,res-002" --dry-run
```

## Delete a Resource

```bash
# CLI (with confirmation, or --force to skip, or --dry-run to preview)
nimbus resources delete res-001

# API
curl -X DELETE http://localhost:8000/api/resources/res-001
```

Protected resources (`protection_level != "none"`) cannot be deleted until protection is removed.

:::info[API Reference]
Full endpoint documentation: [API Reference -- Resources](/api/resources)
:::


## Official Documentation

- [OCI Compute Instances](https://docs.oracle.com/en-us/iaas/Content/Compute/home.htm)
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/latest/userguide/)
- [Azure Virtual Machines](https://learn.microsoft.com/en-us/azure/virtual-machines/)
- [GCP Compute Engine](https://cloud.google.com/compute/docs)
