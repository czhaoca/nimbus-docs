# CLI Docs Alignment Report — Azure

| Field | Value |
|-------|-------|
| **Provider** | Azure (`az`) |
| **Last reviewed** | 2026-07-24T16:05:00Z |
| **Reviewed at commit** | *(pending commit)* |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 63 total, 63 with refs, 0 skipped |
| **SDK dependency** | Multiple `azure-mgmt-*` packages plus `azure-identity` and `azure-storage-blob` (`azure` extra), all current after #461; `azure-mgmt-resource` dropped (never imported). See Dependency Status and API currency |
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

| Package | Pinned Min | Locked | Latest | Status |
|---------|-----------|--------|--------|--------|
| `azure-identity` | `>=1.27` | `1.27.0` | `1.27.0` | ✅ current |
| `azure-mgmt-compute` | `>=39.0` | `39.0.0` | `39.0.0` | ✅ current |
| `azure-mgmt-containerinstance` | `>=11.0` | `11.0.0` | `11.0.0` | ✅ current (hybrid models) |
| `azure-mgmt-containerregistry` | `>=15.0` | `15.0.0` | `15.0.0` | ✅ current |
| `azure-mgmt-costmanagement` | `>=5.0` | `5.0.0` | `5.0.0` | ✅ current |
| `azure-mgmt-network` | `>=33.1` | `33.1.0` | `33.1.0` | ✅ current |
| `azure-mgmt-sql` | `>=4.0` | `4.0.0` | `4.0.0` | ✅ current |
| `azure-mgmt-storage` | `>=25.3` | `25.3.0` | `25.3.0` | ✅ current |
| `azure-storage-blob` | `>=12.31.1,<12.32` | `12.31.1` | `12.31.1` (12.32.0b1 beta) | ✅ current |
| `azure-mgmt-resource` | removed | - | `26.0.0` | removed: never imported (#461) |

## API currency

| Field | Value |
|-------|-------|
| **Reviewed** | 2026-11-25 by update-provider-apis (research #456, work order #461) |
| **Locked -> latest** | azure-identity 1.25.3 -> 1.27.0 (now locked); azure-core 1.39.0 (latest 1.41.0, not required, unchanged); msal 1.35.1 -> 1.39.0 (pulled in by identity 1.27); azure-mgmt-compute 38.2.0 -> 39.0.0; azure-mgmt-network 31.0.1 -> 33.1.0; azure-mgmt-storage 25.1.0 -> 25.3.0; azure-storage-blob 12.30.0 -> 12.31.1 (12.32.0b1 is a beta, not taken; capped `<12.32` until the 12.32 line is reviewed); azure-mgmt-containerinstance 10.1.0 -> 11.0.0; azure-mgmt-sql 4.0.0 (latest); azure-mgmt-containerregistry 15.0.0 (latest); azure-mgmt-costmanagement 5.0.0 (latest); azure-mgmt-core 1.6.0 (latest); azure-mgmt-resource 26.0.0 removed (never imported); azure-common 1.1.28 removed (only containerinstance 10.1 needed it) |
| **Default api-versions now sent** | network 2026-03-01; compute 2026-04-01 (VMs), 2026-03-02 (disks), 2021-07-01 (Resource SKUs); storage 2026-09-01; containerinstance 2026-07-01; sql 2025-01-01; containerregistry 2025-11-01; costmanagement 2025-03-01 |
| **Changelog range reviewed** | each package from its locked version to latest (sources: `https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/<service>/<package>/CHANGELOG.md`, PyPI release histories, `https://github.com/Azure/azure-sdk-for-python/blob/main/doc/dev/mgmt/hybrid_model_migration.md`, `https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/default-outbound-access`, `https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-basic-upgrade-guidance`, `https://learn.microsoft.com/en-us/rest/api/compute/virtual-machine-sizes/list`) |
| **Advisories** | none in any Azure package (pip-audit over the exported azure extra, 2026-11-25); the core-dependency hits that run listed were cleared on main by #457 (cryptography, pyOpenSSL) and #466 (paramiko removed) |
| **Findings** | BREAKING (fixed, #461): `list_keys(...).keys` is `keys_property` in hybrid storage models, so every blob op raised TypeError. BREAKING (fixed, #461): the hybrid-model SDKs (network 31+, compute 38+, containerregistry 15, costmanagement 5, containerinstance 11) json-dump a dict body verbatim; nimbus sent snake_case flattened keys, so ARM got none of the intended properties for vnet, subnet, NSG rule, public IP, VM create, disk create, VM data-disk attach, ACR admin user and the cost query (`timePeriod`/`from`). All bodies are now REST wire shape, checked against the SDK's own typed models. CHANGED (fixed, #461): public IPs default to Standard / Static (Basic retired 2025-09-30), and an explicit Basic SKU is refused before any call. CHANGED (fixed, #461): subnets nimbus creates set `defaultOutboundAccess` explicitly (true, the earlier behaviour), because the API released after 2026-03-31 makes new subnets private by default. DEPRECATED (fixed, #461): `az vm list-sizes` reads Resource SKUs instead of `virtual_machine_sizes.list`. NONE: SQL bodies were already wire shape. Open: the VM create op still sends no image, NIC or admin profile (the adapter accepts them from provision config; the op does not expose them), so it cannot create a VM end to end; not an SDK-currency defect, follow-up needed. Open: the azure extra is not installed in CI or the engine image (#465), so these wire-shape tests skip there. |
| **Offline proof** | real management clients, a fake TokenCredential and the SDK's RequestsTransport with a recording adapter (`engine/nimbus/providers/azure/tests/_wire.py`); `test_wire_network.py`, `test_wire_compute.py`, `test_wire_services.py`; run with `uv run --extra azure --extra dev pytest nimbus/providers/azure/tests` on 3.12, 3.14 and in python:3.14-slim |
| **Live-only, not yet proven** | ARM accepting the corrected bodies end to end; whether ARM rejected or ignored the old snake_case bodies and a no-SKU public IP; Cost Management result format and permission on the subscription; the private-subnet default on new VNets at api 2026-03-01; ACI 11 (api 2026-07-01) group creation; blob access with the key from list_keys. Owner-run handoff F461 (probe read-only first); all wait until an Azure account is onboarded in the store. |
