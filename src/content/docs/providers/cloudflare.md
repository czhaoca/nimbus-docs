---
title: "Cloudflare"
sidebar:
  order: 5
---

# Cloudflare Provider Setup

Nimbus authenticates to Cloudflare with a scoped API token. **Recommended**:
inject the token via env var or Infisical. **Compatibility**: drop the token
in `local/config/cloudflare-api-token`.

## Prerequisites

- A Cloudflare account with at least one zone (domain)
- The Nimbus engine running

## 1. Create an API Token

1. Open the [API Tokens page](https://dash.cloudflare.com/profile/api-tokens).
2. Click **Create Token**.
3. Use the **Edit zone DNS** template, or create a custom token with:
   - **Zone : DNS : Edit** — for creating, updating, and deleting DNS records
   - **Zone : Zone : Read** — for listing your zones
   - **Account : Cloudflare Tunnel : Edit** — for tunnel lifecycle and route updates
   - **Account : Account Settings : Read** — for account-scoped tunnel API discovery
4. Scope the token to the specific zones Nimbus should manage.
5. Copy the generated token. **Treat it as a secret** — it grants live edit access.

## 2. Pick a Credential Source

| Option | When to use | What you provide |
|--------|-------------|------------------|
| **A. Env var (recommended)** | Production, container, Infisical-injected | `CLOUDFLARE_API_TOKEN` (and optionally `CLOUDFLARE_ACCOUNT_ID`) |
| **B. Compatibility file in `local/`** | Local dev only when env injection is not available | A token file under `local/config/` |

## Option A — Env var (recommended)

```bash
export NIMBUS_SECRETS_BACKEND=env
export CLOUDFLARE_API_TOKEN=...
export CLOUDFLARE_ACCOUNT_ID=...   # optional; Nimbus can discover it
```

Register without `--credentials`:

```bash
nimbus providers add --id my-cloudflare --type cloudflare --name "My Cloudflare Account"
```

## Option B — Compatibility file

```bash
cp templates/provider-cloudflare.template local/config/cloudflare-api-token
```

Replace the placeholder in `local/config/cloudflare-api-token` with your API
token (single line, no quotes), then register with the file:

```bash
nimbus providers add \
  --id my-cloudflare \
  --type cloudflare \
  --name "My Cloudflare Account" \
  --credentials local/config/cloudflare-api-token
```

## Register via API (alternative)

```
POST /api/providers
{
  "id": "my-cloudflare",
  "provider_type": "cloudflare",
  "display_name": "My Cloudflare Account"
}
```

## 6. Verify

```bash
nimbus providers list --format json
curl http://localhost:8000/api/providers/my-cloudflare/credential-status
```

A successful credential check returns `status: valid`.

## Supported Operations

Nimbus uses the Cloudflare adapter primarily for DNS management:

- **List zones** -- enumerate domains under your account
- **List DNS records** -- query A, AAAA, CNAME, TXT, and other record types
- **Create/update/delete records** -- manage DNS entries for your infrastructure
- **Collision detection** -- before creating a record, Nimbus checks for existing
  subdomains to prevent accidental overwrites
- **Tunnel lifecycle** -- create, list, and delete Cloudflare Tunnels
- **Tunnel routing** -- manage ingress routes and DNS CNAMEs for tunnel endpoints

## Notes

- Use **scoped API tokens** (not Global API Keys) for least-privilege access.
- Tokens can be restricted to specific zones, so create separate tokens per domain
  if you prefer granular control.
- Cloudflare has no associated compute costs, so `get_spending()` returns `0.0`.

:::info[Official Documentation]
[Cloudflare API Reference](https://developers.cloudflare.com/api/)
| [API Token Guide](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/)
:::
