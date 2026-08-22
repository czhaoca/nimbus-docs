---
title: "Getting Started"
sidebar:
  order: 2
---

# Getting Started

## Prerequisites

- Python 3.12+
- [uv](https://docs.astral.sh/uv/) (Rust-based Python package manager)
- Node.js 22+ (for frontend)
- [pnpm](https://pnpm.io/) (fast Node.js package manager)
- Docker & Docker Compose (for production)

## Quick Start (Development)

### 1. Clone the repository

```bash
git clone https://github.com/czhaoca/nimbus.git
cd nimbus
```

### 2. Set up the engine

```bash
cd engine
uv sync
```

> [uv](https://docs.astral.sh/uv/) handles virtual environment creation and dependency installation in a single command.

### 3. Initialize the database

```bash
nimbus status  # Initializes the configured development database
```

### 4. Start the engine

```bash
nimbus serve
# Engine running at http://localhost:8000
# Swagger docs at http://localhost:8000/docs
```

> See [FastAPI docs](https://fastapi.tiangolo.com/) for more on the API framework.

### 5. Start the frontend (separate terminal)

```bash
cd ui
pnpm install
pnpm dev
# Dashboard at http://localhost:3000
```

> The UI is built with [Next.js 15](https://nextjs.org/docs) (App Router) and Tailwind CSS.

### 6. Set up git hooks

```bash
git config core.hooksPath .githooks
```

## Configuration

### Provider Setup

1. Choose a secrets source.

```bash
# Recommended: runtime env vars or vault injection (OpenBao)
export NIMBUS_SECRETS_BACKEND=env
export OCI_CLI_PROFILE=DEFAULT
```

Or run the engine under the vault so provider credentials are injected at
process start instead of stored in repo-local files (OpenBao via the `BAO_*`
env set; the legacy Infisical path is scheduled for decommission).

2. Register the provider:

```bash
nimbus providers add \
  --id my-oci \
  --type oci \
  --name "My OCI Account" \
  --region us-ashburn-1
```

3. Optional compatibility path: use a local credentials file only if you are not
using env/vault-injected secrets.

```bash
mkdir -p local/config
cp templates/provider-oci.template local/config/oci.ini

nimbus providers add \
  --id my-oci-file \
  --type oci \
  --name "My OCI Account (File)" \
  --region us-ashburn-1 \
  --credentials local/config/oci.ini
```

4. Confirm the provider is registered and that Nimbus can see a configured
credential source.

```bash
nimbus providers list --format json
curl http://localhost:8000/api/providers/my-oci/credential-status
```

### Budget Rules

```bash
# Add a $10/month budget with alert at 80%
nimbus budget add --provider my-oci --limit 10.00 --threshold 0.8 --action alert
```

### Database Backup

```bash
nimbus backup create  # Creates timestamped backup in local/backups/
nimbus backup list    # Show existing backups
```

## Docker Setup

```bash
cp .env.example .env
# Set NIMBUS_DATABASE_URL directly or configure the vault (OpenBao) before starting.
docker compose up --build
# Local UI default:  http://localhost:3000
# Local API default: http://localhost:8000
```

See [Deployment Guide](/environments/deployment/) for production setup details.

## Governed Environments

Nimbus is the first project governed by the environment registry. Canonical
governed environments are `dev` and `prod`; compatibility aliases map `test` to
`dev` and `preprod` to `prod`. Read live access data from the registry instead
of inferring it from local Docker defaults.

Use these interfaces when you need live access data:

- `GET /api/access-registry`
- `GET /api/access-registry/manifest?format=json`
- `GET /api/access-registry/manifest?format=md`
- `nimbus deploy list`
- `nimbus deploy manifest --format md --output local/registry/environment-access.md`

## Security

- **Never commit secrets** — prefer vault-injected (OpenBao) or runtime environment variables
- `local/` is a compatibility bridge for development, not the primary secrets model
- Templates in `templates/` provide placeholder examples when a compatibility file is needed
- Claude Code hooks and git pre-commit hooks enforce secret scanning
- See [`CLAUDE.md`](https://github.com/czhaoca/nimbus/blob/main/CLAUDE.md) for the repo-local operating rules

## What's Next

- [Operations](/operations/manage-resources/) — task-oriented workflows for common operations
- [Provider Setup](/providers/) — configure cloud provider adapters
- [Deployment Guide](/environments/deployment/) — Docker Compose, Proxmox, production setup
- [Roadmap](https://github.com/czhaoca/nimbus/blob/main/requirements/ROADMAP.md) — current product sequence and gap tracking
- [Full Documentation Site](http://localhost:4321) — API reference and guides
