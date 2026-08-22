---
title: "Deployment"
sidebar:
  order: 3
---

# Deployment Guide

## Docker Compose (Local Bootstrap)

### Prerequisites

- Docker 24+ with Compose V2
- Git

### Deploy

```bash
git clone https://github.com/czhaoca/nimbus.git
cd nimbus

# Create local directories
mkdir -p local/backups

# Configure PostgreSQL + runtime secrets backend
cp .env.example .env
# Set NIMBUS_DATABASE_URL directly, or configure NIMBUS_SECRETS_BACKEND=env
# with your INFISICAL_* values so the runtime can fetch it.

# Optional compatibility path: create local/config only if you still use file credentials
mkdir -p local/config

# Build and start
docker compose up -d --build

# Check status
docker compose ps
curl http://localhost:8000/health
```

### Services

These are local workstation defaults, not the governed Proxmox deployment contract.

| Service | Internal Port | Host Port | Description |
|---------|--------------|-----------------|-------------|
| engine  | 8000         | `NIMBUS_ENGINE_PORT` | FastAPI backend + REST API |
| ui      | 3000 (behind nginx) | — | Next.js 15 dashboard, served via nginx |
| docs    | `NIMBUS_DOCS_PORT` | `NIMBUS_DOCS_PORT` | Starlight/Astro documentation site |
| nginx   | 80           | `NIMBUS_UI_PORT` | Reverse proxy (routes to ui & engine upstreams) |

> Host ports come from `.env` (gitignored). Copy `.env.example` for the current
> local defaults; internal container ports are the fixed service contract.

### Environment Registry

Nimbus now exposes a runtime environment registry for deploy access data:

- `GET /api/access-registry`
- `GET /api/access-registry/manifest?format=json`
- `GET /api/access-registry/manifest?format=md`
- `nimbus deploy list`
- `nimbus deploy manifest --format md --output local/registry/environment-access.md`

Use the registry for live repo/env/target/port access data instead of relying on
hardcoded local port assumptions in docs or compose defaults.

Nimbus itself is the first project governed by this registry. Canonical governed
environments are `dev` and `prod`; compatibility aliases map `test` to `dev` and
`preprod` to `prod`. Governed environments are Proxmox-hosted and must be
reserved before deploy or reset.

### Bootstrap Nimbus Into The Registry

Use placeholders that match your runtime inventory:

```bash
# 1. Register the Proxmox provider if needed
cd engine
nimbus providers add --id <proxmox-id> --type proxmox --name "<display-name>"

# 2. Register the Nimbus project
nimbus deploy register \
  --name nimbus \
  --repo git@github.com:czhaoca/nimbus.git \
  --desc "Nimbus core platform"

# 3. Sync and inspect targets
nimbus deploy sync-targets --provider <proxmox-id>
nimbus deploy targets

# 4. Mark the chosen target allocatable and create a port pool
nimbus deploy target-config \
  --target <target-id> \
  --allocatable \
  --public-address <dns-or-ip>
nimbus deploy create-pool \
  --target <target-id> \
  --name <pool-name> \
  --start <port-start> \
  --end <port-end> \
  --default

# 5. Reserve the governed slot before deploy
nimbus deploy reserve \
  --project nimbus \
  --env <dev|prod> \
  --slot <slot-key> \
  --target <target-id> \
  --pool <pool-id> \
  --service ui:3000:http \
  --service api:8000:http \
  --requested-by <actor>

# 6. Export a fresh manifest for operators and agents
nimbus deploy manifest --format md --output local/registry/environment-access.md
```

For governed environments, the registry-assigned host ports are authoritative.
Do not reuse the local compose defaults.

### Volumes

