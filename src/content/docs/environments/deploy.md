---
title: "Deploy Nimbus"
sidebar:
  order: 4
---

# How To: Deploy Nimbus

Run Nimbus with Docker Compose, configure for production, or deploy on Proxmox.

## Prerequisites

- Docker 24+ with Compose V2
- Git
- For Proxmox: SSH access to a Proxmox host

## Docker Compose Quickstart

This is the local workstation bootstrap path. It is not the authoritative source
for governed Proxmox environment ports.

```bash
git clone https://github.com/czhaoca/nimbus.git && cd nimbus
mkdir -p local/backups
cp .env.example .env      # set PostgreSQL / vault values before starting
mkdir -p local/config     # optional compatibility path only
docker compose up -d --build
docker compose ps && curl http://localhost:8000/health
```

## Port Configuration

Host ports are set via `.env` (gitignored) — copy `.env.example` for the
current local defaults; the values below are the variables, not fixed numbers:

| Variable | Service |
|----------|---------|
| `NIMBUS_UI_PORT` | Nginx reverse proxy (UI + API) |
| `NIMBUS_ENGINE_PORT` | FastAPI engine (direct API) |
| `NIMBUS_DOCS_PORT` | Starlight/Astro documentation site |

Additional variables: `NIMBUS_SECRETS_BACKEND` (`file` or `env`); the OpenBao
set `BAO_ADDR`, `BAO_ROLE_ID`, `BAO_SECRET_ID`, `BAO_CACERT_B64`,
`BAO_SECRET_PATHS` (canonical — the legacy `INFISICAL_*` variables still work
during the migration soak, with `INFISICAL_HOST_SECRET_PATH` as a host-specific
overlay such as `/nimbus/lxc/<hostname>`); `NIMBUS_UID`/`NIMBUS_GID` for
container file permissions; and `NIMBUS_DATABASE_URL` for the PostgreSQL
connection string.

## Governed Proxmox Environments

Nimbus is the first project governed by the environment registry. Canonical
governed environments are `dev` and `prod`; compatibility aliases map `test` to
`dev` and `preprod` to `prod`. Governed environments must be reserved through
the registry before deploy or reset.

```bash
cd engine
nimbus deploy register --name nimbus --repo git@github.com:czhaoca/nimbus.git --desc "Nimbus core platform"
nimbus deploy sync-targets --provider <proxmox-id>
nimbus deploy targets
nimbus deploy target-config --target <target-id> --allocatable --public-address <dns-or-ip>
nimbus deploy create-pool --target <target-id> --name <pool-name> --start <port-start> --end <port-end> --default
nimbus deploy reserve \
  --project nimbus \
  --env <dev|prod> \
  --slot <slot-key> \
  --target <target-id> \
  --pool <pool-id> \
  --service ui:3000:http \
  --service api:8000:http \
  --requested-by <actor>
nimbus deploy manifest --format md --output local/registry/environment-access.md
```

For governed environments, use the registry-assigned host ports and target
identity. Do not assume the local compose defaults.

## Production Setup with Nginx

The included Nginx container serves as a reverse proxy. For production, add SSL/TLS:

```nginx
server {
    listen 443 ssl;
    server_name nimbus.example.com;
    ssl_certificate     /etc/nginx/ssl/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/key.pem;

    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains" always;
    add_header X-Frame-Options DENY always;
    add_header X-Content-Type-Options nosniff always;

    location /api/ { proxy_pass http://engine:8000/; }
    location /     { proxy_pass http://ui:3000; }
}
server {
    listen 80;
    server_name nimbus.example.com;
    return 301 https://$host$request_uri;
}
```

Mount certificates as Docker volumes or use Let's Encrypt with certbot.

## Proxmox Deployment

```bash
./deploy/proxmox/deploy-nimbus.sh --host <vm-hostname> --user root --key ~/.ssh/id_rsa
```

The script installs Docker if missing, clones/updates the repo, creates
`local/backups/` and optional compatibility config directories, validates that
PostgreSQL or the vault is configured, seeds `INFISICAL_HOST_SECRET_PATH` with the
remote hostname when absent (a legacy-branch overlay retained through the OpenBao
migration soak), and then runs `docker compose up -d --build`.

## Database Backup and Restore

```bash
# Create backup (CLI, API, or Docker)
nimbus backup create
curl -X POST http://localhost:8000/api/backup
docker compose exec engine nimbus backup create

# List backups
nimbus backup list

# Scheduled backups (cron -- every 6 hours)
# 0 */6 * * * cd /opt/nimbus && docker compose exec -T engine nimbus backup create

# Restore a PostgreSQL dump during maintenance
pg_restore --clean --if-exists \
  --dbname "$NIMBUS_MIGRATOR_DATABASE_URL" \
  local/backups/nimbus_<timestamp>.dump
```

Backups are stored in `local/backups/` with automatic rotation. PostgreSQL backups
use `pg_dump` custom-format dumps; SQLite backups remain available only for
development fallback environments. A fresh database is built directly from the
Alembic chain (`nimbus db init` / `nimbus db upgrade`) — there is no data-import
step, since deployments start greenfield.

## SSL/TLS Setup Overview

1. **Let's Encrypt** (recommended): Use certbot on the host, mount certs into Nginx container.
2. **Self-signed** (dev only): `openssl req -x509 -nodes -days 365 ...`, mount into Nginx.
3. **Cloudflare proxy**: Enable orange-cloud proxy for automatic SSL termination.

Always set security headers (HSTS, X-Frame-Options, CSP) in Nginx as shown above.

:::info[Deployment Guide]
Full deployment reference: [Deployment Guide](/environments/deployment/)
:::


## Official Documentation

- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Let's Encrypt Documentation](https://letsencrypt.org/docs/)
- [Proxmox VE Documentation](https://pve.proxmox.com/pve-docs/)
