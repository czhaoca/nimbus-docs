# CLI Docs Alignment Report — Azure

| Field | Value |
|-------|-------|
| **Provider** | Azure (`az`) |
| **Last reviewed** | 2026-07-24T16:05:00Z |
| **Reviewed at commit** | *(pending commit)* |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 63 total, 63 with refs, 0 skipped |
| **SDK dependency** | Multiple `azure-mgmt-*` packages. **Several are stale** (e.g. `azure-mgmt-containerregistry` >=10.3 vs latest 15.0.0; `azure-mgmt-compute` >=33.0 vs latest 38.2.0; `azure-mgmt-network` >=28.0 vs latest 31.0.1; `azure-mgmt-resource` >=23.0 vs latest 26.0.0; `azure-mgmt-storage` >=21.0 vs latest 25.1.0). Flagged for PR description. |
| **Gaps found** | 0 — ops aligned with grammar |
| **PR** | *(pending)* |

## Reference Coverage

All `az_*.py` operation descriptors now reference official `learn.microsoft.com/en-us/cli/azure/` URLs.

| Op File | Ops | Status |
|---------|-----|--------|
| `az_acr.py` | 5 | ✅ aligned |
| `az_container.py` | 5 | ✅ aligned |
| `az_context.py` | 3 | ✅ aligned |
| `az_cost.py` | 1 | ✅ aligned |
| `az_disk.py` | 3 | ✅ aligned |
| `az_network_nsg.py` | 6 | ✅ aligned |
| `az_network_publicip.py` | 3 | ✅ aligned |
| `az_network_vnet.py` | 7 | ✅ aligned |
| `az_sql.py` | 10 | ✅ aligned |
| `az_storage.py` | 10 | ✅ aligned |
| `az_vm.py` | 10 | ✅ aligned |

## Dependency Status

| Package | Pinned Min | Latest | Status |
|---------|-----------|--------|--------|
| `azure-identity` | `>=1.17` | `1.25.3` | ✅ current |
| `azure-mgmt-compute` | `>=33.0` | `38.2.0` | ⚠️ stale (33.0 -> 38.2.0) |
| `azure-mgmt-containerinstance` | `>=10.1` | `10.1.0` | ✅ current |
| `azure-mgmt-containerregistry` | `>=10.3` | `15.0.0` | ⚠️ stale (10.3 -> 15.0.0) |
| `azure-mgmt-costmanagement` | `>=4.0` | `5.0.0` | ⚠️ stale (4.0 -> 5.0.0) |
| `azure-mgmt-network` | `>=28.0` | `31.0.1` | ⚠️ stale (28.0 -> 31.0.1) |
| `azure-mgmt-resource` | `>=23.0` | `26.0.0` | ⚠️ stale (23.0 -> 26.0.0) |
| `azure-mgmt-sql` | `>=4.0.0b25` | `4.0.0` | ✅ current |
| `azure-mgmt-storage` | `>=21.0` | `25.1.0` | ⚠️ stale (21.0 -> 25.1.0) |
| `azure-storage-blob` | `>=12.20` | `12.30.0` | ✅ current |
