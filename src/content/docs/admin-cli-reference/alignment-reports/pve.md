# CLI Docs Alignment Report — Proxmox

| Field | Value |
|-------|-------|
| **Provider** | Proxmox (`pve`) |
| **Last reviewed** | 2026-07-24T16:05:00Z |
| **Reviewed at commit** | *(pending commit)* |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 23 total, 23 with refs, 0 skipped |
| **SDK dependency** | N/A (REST API) |
| **Gaps found** | 0 |
| **PR** | *(pending)* |

## Reference Coverage

All `pve_*.py` operation descriptors now reference official `pve.proxmox.com/pve-docs/api-viewer` URLs.

| Op File | Ops | Status |
|---------|-----|--------|
| `pve_lxc.py` | 11 | ✅ aligned |
| `pve_network.py` | 2 | ✅ aligned |
| `pve_node.py` | 2 | ✅ aligned |
| `pve_storage.py` | 2 | ✅ aligned |
| `pve_vm.py` | 6 | ✅ aligned |

## Dependency Status

*(Skipped for Proxmox as it uses raw REST API requests without a Python SDK extra.)*
