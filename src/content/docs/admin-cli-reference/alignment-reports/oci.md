# CLI Docs Alignment Report — OCI

| Field | Value |
|-------|-------|
| **Provider** | OCI (Oracle Cloud Infrastructure) |
| **Last reviewed** | 2026-07-24T22:06:00Z |
| **Reviewed at commit** | `96c4df1` chore(oci): add inline reference links to all OCI operation descriptors |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 98 total, 79 with refs, 19 skipped (nimbus-internal) |
| **SDK dependency** | `oci>=2.100` — installed `2.168.3` — latest `2.182.1` — ✅ current |
| **Gaps found** | 0 — all ops already matched official OCI CLI grammar |
| **PR** | #336 |

## Reference Coverage

All ops with a direct OCI CLI equivalent now have `# Ref:` comments pointing to `docs.oracle.com/en-us/iaas/tools/oci-cli/latest/`.

| Op File | Ops | Refs Added | Status |
|---------|-----|-----------|--------|
| `oci_admin.py` | 3 | 3 | ✅ aligned |
| `oci_ce_cluster.py` | 3 | 3 | ✅ aligned |
| `oci_ce_node_pool.py` | 4 | 4 | ✅ aligned |
| `oci_compute.py` | 6 | 6 | ✅ aligned |
| `oci_container_instance.py` | 7 | 7 | ✅ aligned |
| `oci_db_adb.py` | 6 | 6 | ✅ aligned |
| `oci_db_mysql.py` | 6 | 6 | ✅ aligned |
| `oci_network_ip.py` | 4 | 4 | ✅ aligned |
| `oci_network_nsg.py` | 6 | 6 | ✅ aligned |
| `oci_network_seclist.py` | 6 | 6 | ✅ aligned |
| `oci_network_vcn.py` | 7 | 7 | ✅ aligned |
| `oci_objstore.py` | 7 | 7 | ✅ aligned |
| `oci_vm.py` | 7 | 5 | ✅ aligned (2 internal: health, reinstall) |
| `oci_vm_create.py` | 2 | 2 | ✅ aligned |
| `oci_volume.py` | 7 | 7 | ✅ aligned |
| `oci.py` | 2 | 0 | — internal (arm_status, vms) |
| `oci_actions.py` | 2 | 0 | — internal (provision, terminate-confirmed) |
| `oci_cost.py` | 2 | 0 | — internal (UsageapiClient) |
| `oci_freetier.py` | 1 | 0 | — internal |
| `oci_sync.py` | 1 | 0 | — internal |
| `oci_tenancy.py` | 9 | 0 | — internal (alias, context, prefs) |

## Dependency Status

| Package | Pinned Min | Installed | Latest | Status |
|---------|-----------|-----------|--------|--------|
| `oci` | `>=2.100` | `2.168.3` | `2.182.1` | ✅ current |