- `local/backups/` → `/app/local/backups` (SQLite snapshots or PostgreSQL dumps)
- `local/config/` → `/app/local/config` and `/app/config` (Compatibility credentials only; optional)
- `deploy/nginx/default.conf` → Nginx config (read-only)

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `NIMBUS_DATABASE_URL` | empty | Required in production unless vault-injected |
| `NIMBUS_ENVIRONMENT` | `production` | Environment name |
| `NIMBUS_SECRETS_BACKEND` | `env` | Set to `env` for vault/runtime-injected credentials |
| `BAO_ADDR` / `BAO_ROLE_ID` / `BAO_SECRET_ID` | empty | OpenBao AppRole — selects the OpenBao branch (canonical) |
| `BAO_CACERT_B64` | empty | Pinned internal CA for the OpenBao listener, base64 PEM |
| `BAO_SECRET_PATHS` | empty | Comma-separated vault folders to inject (an explicit list; a bare catch-all root is refused) |
| `INFISICAL_TOKEN` | empty | Legacy Infisical service token flow (decommission scheduled) |
| `INFISICAL_CLIENT_ID` / `INFISICAL_CLIENT_SECRET` | empty | Legacy Infisical Universal Auth |
| `INFISICAL_PROJECT_ID` / `INFISICAL_API_URL` | empty | Legacy Infisical project targeting |
| `INFISICAL_HOST_SECRET_PATH` | empty | Optional host-specific overlay path such as `/nimbus/lxc/<hostname>` |

The entrypoint selects its secrets branch by env presence: with the `BAO_*`
AppRole set it injects from OpenBao (and wins, loudly, if both stores are
configured); with only `INFISICAL_*` credentials it falls back to the legacy
Infisical branch, which is scheduled for removal after the cutover soak.
Production deploys still require a PostgreSQL `NIMBUS_DATABASE_URL`, either in
the container env or vault-injected.

### PostgreSQL (Required For Production)

For on-prem or production deploys, use PostgreSQL:

```yaml
# docker-compose.yml
services:
  db:
    image: postgres:17-alpine
    environment:
      POSTGRES_DB: nimbus
      POSTGRES_USER: nimbus
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - pgdata:/var/lib/postgresql/data

  engine:
    environment:
      NIMBUS_DATABASE_URL: postgresql://nimbus:${POSTGRES_PASSWORD}@db:5432/nimbus
    depends_on:
      db:
        condition: service_healthy
```

Run migrations with the migrator role:
```bash
cd engine
NIMBUS_DATABASE_URL="$NIMBUS_MIGRATOR_DATABASE_URL" uv run alembic upgrade head
```

## Proxmox Deployment

Deploy Nimbus to a Proxmox VM automatically:

```bash
./deploy/proxmox/deploy-nimbus.sh --host <VM_IP> --user root --key ~/.ssh/id_rsa
```

This script:
1. Installs Docker if not present
2. Clones/updates the Nimbus repo
3. Sets up backup/config directories
4. Validates PostgreSQL / Infisical configuration
5. Builds and starts containers

## Backup Strategy

### Automatic Backups

```bash
# Create backup (keeps last 10)
nimbus backup create

# Or via API
curl -X POST http://localhost:8000/api/backup
```

### Scheduled Backups (cron)

```bash
# Add to crontab
0 */6 * * * cd /opt/nimbus && docker compose exec engine nimbus backup create
```

PostgreSQL backups use `pg_dump` custom-format dumps under `local/backups/`.
For restores or rollback:

```bash
pg_restore --clean --if-exists \
  --dbname "$NIMBUS_MIGRATOR_DATABASE_URL" \
  local/backups/nimbus_<timestamp>.dump
```

## High Availability

### Failover Configuration

1. Deploy Nimbus on 2+ VMs
2. Configure DNS failover via the orchestration API:

```bash
curl -X POST http://localhost:8000/api/orchestrate/dns-failover \
  -H "Content-Type: application/json" \
  -d '{"resource_id": "...", "dns_provider_id": "cf", "zone_id": "...", "record_id": "...", "new_ip": "1.2.3.4", "record_name": "app.example.com"}'
```

### Health Monitoring

```bash
# Check provider health and latency
curl http://localhost:8000/api/providers/health/check
```
