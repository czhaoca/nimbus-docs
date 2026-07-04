---
title: "Provider Overview"
sidebar:
  order: 1
---

# Provider Overview

Nimbus orchestrates infrastructure across 7 cloud and on-premises providers through a
unified adapter architecture. Each provider is registered in the database, authenticated
via runtime-injected environment variables or a compatibility credentials file, and
accessed through a common interface.

## Registered Providers

| Type         | Adapter Class     | SDK / Library                    | Guide                          |
|--------------|-------------------|----------------------------------|--------------------------------|
| `oci`        | `OCIProviderAdapter` | `oci` (Oracle Python SDK)     | [OCI Setup (engineering doc)](https://github.com/czhaoca/nimbus/blob/main/requirements/providers/oci/setup-api-key.md) |
| `aws`        | `AWSAdapter`      | `boto3`                          | [AWS](aws.md)                  |
| `azure`      | `AzureAdapter`    | `azure-mgmt-*`, `azure-identity` | [Azure](azure.md)              |
| `gcp`        | `GCPAdapter`      | `google-cloud-*`                 | [GCP](gcp.md)                  |
| `cloudflare` | `CloudflareAdapter` | REST API (httpx)               | [Cloudflare](cloudflare.md)    |
| `proxmox`    | `ProxmoxAdapter`  | stdlib `urllib.request`          | [Proxmox](proxmox.md)          |
| `unifi`      | `UniFiAdapter`    | stdlib `urllib.request`          | [UniFi](unifi.md)              |

:::note[Provider Router Status]
All seven providers export API routers through discovery. Cloud providers share
standard resource, spending, health, and free-tier endpoints; Proxmox and UniFi
also expose provider-specific operational endpoints.
:::

## Adapter Architecture

All providers implement the `ProviderAdapter` abstract base class (`engine/nimbus/core/interfaces.py`).
The base class defines the contract every adapter must fulfill:

- `provider_type` -- identifier string (e.g. `"aws"`, `"proxmox"`)
- `authenticate(credentials_path, *, credentials)` -- load credentials from file or dict
- `list_resources(resource_type)` -- enumerate resources
- `get_resource(resource_id)` -- fetch a single resource
- `provision(resource_type, config)` -- create a resource
- `terminate(resource_id)` -- destroy a resource
- `get_spending(period)` -- query cost data for a billing period
- `health_check()` -- optional connectivity/status probe
- `get_metrics(resource_id)` -- optional CPU/memory/network utilization

### Mixin Pattern for Domain Extensions

Providers with specialized capabilities extend the base contract in provider-local modules:

- **Proxmox VLAN operations** (`providers/proxmox/adapter/core.py` + `providers/proxmox/adapter/vlan_ops.py`) --
  add `set_vm_vlan()`, `get_vm_config()`, and `check_bridge_vlan_aware()` for VLAN tag management.
- **`UniFiNetworkMixin`** (`providers/unifi/adapter/network.py`) -- adds `list_vlans()`,
  `create_vlan()`, `list_port_profiles()`, and `create_firewall_rule()` for network configuration.

The UniFi mixin expects the host class to expose `self._api(method, path, data)`.

### Resilience

Every adapter inherits `_resilient_call()` from the base class, which wraps API calls with:

- **Retry** -- up to 3 attempts with exponential backoff
- **Circuit breaker** -- trips after 5 consecutive failures, rejects calls for 60 s

## Provider Registration

### CLI

```bash
nimbus providers add \
  --id my-aws \
  --type aws \
  --name "My AWS Account"
```

When using the compatibility file path, add `--credentials /path/to/file`. When using
Infisical or runtime env vars, omit `--credentials`.

### API

```
POST /api/providers
{
  "id": "my-aws",
  "provider_type": "aws",
  "display_name": "My AWS Account"
}
```

### UI

Navigate to **Providers** in the sidebar, click **Add Provider**, and fill in the form.

## Credential Resolution

Nimbus resolves credentials in this order:

1. Numbered env vars for multi-instance providers such as `PROXMOX_1_URL`
2. Flat env vars such as `AWS_ACCESS_KEY_ID`
3. Compatibility file parsing via `credentials_path`

Both the CLI and API now expose non-secret credential metadata:

```bash
nimbus providers list --format json
```

`GET /api/providers` returns the same `credentials_source` and
`credentials_configured` fields for UI or automation use.

Every provider still has a template in `templates/` for compatibility-file setups, but
those templates are no longer the primary onboarding path.

## Health Checks

Use the API monitoring endpoints for provider health and credential validation:

```bash
curl "http://localhost:8000/api/providers/health/check?provider_id=my-aws"
curl "http://localhost:8000/api/providers/my-aws/credential-status"
```

Health checks authenticate with each provider, measure latency, and return status
(`ok`, `error`, `no_adapter`, `unknown`).
