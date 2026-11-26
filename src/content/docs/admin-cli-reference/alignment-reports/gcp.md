# CLI Docs Alignment Report — GCP

| Field | Value |
|-------|-------|
| **Provider** | GCP (`gcloud`) |
| **Last reviewed** | 2026-07-24T17:36:00Z |
| **Reviewed at commit** | `a440190` fix(gcloud): align gcloud storage CLI ref with official docs |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 43 total, 43 with refs, 0 skipped |
| **SDK dependency** | `google-auth>=2.63`, `google-cloud-compute>=1.55`, `google-api-python-client>=2.199`, `google-cloud-storage>=3.12`, `google-cloud-container>=2.65` (+ transitive floors `grpcio>=1.83`, `httplib2>=0.32`, `pyasn1>=0.6.5`); `google-cloud-billing` dropped (never imported, GAP-032) — see API currency |
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

| Package | Floor | Locked | Status |
|---------|-------|--------|--------|
| `google-auth` | `>=2.63` | 2.63.1 | current |
| `google-cloud-compute` | `>=1.55` | 1.58.0 | current (partial-success aggregated_list adopted) |
| `google-api-python-client` | `>=2.199` | 2.202.0 | current |
| `google-cloud-storage` | `>=3.12` | 3.17.2 | current |
| `google-cloud-container` | `>=2.65` | 2.67.0 | current |
| `google-api-core` (transitive) | - | 2.44.0 | current |
| `grpcio` (transitive) | `>=1.83` | 1.85.4 | current |
| `protobuf` (transitive) | - | 7.36.2 | current |
| `httplib2` (transitive) | `>=0.32` | 0.32.1 | current |
| `pyasn1` (transitive) | `>=0.6.5` | 0.6.5 | current |
| `google-cloud-billing` | - | - | removed (#462) |

## API currency

| Field | Value |
|-------|-------|
| **Reviewed** | 2026-11-25 by update-provider-apis (#456 research, #462 execution) |
| **Locked -> latest** | google-auth 2.49.1 -> 2.63.1; google-cloud-compute 1.46.0 -> 1.58.0; google-api-python-client 2.197.0 -> 2.202.0; google-cloud-storage 3.12.0 -> 3.17.2; google-cloud-container 2.65.0 -> 2.67.0; google-api-core 2.30.0 -> 2.44.0; grpcio 1.78.0 -> 1.85.4; grpcio-status 1.78.0 -> 1.85.4; protobuf 6.33.6 -> 7.36.2; proto-plus 1.27.2 -> 1.29.0; googleapis-common-protos 1.73.1 -> 1.76.0; google-cloud-core 2.6.0 -> 2.8.0; google-resumable-media 2.10.0 -> 2.11.0; google-crc32c 1.8.0 -> 1.9.0; google-auth-httplib2 0.4.0 -> 0.4.4; httplib2 0.31.2 -> 0.32.1; pyasn1 0.6.3 -> 0.6.5; opentelemetry-api added 1.45.2; google-cloud-billing 1.18.0 and grpc-google-iam-v1 0.14.3 removed |
| **Changelog range reviewed** | the locked -> latest ranges above (sources: https://github.com/googleapis/google-cloud-python/blob/main/packages/<package>/CHANGELOG.md for google-auth, google-api-core, google-cloud-compute, google-cloud-storage, google-cloud-container, google-cloud-billing; https://github.com/googleapis/google-api-python-client/blob/main/CHANGELOG.md; sqladmin.v1.json revision 20261018); the compute, container and PQC claims were rechecked in the installed wheels |
| **Advisories** | httplib2 GHSA-j5g9-f88f-gfj3 / PYSEC-2026-3444 (fixed 0.32.0); pyasn1 GHSA-8ppf-4f7h-5ppj, GHSA-hm4w-wwcw-mr6r, GHSA-m4p7-r5rc-7g4j (fixed 0.6.4) and GHSA-2qm8-x737-gmw5, GHSA-9m75-vc3g-4x39, GHSA-fm9c-5rcf-2q5p, GHSA-mm57-4v3p-rchx (fixed 0.6.5): all cleared by #462; pip-audit with the gcp extra is clean for this provider |
| **Findings** | SECURITY: httplib2/pyasn1 relocked (#462). DEPRECATED: grpcio < 1.83 FutureWarning from google-auth/api-core, enforced April 2027; grpcio 1.85.4 (#462). DEPRECATED: Cluster.initial_node_count/node_config/current_node_count; create_cluster sends an explicit 'default-pool' node pool, node_count from pools (#462). CHANGED: compute 1.55 aggregated_list is always partial-success and return_partial_success is removed; nimbus logs unreachable scopes and names them in the instance-not-found error, gcp/aggregated.py (#462). CHANGED: protobuf 6 -> 7 and new opentelemetry-api, transitive, proven by real-SDK tests on 3.12 and 3.14 (#462). NONE: sqladmin v1 methods and body fields, storage sync JSON-API methods, from_service_account_file |
| **Live-only, not yet proven** | service-account token minting / regional access boundary; real partial results with an unreachable zone; GKE gRPC with grpcio 1.85; pool-based node_count vs current_node_count on real clusters; GCS create_bucket with uniform access (owner-run F462-01..04); GKE create_cluster with the explicit pool and Cloud SQL insert/patch acceptance (billed, not scripted) |

Note: CI and the engine image still do not install the gcp extra (#465), so CI skips the real-SDK tests (test_sdk_*_wire.py, TestRealPagerShape). Run `cd engine && uv run --extra gcp --extra dev pytest nimbus/providers/gcp -q -W error::FutureWarning` locally.
