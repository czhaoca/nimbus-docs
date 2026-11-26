# CLI Docs Alignment Report — AWS

| Field | Value |
|-------|-------|
| **Provider** | AWS (`boto3`) |
| **Last reviewed** | 2026-07-24T21:37:00Z |
| **Reviewed at commit** | `34b8e49` chore(cli-docs): align aws implementation with official docs |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 62 total, 49 with refs, 13 skipped (deprecated `aws instance` grammar + internal) |
| **SDK dependency** | `boto3>=1.44` (`aws` extra) — locked `1.44.12` — latest `1.44.12` — ✅ current (#463) |
| **Gaps found** | 0 — all ops already matched official AWS CLI grammar |
| **PR** | #334 |

## Reference Coverage

All `aws_*.py` operation descriptors (excluding `aws_vm.py` deprecated alias and `aws_context.py`/`aws_cost.py` internal) reference official `docs.aws.amazon.com/cli/latest/reference/` URLs.

| Op File | Ops | Refs Added | Status |
|---------|-----|-----------|--------|
| `aws_ec2_igw.py` | 5 | 5 | ✅ aligned |
| `aws_ec2_image.py` | 1 | 1 | ✅ aligned |
| `aws_ec2_instance.py` | 6 | 6 | ✅ aligned |
| `aws_ec2_sg.py` | 5 | 5 | ✅ aligned |
| `aws_ec2_subnet.py` | 3 | 3 | ✅ aligned |
| `aws_ec2_volume.py` | 5 | 5 | ✅ aligned |
| `aws_ec2_vpc.py` | 3 | 3 | ✅ aligned |
| `aws_ecr.py` | 3 | 3 | ✅ aligned |
| `aws_ecs.py` | 8 | 8 | ✅ aligned |
| `aws_rds.py` | 8 | 8 | ✅ aligned |
| `aws_s3.py` | 2 | 2 | ✅ aligned |
| `aws_vm.py` | 5 | 0 | ⚠️ deprecated alias — skipped |
| `aws_context.py` | 3 | 0 | — internal |
| `aws_cost.py` | 1 | 0 | — internal |

## Dependency Status

| Package | Pinned Min | Locked | Latest | Status |
|---------|-----------|--------|--------|--------|
| `boto3` | `>=1.44` | `1.44.12` | `1.44.12` | ✅ current |
| `botocore` | transitive (boto3 1.44.12 requires `>=1.44.12,<1.45.0`) | `1.44.12` | `1.44.12` | ✅ current |
| `s3transfer` | transitive (boto3 1.44.12 requires `>=0.19.0,<0.20.0`) | `0.19.3` | `0.19.3` | ✅ current |

## API currency

| Field | Value |
|-------|-------|
| **Reviewed** | 2026-11-25 by update-provider-apis (research #456, work order #463) |
| **Locked -> latest** | boto3 1.42.78 -> 1.44.12; botocore 1.42.78 -> 1.44.12; s3transfer 0.16.0 -> 0.19.3; jmespath 1.1.0, urllib3 2.8.0, python-dateutil 2.9.0.post0 unchanged |
| **Changelog range reviewed** | botocore 1.42.78 .. 1.44.12, s3transfer 0.16.0 .. 0.19.3 (sources: https://github.com/boto/botocore/blob/develop/CHANGELOG.rst, https://github.com/boto/s3transfer/blob/develop/CHANGELOG.rst, https://boto3.amazonaws.com/v1/documentation/api/latest/guide/retries.html); the 1.42.78 and 1.44.12 service models diffed for the 41 operations nimbus calls (top-level input and output members only) |
| **Advisories** | none for boto3, botocore, s3transfer, jmespath, urllib3 (pip-audit with `--extra aws`, 2026-11-25) |
| **Findings** | CHANGED: botocore 1.44.0 made the `standard` retry mode the default (3 attempts in total instead of 5, HTTP 429 retried as throttling, a retry quota; `AWS_NEW_RETRIES_2026` no longer read). nimbus passes no botocore Config, so this default now governs every AWS call; the `boto3>=1.44` floor makes it the same on every install; `test_sdk_retry_default.py` counts the attempts (#463). |
| | CHANGED (not applied): EC2 DescribeInstances / DescribeVolumes gained the optional `IncludeManagedResources`; with the account's managed-resource visibility set to hidden, nimbus inventory leaves out AWS-managed instances and volumes. Owner decision pending; the live probe compares the counts (#463 F463-01). |
| | NONE: no operation, member or required parameter nimbus uses was removed or added between the two models; ECS `inferenceAccelerators` newly deprecated (unused); ECR registry policy V1 removed (unused); STS GetCallerIdentity and Cost Explorer UnblendedCost unchanged; s3transfer upload_file / download_file unaffected. Guard: `test_wire_ec2.py`, `test_wire_services.py`, `test_wire_s3_transfer.py` validate every call against the installed model with botocore's Stubber (#463). |
| | Open: an explicit retry Config pin from one session helper (owner decision; not applied). Live-only, pending: SSO/profile resolution, real throttling timing, managed-resource visibility, region-specific CreateBucket, Cost Explorer amounts (F463 owner scripts). |
| **Shared pin** | httpx capped `<1.0` in the core and dev lists (1.0 is still `.dev` pre-releases; 0.28.1 locked, unchanged) (#463). |
| **Range for the next pass** | from botocore 1.44.12 / s3transfer 0.19.3 |
