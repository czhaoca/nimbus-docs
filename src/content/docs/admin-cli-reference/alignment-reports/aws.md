# CLI Docs Alignment Report — AWS

| Field | Value |
|-------|-------|
| **Provider** | AWS (`boto3`) |
| **Last reviewed** | 2026-07-24T21:37:00Z |
| **Reviewed at commit** | `34b8e49` chore(cli-docs): align aws implementation with official docs |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 62 total, 49 with refs, 13 skipped (deprecated `aws instance` grammar + internal) |
| **SDK dependency** | `boto3>=1.35` — latest `1.43.55` — ✅ current (same major) |
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

| Package | Pinned Min | Latest | Status |
|---------|-----------|--------|--------|
| `boto3` | `>=1.35` | `1.43.55` | ✅ current |
