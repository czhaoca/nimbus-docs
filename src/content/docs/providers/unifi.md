---
title: "UniFi"
sidebar:
  order: 7
---

# UniFi Provider Setup

Nimbus authenticates to a UniFi OS controller using either an API key or a
local admin session. **Recommended**: inject numbered `UNIFI_*` env vars at
runtime via Infisical or your container orchestrator. **Compatibility**: use
a key=value file under `local/config/`.

## Prerequisites

- A UniFi OS device (UDM, UDR, UCG, or self-hosted controller)
- A local admin account or scoped API key
- The Nimbus engine running (no extra SDK required — uses Python stdlib)

## 1. Prepare Controller Credentials

Nimbus supports two auth modes against the same UniFi controller URL:

- Bearer API key: `UNIFI_API_KEY`
- Session login: `UNIFI_USERNAME` + `UNIFI_PASSWORD`

You still need the controller URL and usually the site name (`default` unless
you have multiple sites). API key is preferred for least-privilege; session
login works as a fallback for older firmware that does not expose an API key.

## 2. Pick a Credential Source

| Option | When to use | What you provide |
|--------|-------------|------------------|
| **A. Numbered env vars (recommended)** | Production, container, Infisical-injected. Multiple controllers via `UNIFI_1_*`, `UNIFI_2_*`, etc. | URL, API key (or username/password), site, verify_ssl |
| **B. Compatibility file in `local/`** | Local dev only when env injection is not available | A key=value file referenced via `--credentials` |

## Option A — Numbered env vars (recommended)

```bash
export NIMBUS_SECRETS_BACKEND=env
export INFISICAL_SECRET_PATHS=/common,/nimbus
export UNIFI_1_URL=https://controller.example
export UNIFI_1_API_KEY=...
export UNIFI_1_SITE=default
export UNIFI_1_VERIFY_SSL=true
```

Cookie-session alternative (older firmware):

```bash
export UNIFI_1_URL=https://controller.example
export UNIFI_1_USERNAME=nimbus
export UNIFI_1_PASSWORD=...
export UNIFI_1_SITE=default
export UNIFI_1_VERIFY_SSL=true
```

Register with the matching `--instance-index` and **without** `--credentials`:

```bash
nimbus providers add \
  --id my-unifi \
  --type unifi \
  --name "My UniFi Controller" \
  --instance-index 1
```

To run multiple UniFi controllers, define `UNIFI_2_*`, `UNIFI_3_*`, etc.

## Option B — Compatibility file

```bash
cp templates/provider-unifi.template local/config/provider-unifi
```

Open `local/config/provider-unifi` and fill in:

```
UNIFI_URL=https://{your-controller-host}
UNIFI_API_KEY={your-api-key}
UNIFI_SITE=default
UNIFI_VERIFY_SSL=false
```

Or the cookie-session alternative:

```
UNIFI_URL=https://{your-controller-host}
UNIFI_USERNAME={your-admin-username}
UNIFI_PASSWORD={your-admin-password}
UNIFI_SITE=default
UNIFI_VERIFY_SSL=false
```

Set `UNIFI_VERIFY_SSL=true` if your controller has a valid SSL certificate.

Register with the file path:

```bash
nimbus providers add \
  --id my-unifi \
  --type unifi \
  --name "My UniFi Controller" \
  --instance-index 1 \
  --credentials local/config/provider-unifi
```

## Register via API (alternative)

```
POST /api/providers
{
  "id": "my-unifi",
  "provider_type": "unifi",
  "display_name": "My UniFi Controller",
  "instance_index": 1
}
```

## 4. Verify And Set Active Context

```bash
nimbus providers list --format json
nimbus unifi context set my-unifi
nimbus unifi context show
curl http://localhost:8000/api/providers/my-unifi/credential-status
```

## Network Management (UniFiNetworkMixin)

The UniFi adapter includes `UniFiNetworkMixin`, which provides:

### VLANs

- **`list_vlans()`** -- list all VLAN-enabled network configurations
- **`create_vlan(name, vlan_id, subnet, dhcp_enabled)`** -- create a new VLAN
- **`delete_vlan(vlan_config_id)`** -- remove a VLAN configuration

### Port Profiles

- **`list_port_profiles()`** -- list switch port profiles
- **`create_port_profile(name, native_vlan)`** -- create a port profile
- **`set_port_profile(device_mac, port_idx, profile_id)`** -- assign a profile to a switch port

### Firewall Rules

- **`list_firewall_rules()`** -- list zone-based firewall rules
- **`create_firewall_rule(name, action, ruleset, ...)`** -- create inter-VLAN firewall rules
- **`delete_firewall_rule(rule_id)`** -- remove a firewall rule

Common rulesets: `LAN_IN`, `LAN_OUT`, `LAN_LOCAL`, `GUEST_IN`, `GUEST_OUT`.
Actions: `accept`, `drop`, `reject`.

## Implementation Notes

- The adapter uses **Python stdlib** (`urllib.request` + `http.cookiejar`) with no
  third-party SDK dependency. This keeps the dependency footprint minimal.
- Authentication uses bearer-token auth when `UNIFI_API_KEY` is present; otherwise
  it falls back to cookie-based sessions against the controller's local API.
- The UniFi API is community-documented and may change between firmware versions.

:::info[Community Documentation]
[UniFi API Wiki](https://ubntwiki.com/products/software/unifi-controller/api)
| [UniFi OS API Browser](https://unifi.ui.com/)
:::
