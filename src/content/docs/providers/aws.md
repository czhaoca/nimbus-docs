---
title: "AWS"
sidebar:
  order: 2
---

# AWS Provider Setup

Nimbus authenticates to AWS through the `boto3` credentials chain. Three
sources are supported, in order of preference: SSO via IAM Identity Center,
long-lived IAM keys (compatibility), and the boto3 default chain (env vars,
instance role).

## Prerequisites

- An AWS account
- AWS CLI v2 installed (`aws --version`) — required for SSO setup
- `boto3` installed: `cd engine && uv pip install -e ".[aws]"`
- The Nimbus engine running

## 1. Pick a Credential Source

| Option | When to use | What you provide |
|--------|-------------|------------------|
| **A. SSO / IAM Identity Center (recommended)** | Modern AWS organizations with Identity Center; short-lived tokens | An `~/.aws/config` profile with `sso_session` and a Nimbus INI that points at it |
| **B. Long-lived IAM keys (compatibility)** | Standalone AWS accounts without Identity Center, or legacy setups | `aws_access_key_id` + `aws_secret_access_key` in INI (or env vars) |
| **C. Default chain** | Nimbus running on EC2/ECS with an instance role, or with `AWS_PROFILE` env var pre-set | Nothing — boto3 walks the chain |

Sections below detail each option.

## Option A — SSO / IAM Identity Center (recommended)

In **AWS IAM Identity Center**, assign your user to the target account with
the appropriate permission set (typically `AdministratorAccess` for setup or
a least-privilege custom set for ongoing use).

Configure a local profile via the AWS CLI:

```bash
aws configure sso
```

Answer the prompts (SSO start URL, region, account, role, profile name —
e.g. `nimbus-prod`). The CLI writes a `[profile nimbus-prod]` block to
`~/.aws/config` with `sso_session` settings.

Sign in once per session:

```bash
aws sso login --profile nimbus-prod
```

Then point Nimbus at the profile via INI:

```bash
cp templates/provider-aws.template local/config/provider-aws.ini
```

Edit `local/config/provider-aws.ini`:

```ini
[default]
profile_name = nimbus-prod
region = us-east-1          # optional; profile default applies if blank
```

Register with the file path:

```bash
nimbus providers add \
  --id my-aws \
  --type aws \
  --name "My AWS Account" \
  --credentials local/config/provider-aws.ini
```

boto3 owns SSO token refresh while the SSO session is valid. When the session
expires, run `aws sso login --profile nimbus-prod` again.

## Option B — Long-lived IAM Keys (compatibility)

Use this only when SSO/Identity Center is not available. Open the
[IAM Console](https://console.aws.amazon.com/iam/), create an IAM user with
**programmatic access**, attach a policy granting at minimum `ec2:*` and
`ce:GetCostAndUsage`, and save the **Access Key ID** and **Secret Access
Key**.

You can inject the keys at runtime via env vars:

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_REGION=us-east-1
```

Then register without `--credentials`:

```bash
nimbus providers add --id my-aws --type aws --name "My AWS Account"
```

Or use the compatibility INI:

```ini
[default]
aws_access_key_id = {your-access-key-id}
aws_secret_access_key = {your-secret-access-key}
region = {your-region}
```

```bash
nimbus providers add \
  --id my-aws \
  --type aws \
  --name "My AWS Account" \
  --credentials local/config/provider-aws.ini
```

For least-privilege setups, scope the IAM policy to specific regions or
resource types.

## Option C — Default Chain

When Nimbus runs inside AWS (EC2, ECS, EKS) with an instance/task role, or
when `AWS_PROFILE` is already set in the environment, register without any
credentials:

```bash
nimbus providers add --id my-aws --type aws --name "My AWS Account"
```

boto3 will resolve credentials in this order: env vars → shared config
profile (`AWS_PROFILE`) → container role → EC2 instance metadata.

## Register via API (alternative)

```
POST /api/providers
{
  "id": "my-aws",
  "provider_type": "aws",
  "display_name": "My AWS Account",
  "region": "{your-region}"
}
```

## 6. Verify

```bash
# List registered providers
nimbus providers list --format json
curl http://localhost:8000/api/providers/my-aws/credential-status
```

A successful credential check returns `status: valid`.

## Provider CLI Baseline

Nimbus now mounts an AWS-specific CLI through provider discovery:

```bash
nimbus aws context set my-aws
nimbus aws context show
nimbus aws instance list
nimbus aws instance get i-0123456789abcdef0
nimbus aws cost current --period 2026-04
nimbus aws freetier show
nimbus aws instance create --provider my-aws --image-id ami-12345678
nimbus aws instance stop --provider my-aws --id i-0123456789abcdef0
nimbus aws instance terminate --provider my-aws --id i-0123456789abcdef0 --force
```

This CLI mirrors the current MVP adapter contract. Richer EC2 workflows are still pending.

Nimbus also ships an AWS free-tier spec for policy and visibility work. Use `nimbus aws freetier show -f json` to inspect the normalized limits. It tracks the current credits-based program for newer accounts and notes the legacy pre-July-15-2025 path separately.

## Cost Explorer

AWS Cost Explorer charges **$0.01 per API request**. Nimbus caches results for 1 hour
to minimize cost. By default, billing queries are disabled. To enable:

Set `billing_enabled=True` in the `[default]` section of your credentials file.

## Notes

- Nimbus distinguishes between `stop` (halts compute, retains EBS) and `terminate`
  (destroys instance and root volume). Budget enforcement uses the action configured
  in your alert rules.
- Multiple AWS profiles are supported — add additional `[profile-name]` sections
  to the credentials file and pass `--profile` to `nimbus providers add` (or
  reference different `~/.aws/config` profiles via `profile_name` per section).

:::info[Official Documentation]
[boto3 SDK Reference](https://boto3.amazonaws.com/v1/documentation/api/latest/)
| [boto3 Credentials](https://boto3.amazonaws.com/v1/documentation/api/latest/guide/credentials.html)
| [IAM Identity Center (SSO)](https://docs.aws.amazon.com/sdkref/latest/guide/access-sso.html)
| [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
:::
