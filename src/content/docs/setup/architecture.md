---
title: "Architecture Overview"
sidebar:
  order: 1
---

# Architecture Overview

Nimbus is a multi-cloud orchestration platform for provisioning, monitoring,
and budget enforcement across public cloud and on-premises infrastructure.

## System Diagram

```
                          Users
                       /    |    \
                    CLI   Web    API
                      |   Browser  |
                      |     |      |
                      v     v      v
                    +------------------+
                    |   Nginx Proxy    |  :3000 / :8000 local defaults
                    +------------------+
                      |            |
              +-------+            +--------+
              v                             v
    +------------------+          +------------------+
    |  Next.js 15 UI   |         |  FastAPI Engine   |
    |  (App Router)    |         |  (Python)         |
    |  :3000 internal  |         |  :8000 internal   |
    +------------------+         +------------------+
                                   |          |
                            +------+          +------+
                            v                        v
                   +----------------+       +----------------+
                   | Provider       |       | PostgreSQL DB  |
                   | Adapters (7)   |       | (Prod) /       |
                   |                |       | SQLite (Dev)   |
                   | OCI  AWS Azure |       +----------------+
                   | GCP  CF  PVE   |
                   | UniFi          |
                   +----------------+
```

## Component Overview

| Component    | Location     | Purpose                                         |
|--------------|--------------|--------------------------------------------------|
| **Engine**   | `engine/`    | FastAPI backend: REST API, services, providers   |
| **UI**       | `ui/`        | Next.js 15 dashboard with Tailwind CSS           |
| **CLI**      | `engine/nimbus/cli/` | Typer-based terminal interface             |
| **Providers**| `engine/nimbus/providers/` | Adapter classes for each cloud/infra target |
| **Deploy**   | `deploy/`    | Docker Compose, Nginx configs, production setup  |
| **Docs**     | `docs/`      | Architecture decisions, guides, roadmap          |
| **Templates**| `templates/` | Credential templates with placeholders           |

The environment registry lives in the backend domain layer and is the canonical
source for governed project slots, Proxmox targets, port pools, and endpoint
allocations. The UI reads this data through the API; it does not compute
allocations itself.

## Tech Stack

| Layer      | Technology         | Version / Notes                          |
|------------|--------------------|------------------------------------------|
| Backend    | Python + FastAPI   | SQLAlchemy 2.0 ORM, Pydantic validation  |
| Frontend   | Next.js 15         | App Router, React Server Components      |
| Styling    | Tailwind CSS v4    | `@theme` directive in CSS, not config    |
| CLI        | Typer              | Built on Click, Rich output              |
| Database   | PostgreSQL / SQLite fallback | PostgreSQL for production, SQLite fallback for local development |
| Data Fetch | TanStack Query     | REST + React Query on the frontend       |
| Package Mgmt | `uv` (Python), `pnpm` (Node.js) |                             |
| Lint/Format | `ruff` (Python), ESLint (TypeScript) |                        |

## Port Conventions

| Port    | Service                     | Access        |
|---------|-----------------------------|---------------|
| `3000` | UI (Nginx reverse proxy)    | Local default |
| `8000` | API (Nginx reverse proxy)   | Local default |
| `3000`  | Next.js dev server          | Internal only |
| `8000`  | FastAPI / Uvicorn           | Internal only |

Ports are configured via `.env` (gitignored); see `.env.example` for the template.
Governed Proxmox environments use registry-assigned host ports instead of these
local compose defaults.

## Provider Adapter Architecture

```
ProviderAdapter (ABC)            # base.py
    |
    +-- authenticate()           # load credentials
    +-- list_resources()         # enumerate resources
    +-- provision()              # create resources
    +-- terminate()              # destroy resources
    +-- get_spending()           # query cost data
    +-- health_check()           # connectivity probe
    +-- _resilient_call()        # retry + circuit breaker
    |
    +-- ProxmoxVLANMixin         # VLAN tag management
    +-- UniFiNetworkMixin        # VLANs, port profiles, firewall rules
```

Adapters are registered in `ProviderRegistry` (singleton). The registry maps
`provider_type` strings to adapter classes and manages authenticated instances.
Credential resolution uses `services/secrets.py`, which supports env vars
(vault-injected — OpenBao — in governed deployments) and file paths as
backends.

## Security Model

- **Secrets**: Never committed. Prefer runtime injection via env vars from the
  vault (OpenBao). `local/` remains gitignored for compatibility-only local
  overrides. Templates with placeholders live in `templates/`.
- **Pre-commit hooks**: Two layers -- Claude Code hooks (`.claude/settings.json`)
  and Git hooks (`.githooks/pre-commit`) scan for secret patterns.
- **Network isolation**: Proxmox VMs are VLAN-tagged; UniFi firewall rules enforce
  inter-VLAN traffic policies. Experimental workloads are isolated from trusted LANs.
- **Auth**: Session-based auth in the UI (sessionStorage token), API key auth for
  programmatic access.
- **Production**: Next.js standalone build behind Nginx with security headers
  (CSP, HSTS, X-Frame-Options). Never expose the dev server.
