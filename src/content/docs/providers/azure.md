---
title: "Azure"
sidebar:
  order: 3
---

# Azure Provider Setup

Nimbus authenticates to Azure through the `DefaultAzureCredential` chain.
That means the engine tries multiple credential sources in order — pick the
one that matches your deployment environment.

## Prerequisites

- An Azure subscription
- Azure CLI installed (`az`) — needed for option D below or to mint a Service Principal
- `azure-identity` and `azure-mgmt-compute` installed:
  `cd engine && uv pip install -e ".[azure]"`
- The Nimbus engine running

## 1. Pick a Credential Source

`DefaultAzureCredential` walks this chain on each call and uses the first
one that resolves. Choose the source that matches where Nimbus runs:

| Option | When to use | What you provide |
|--------|-------------|------------------|
| **A. Service Principal (recommended for portable deploys)** | Self-hosted, container, on-prem, CI/CD | `tenant_id`, `client_id`, `client_secret`, `subscription_id` |
| **B. Environment variables** | Already-running app where envs are injected (Infisical, container orchestrator) | Same fields as Service Principal, exported as env vars |
| **C. Managed Identity** | Nimbus running inside Azure (VM, App Service, AKS, Functions) | Just enable a system- or user-assigned identity |
| **D. Azure CLI** | Local dev only — `az login` cached on the machine | Nothing — uses your cached `az` token |

Sections below detail each option.

## Option A — Service Principal (file-based)

Create the principal once:

```bash
az ad sp create-for-rbac \
  --name "nimbus-sp" \
  --role contributor \
  --scopes /subscriptions/{your-subscription-id}
```

This outputs `appId` (client_id), `password` (client_secret), and `tenant`.
Save these values into a JSON config:

```bash
cp templates/provider-azure.template local/config/provider-azure.json
```

Open `local/config/provider-azure.json` and fill in:

```json
{
    "tenant_id": "{your-tenant-id}",
    "client_id": "{your-client-id}",
    "client_secret": "{your-client-secret}",
    "subscription_id": "{your-subscription-id}"
}
```

Register with the file path:

```bash
nimbus providers add \
  --id my-azure \
  --type azure \
  --name "My Azure Subscription" \
  --credentials local/config/provider-azure.json
```

Nimbus reads the JSON, exports the values as env vars in-process, then lets
`DefaultAzureCredential` pick them up.

## Option B — Environment Variables

Recommended over the file path when Infisical or a container orchestrator
already injects secrets:

```bash
export NIMBUS_SECRETS_BACKEND=env
export AZURE_TENANT_ID=...
export AZURE_CLIENT_ID=...
export AZURE_CLIENT_SECRET=...
export AZURE_SUBSCRIPTION_ID=...
```

Then register without `--credentials`:

```bash
nimbus providers add \
  --id my-azure \
  --type azure \
  --name "My Azure Subscription"
```

## Option C — Managed Identity

When Nimbus is hosted inside Azure (VM, AKS, App Service, Functions), assign
a system- or user-assigned identity to the host with **Contributor** role on
the target subscription. No secrets needed; `DefaultAzureCredential` picks up
the identity via the Instance Metadata Service.

## Option D — Azure CLI (local dev only)

Cache a token on your workstation:

```bash
az login
az account set --subscription {your-subscription-id}
```

Then register without `--credentials` and without env vars. **Do not** use
this in production — `az` cache is per-user and tied to interactive login.

## Register via API (alternative)

```
POST /api/providers
{
  "id": "my-azure",
  "provider_type": "azure",
  "display_name": "My Azure Subscription",
  "region": "{your-region}"
}
```

## 6. Verify

```bash
nimbus providers list --format json
curl http://localhost:8000/api/providers/my-azure/credential-status
```

A successful credential check returns `status: valid`.

## Provider CLI Baseline

Nimbus now mounts an Azure-specific CLI through provider discovery:

```bash
nimbus azure context set my-azure
nimbus azure context show
nimbus azure vm list
nimbus azure vm get /subscriptions/.../virtualMachines/vm1
nimbus azure cost current --period 2026-04
nimbus azure freetier show
nimbus azure vm create --provider my-azure --resource-group rg-main --name vm1
nimbus azure vm stop --provider my-azure --id /subscriptions/.../virtualMachines/vm1
nimbus azure vm terminate --provider my-azure --id /subscriptions/.../virtualMachines/vm1 --force
```

This CLI mirrors the current MVP adapter contract. Richer Azure VM workflows are still pending.

Nimbus also ships an Azure free-tier spec covering the current VM and managed-disk offers most relevant to the Azure adapter. Use `nimbus azure freetier show -f json` to inspect the normalized limits.

## Cost Management

Azure Cost Management API is **free** for Enterprise Agreement customers. Nimbus queries
`ActualCost` with monthly granularity for spending reports.

## Notes

- Whatever credential source you pick, the principal/identity must have
  **Contributor** role (or a custom role with `Microsoft.Compute/*` and
  `Microsoft.CostManagement/query/action` permissions) on the subscription.
- Nimbus uses `begin_deallocate()` for stop operations, which ceases compute billing
  but retains managed disks.
- For Spot VM workloads, configure the eviction policy to `Delete` to ensure zero
  residual costs after budget enforcement.

:::info[Official Documentation]
[Azure SDK for Python](https://learn.microsoft.com/en-us/python/api/overview/azure/)
| [DefaultAzureCredential](https://learn.microsoft.com/en-us/python/api/azure-identity/azure.identity.defaultazurecredential)
| [Credential Chains](https://learn.microsoft.com/en-us/azure/developer/python/sdk/authentication/credential-chains)
| [Service Principal Auth](https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1)
:::
