# CLI Docs Alignment Report — OCI

| Field | Value |
|-------|-------|
| **Provider** | OCI (Oracle Cloud Infrastructure) |
| **Last reviewed** | 2026-07-24T22:06:00Z |
| **Reviewed at commit** | `96c4df1` chore(oci): add inline reference links to all OCI operation descriptors |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 98 total, 79 with refs, 19 skipped (nimbus-internal) |
| **SDK dependency** | `oci>=2.193` — locked `2.193.0` — latest `2.193.0` (2026-11-24) — ✅ current (corrected 2026-11-25, #457: the July row compared the floor pin; see Dependency Status) |
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

Corrected 2026-11-25 (#457). The July verdict ("installed 2.168.3, latest
2.182.1, current") was wrong: it compared the floor pin in `engine/pyproject.toml`
(`oci>=2.100`), not the version locked in `engine/uv.lock`. The lock held 2.168.3,
14 weekly releases behind 2.182.1, and 2.168.3 caps `cryptography` below 47 and
`pyOpenSSL` at 25.3.0 or lower. That cap held six advisories open, each carried as
a dated `pip-audit` ignore in `.woodpecker/engine.yml` (tracking issue #298):

| Package | Locked (July) | Advisories | Fixed in |
|---------|---------------|------------|----------|
| `cryptography` | `46.0.7` | GHSA-537c-gmf6-5ccf | `48.0.1` |
| `cryptography` | `46.0.7` | CVE-2026-69248, CVE-2026-69249 | `49.0.0` |
| `cryptography` | `46.0.7` | CVE-2026-69247 | `50.0.0` |
| `pyOpenSSL` | `25.3.0` | CVE-2026-27448, CVE-2026-27459 | `26.0.0` |

The three cryptography CVEs were ignored in CI under their PyPI advisory ids
PYSEC-2026-3552, PYSEC-2026-3553 and PYSEC-2026-3554. `oci` 2.185.0 is the first
release with the lifted ranges (`pyOpenSSL>=26.2.0,<27`, `cryptography` below 51).
#457 raised the floor and re-locked `oci` and what it pulls in; the six ignores
are removed and `pip-audit` passes without them.

| Package | Pinned Min | Locked | Latest | Status |
|---------|-----------|--------|--------|--------|
| `oci` | `>=2.193` | `2.193.0` | `2.193.0` (2026-11-24) | ✅ current |
| `cryptography` (via `oci`) | — | `50.0.2` | `50.0.2` | ✅ advisories fixed |
| `pyOpenSSL` (via `oci`) | — | `26.4.0` | `26.4.0` | ✅ advisories fixed |

The bump brings new runtime packages: `aiohttp` (with its helper packages),
`crc32c` and `python-pkcs11`. The last two are C extensions that ship cp312 and
cp314 wheels. No breaking SDK change between 2.168.3 and 2.193.0 touches a call
nimbus makes. Future reviews compare the version **locked** in `engine/uv.lock`,
never the floor pin.
