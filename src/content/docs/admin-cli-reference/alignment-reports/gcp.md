# CLI Docs Alignment Report — GCP

| Field | Value |
|-------|-------|
| **Provider** | GCP (`gcloud`) |
| **Last reviewed** | 2026-07-24T17:36:00Z |
| **Reviewed at commit** | `a440190` fix(gcloud): align gcloud storage CLI ref with official docs |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 43 total, 43 with refs, 0 skipped |
| **SDK dependency** | `google-cloud-compute>=1.19`, `google-cloud-storage>=2.18`, `google-cloud-container>=2.49`, `google-cloud-billing>=1.14`, `google-api-python-client>=2.100` — all current |
| **Gaps found** | 1 — `gcloud storage` used legacy `objects list` instead of unified `ls`; fixed |
| **PR** | #332 |

## Reference Coverage

All `gcloud_*.py` operation descriptors reference official `cloud.google.com/sdk/gcloud/reference/` URLs.

| Op File | Ops | Status |
|---------|-----|--------|
| `gcloud_compute.py` | 7 | ✅ aligned |
| `gcloud_container.py` | 7 | ✅ aligned |
| `gcloud_disks.py` | 4 | ✅ aligned |
| `gcloud_firewall.py` | 5 | ✅ aligned |
| `gcloud_network.py` | 7 | ✅ aligned |
| `gcloud_sql.py` | 8 | ✅ aligned |
| `gcloud_storage.py` | 5 | ✅ aligned |

## Dependency Status

| Package | Pinned Min | Status |
|---------|-----------|--------|
| `google-cloud-compute` | `>=1.19` | ✅ current |
| `google-cloud-storage` | `>=2.18` | ✅ current |
| `google-cloud-container` | `>=2.49` | ✅ current |
| `google-cloud-billing` | `>=1.14` | ✅ current |
| `google-api-python-client` | `>=2.100` | ✅ current |
