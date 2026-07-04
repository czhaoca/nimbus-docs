---
title: "GCP"
sidebar:
  order: 4
---

# GCP Provider Setup

Nimbus authenticates to GCP via Application Default Credentials (ADC) backed
by a Service Account. **Recommended**: inject the Service Account JSON via
env var or Infisical. **Compatibility**: drop the JSON in `local/config/`.

## Prerequisites

- A GCP project with billing enabled
- `google-cloud-compute` and `google-cloud-billing` installed:
  `cd engine && uv pip install -e ".[gcp]"`
- The Nimbus engine running

## 1. Create a Service Account

1. Open the [IAM & Admin Console](https://console.cloud.google.com/iam-admin/serviceaccounts).
2. Click **Create Service Account**.
3. Assign roles: **Compute Admin** and **Billing Viewer** (minimum).
4. Under **Keys**, click **Add Key > Create New Key > JSON**.
5. Download the JSON key file. **Treat it as a secret** — do not commit it.

## 2. Pick a Credential Source

| Option | When to use | What you provide |
|--------|-------------|------------------|
| **A. Env var pointing at a runtime secret (recommended)** | Production, container, Infisical-injected | `GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json` |
| **B. Compatibility file in `local/`** | Local dev only when env injection is not available | A JSON file under `local/config/` referenced via `--credentials` |
| **C. Workload Identity / GCE metadata** | Nimbus running on GKE / GCE / Cloud Run | Nothing — ADC picks up the workload identity automatically |

## Option A — Env var (recommended)

Place the JSON outside the repo (Infisical mount, `~/.gcp/`, secret volume),
then point `GOOGLE_APPLICATION_CREDENTIALS` at it:

```bash
export NIMBUS_SECRETS_BACKEND=env
export GOOGLE_APPLICATION_CREDENTIALS=/secure/path/to/service-account.json
```

Register without `--credentials`:

```bash
nimbus providers add --id my-gcp --type gcp --name "My GCP Project"
```

## Option B — Compatibility file

Use this only when env injection is unavailable.

```bash
cp templates/provider-gcp.template local/config/gcp-service-account.json
```

Replace the placeholder fields in `local/config/gcp-service-account.json` with
the contents of the downloaded JSON key (`project_id`, `private_key_id`,
`private_key`, `client_email`, `client_id`).

```bash
nimbus providers add \
  --id my-gcp \
  --type gcp \
  --name "My GCP Project" \
  --credentials local/config/gcp-service-account.json
```

## Option C — Workload Identity (GKE / GCE / Cloud Run)

When Nimbus runs inside GCP with a workload identity attached, register
without any credentials:

```bash
nimbus providers add --id my-gcp --type gcp --name "My GCP Project"
```

ADC picks up the workload identity through the metadata server.

## Register via API (alternative)

```
POST /api/providers
{
  "id": "my-gcp",
  "provider_type": "gcp",
  "display_name": "My GCP Project",
  "region": "{your-region}"
}
```

## 6. Verify

```bash
nimbus providers list --format json
curl http://localhost:8000/api/providers/my-gcp/credential-status
```

A successful credential check returns `status: valid`.

## Provider CLI — gcloud-Mirrored Grammar

The GCP namespace mounts as `nimbus gcloud` and mirrors the gcloud CLI's
own grammar (implemented through the official Python SDK, never by shelling
out to the `gcloud` binary):

```bash
nimbus gcloud context set my-gcp
nimbus gcloud context show

nimbus gcloud compute instances create gce-1 \
  --zone us-central1-a \
  --machine-type e2-micro \
  --image-family debian-12 \
  --image-project debian-cloud \
  --provider my-gcp

nimbus gcloud compute instances list --zones us-central1-a
nimbus gcloud compute instances describe gce-1 --zone us-central1-a
nimbus gcloud compute instances start gce-1 --zone us-central1-a --provider my-gcp
nimbus gcloud compute instances stop gce-1 --zone us-central1-a --provider my-gcp
nimbus gcloud compute instances delete gce-1 --zone us-central1-a --quiet --provider my-gcp

nimbus gcloud cost current --period 2026-04
nimbus gcloud freetier show
```

`--provider/-p` and `--format/-f` are Nimbus extensions; everything else
follows gcloud — including the default boot image: `create` without image
flags uses the `debian-12` family from `debian-cloud`. Full grammar spec:
`design/shared/cli-command-style.md`.

:::caution[Deprecated alias]
`nimbus gcp ...` still works as a deprecated alias (including the legacy
`instance create/stop/terminate` group) and prints a warning on stderr. It
will be removed in a future release — migrate scripts to `nimbus gcloud`.
:::

Nimbus also ships a GCP free-tier spec covering the 90-day trial credit and the ongoing always-free compute, storage, and egress limits most relevant to the GCP adapter. Use `nimbus gcloud freetier show -f json` to inspect the normalized limits.

## Cost & Billing

The GCP Cloud Billing API is **free** -- no per-call charges. Nimbus queries billing
account info for spending reports. Full cost aggregation via BigQuery billing export
is not yet implemented.

## Notes

- GCP operations require explicit `project_id` and `zone` for every call. Nimbus
  reads both from the service account JSON and provider registration.
- Use resource **labels** (e.g., `environment: dev`) to scope Nimbus operations to
  specific workloads.
- For budget enforcement, GCP supports disabling billing on the entire project via
  the Cloud Billing API, which halts all services immediately.

:::info[Official Documentation]
[GCP Python Client Libraries](https://cloud.google.com/python/docs/reference)
| [Application Default Credentials](https://cloud.google.com/docs/authentication/application-default-credentials)
| [Service Account Guide](https://cloud.google.com/iam/docs/service-accounts-create)
| [Workload Identity](https://cloud.google.com/iam/docs/workload-identity-federation)
:::
