---
title: "Proxmox"
sidebar:
  order: 6
---

# Proxmox Provider Setup

Nimbus authenticates to Proxmox VE via an API token. **Recommended**: inject
numbered Proxmox env vars (e.g. `PROXMOX_1_URL`, `PROXMOX_1_TOKEN_SECRET`) at
runtime via Infisical or your container orchestrator. **Compatibility**: use
a YAML config under `local/config/`.

## Prerequisites

- A Proxmox VE host with API access enabled
- The Nimbus engine running (no extra SDK required — uses Python stdlib)

## 1. Create an API Token

1. Log into the Proxmox web UI.
2. Navigate to **Datacenter > Permissions > API Tokens**.
3. Click **Add** and create a token:
   - **User**: `{your-user}@pam` (or `{your-user}@pve`)
   - **Token ID**: `nimbus`
   - **Privilege Separation**: uncheck to inherit user permissions
4. Copy the displayed **Token Secret** (shown only once). **Treat as a
   secret** — full root-equivalent API access.

## 2. Pick a Credential Source

| Option | When to use | What you provide |
|--------|-------------|------------------|
| **A. Numbered env vars (recommended)** | Production, container, Infisical-injected. Multiple Proxmox instances supported via `PROXMOX_1_*`, `PROXMOX_2_*`, etc. | URL, token ID, token secret, node, verify_ssl |
| **B. Compatibility YAML in `local/`** | Local dev only when env injection is not available | YAML file referencing a token file under `local/config/` |

## Option A — Numbered env vars (recommended)

```bash
export NIMBUS_SECRETS_BACKEND=env
export INFISICAL_SECRET_PATHS=/common,/nimbus
export PROXMOX_1_URL=https://{your-proxmox-host}:8006/api2/json
export PROXMOX_1_TOKEN_ID={your-user}@pve!nimbus
export PROXMOX_1_TOKEN_SECRET=...
export PROXMOX_1_NODE={your-node}
export PROXMOX_1_VERIFY_SSL=false
```

Recommended Infisical path for the numbered secret set:

- `/nimbus/providers/proxmox/1`

Register with the matching `--instance-index`:

```bash
nimbus providers add \
  --id my-proxmox \
  --type proxmox \
  --name "My Proxmox Server" \
  --instance-index 1
```

To run multiple Proxmox hosts, define `PROXMOX_2_*`, `PROXMOX_3_*`, etc. and
use `--instance-index 2`, `--instance-index 3`, etc.

## Option B — Compatibility YAML

```bash
echo "{your-token-secret}" > local/config/proxmox-token.txt
cp templates/provider-proxmox.template local/config/provider-proxmox.yaml
```

Open `local/config/provider-proxmox.yaml` and fill in:

```yaml
api_url: "https://{your-proxmox-host}:8006/api2/json"
auth:
  user: "{your-user}@pam"
  token_id: "nimbus"
  token_secret_path: "local/config/proxmox-token.txt"
verify_ssl: false          # set true if using valid SSL certs
default_node: "{your-node}"
default_storage: "local-lvm"
```

Register with the file path:

```bash
nimbus providers add \
  --id my-proxmox \
  --type proxmox \
  --name "My Proxmox Server" \
  --instance-index 1 \
  --credentials local/config/provider-proxmox.yaml
```

## Register via API (alternative)

```
POST /api/providers
{
  "id": "my-proxmox",
  "provider_type": "proxmox",
  "display_name": "My Proxmox Server",
  "instance_index": 1
}
```

## 5. Verify

```bash
nimbus providers list --format json
curl http://localhost:8000/api/providers/my-proxmox/credential-status
```

If you need to rotate the Proxmox token on the node, run:

```bash
./deploy/proxmox/reprovision-api-token.sh
```

## VLAN Management

The Proxmox adapter includes `ProxmoxVLANMixin`, which adds VLAN operations:

- **`get_vm_config(vmid)`** -- retrieve full VM configuration
- **`set_vm_vlan(vmid, vlan_id, nic="net0")`** -- tag a VM's NIC with a VLAN ID
- **`check_bridge_vlan_aware(bridge="vmbr0")`** -- verify the bridge supports VLAN trunking

### Tagging a VM

```bash
# Via the API
PUT /api/providers/my-proxmox/vlan
{
  "vmid": "100",
  "vlan_id": 50,
  "nic": "net0"
}
```

This sets `tag=50` on the VM's `net0` interface, isolating it on VLAN 50.

### Bridge Configuration

Ensure your Proxmox bridge has `bridge-vlan-aware yes` in `/etc/network/interfaces`
to support VLAN trunking from the physical switch.

## Notes

- Use **API tokens** (not root passwords) for authentication.
- Set `verify_ssl: false` only for self-signed certificates in lab environments.
- The adapter uses token-authenticated HTTPS requests via Python stdlib
  (`urllib.request`), so no extra Proxmox SDK package is required.
- Proxmox hosts Woodpecker LXC agents for governed CI/CD runner capacity.

:::info[Official Documentation]
[Proxmox VE API](https://pve.proxmox.com/pve-docs/api-viewer/)

[API Token Documentation](https://pve.proxmox.com/pve-docs/chapter-pveum.html#pveum_tokens)
:::
