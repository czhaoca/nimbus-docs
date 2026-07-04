---
title: "Manage Secrets"
sidebar:
  order: 7
---

# Manage Secrets

Runtime secrets via Infisical or environment variables, with optional file-based
compatibility for local development.

## Prerequisites

- Nimbus engine installed (`cd engine && uv sync`)
- Provider registered in Nimbus (`nimbus providers add`)
- For Infisical: an [Infisical](https://infisical.com/docs/) project created

## 1. Recommended: Environment Variables

If all required env vars are set, Nimbus auto-detects and uses them even if the
configured backend is still `file`. To make the intent explicit, set:

```bash
export NIMBUS_SECRETS_BACKEND=env
```

Required variables per provider:

| Provider   | Required Variables                                           |
|------------|--------------------------------------------------------------|
| AWS        | `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`                 |
| Azure      | `AZURE_TENANT_ID`, `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET` |
| GCP        | `GOOGLE_APPLICATION_CREDENTIALS`                             |
| OCI        | `OCI_CLI_PROFILE`                                            |
| Cloudflare | `CLOUDFLARE_API_TOKEN`                                       |
| Proxmox    | `PROXMOX_URL`, `PROXMOX_TOKEN_ID`, `PROXMOX_TOKEN_SECRET`   |
| UniFi      | `UNIFI_URL` plus either `UNIFI_API_KEY` or `UNIFI_USERNAME` + `UNIFI_PASSWORD` |

For production database access, Nimbus also needs:

| Purpose | Variable |
|---------|----------|
| Runtime app role | `NIMBUS_DATABASE_URL` |
| Alembic / import jobs | `NIMBUS_MIGRATOR_DATABASE_URL` |

## 2. Infisical Integration

[Infisical](https://infisical.com/docs/) injects secrets as environment variables at runtime.

Supported auth modes:

- Universal Auth: `INFISICAL_CLIENT_ID` + `INFISICAL_CLIENT_SECRET` + `INFISICAL_PROJECT_ID`
- Legacy token flow: `INFISICAL_TOKEN`

### Environment (always Production)

All Nimbus credentials live in the Infisical **Production** environment (slug `prod`) —
there is no per-environment credential split, so a local Docker or CI run reads the same
`prod` secrets. Set `INFISICAL_ENVIRONMENT=prod`. Spelled-out names are normalized to the
project's slugs at every boundary (`production` → `prod`, `development` → `dev`, `staging`
→ `staging`), so a value like `production` resolves correctly instead of silently matching
no environment. When unset, the credential layer defaults to `prod`.

Recommended Nimbus layout inside the Infisical project:

- `/common/github/1` for shared cross-project secrets such as `GITHUB_1_PAT`
- `/nimbus/runtime` for app-level secrets such as `NIMBUS_JWT_SECRET`
- `/nimbus/db/runtime` for `NIMBUS_DATABASE_URL` and runtime DB fields
- `/nimbus/db/migration` for `NIMBUS_MIGRATOR_DATABASE_URL` and migrator DB fields
- `/nimbus/db/readonly` for optional read-only DB credentials
- `/nimbus/lxc/<hostname>` for host-specific overlay data such as bootstrap path specs,
  Proxmox inventory metadata, and container-owned secrets
- `/nimbus/providers/oci/1` for `OCI_1_CLI_PROFILE`
- `/nimbus/providers/proxmox/1` for `PROXMOX_1_*`
- `/nimbus/providers/unifi/1` for `UNIFI_1_URL` plus either `UNIFI_1_API_KEY` or `UNIFI_1_USERNAME` + `UNIFI_1_PASSWORD`

Set `INFISICAL_SECRET_PATHS=/common,/nimbus` so the runtime loads shared secrets
first and Nimbus-specific secrets second. On a specific host, set
`INFISICAL_HOST_SECRET_PATH=/nimbus/lxc/<hostname>` so the entrypoint appends the
per-host overlay automatically.

```bash
# Install CLI: https://infisical.com/docs/cli/overview
infisical login
infisical init

# Run the engine through the repository entrypoint so both paths are loaded
NIMBUS_SECRETS_BACKEND=env \
INFISICAL_SECRET_PATHS=/common,/nimbus \
INFISICAL_HOST_SECRET_PATH=/nimbus/lxc/<hostname> \
docker compose up engine
```

Docker Compose usage:

```yaml
services:
  engine:
    environment:
      NIMBUS_SECRETS_BACKEND: env
      INFISICAL_TOKEN: ${INFISICAL_TOKEN}
      INFISICAL_CLIENT_ID: ${INFISICAL_CLIENT_ID}
      INFISICAL_CLIENT_SECRET: ${INFISICAL_CLIENT_SECRET}
      INFISICAL_PROJECT_ID: ${INFISICAL_PROJECT_ID}
      INFISICAL_API_URL: ${INFISICAL_API_URL}
      INFISICAL_SECRET_PATHS: ${INFISICAL_SECRET_PATHS:-/common,/nimbus}
      INFISICAL_HOST_SECRET_PATH: ${INFISICAL_HOST_SECRET_PATH:-}
      INFISICAL_SECRET_PATH: ${INFISICAL_SECRET_PATH:-/nimbus}
```

The repository entrypoint already detects Infisical credentials and wraps the engine
process automatically. It prefers `INFISICAL_SECRET_PATHS` and loads the listed
paths in order, with later paths overriding earlier ones.

Recommended Infisical secret set for on-prem PostgreSQL:

- `/nimbus/db/runtime`
- `/nimbus/db/migration`
- `/nimbus/db/readonly`
- `/nimbus/lxc/<db-hostname>`
- `/nimbus/lxc/<platform-hostname>`

App/runtime secrets belong in `/nimbus/runtime`. Provider secrets belong under
`/nimbus/providers/<type>/<index>`. Shared operator tokens belong under `/common`.
Per-host overlays belong under `/nimbus/lxc/<hostname>`.

Per-LXC credentials (SSH access, the Proxmox descriptor, and pointer keys to the
service-secret paths above) are managed by the `nimbus secrets lxc` subsystem. It
discovers LXCs from Proxmox and writes a layered, per-host folder; service secrets
keep their own homes (`/nimbus/db/*`, `/nimbus/providers/*`) and the LXC folder
only points at them. All mutating verbs are dry-run by default.

```bash
nimbus secrets lxc review                 # read-only state of every canonical host
nimbus secrets lxc sync --apply [--prune] # Proxmox descriptors + pointers per host
nimbus secrets lxc push-ssh --host <host> --key-file ~/.ssh/proxmox-lxc --apply
nimbus secrets lxc bootstrap-db --apply   # create PG roles + store /nimbus/db/* logins
nimbus secrets lxc canonicalize --apply --confirm-deletes  # drop pre-rename folders
```

These replace the former `deploy/postgres/*.sh` bootstrap helpers
and `deploy/infisical/sync-proxmox-lxc-secrets.sh`.

## 3. Compatibility File Backend

Use a repo-local compatibility file only if runtime env injection is not available.
These files must stay out of version control.

```bash
mkdir -p local/config
cp templates/provider-proxmox.template local/config/provider-proxmox.yaml
```

Supported file formats per provider:

| Provider   | Format     | Parser                |
|------------|------------|-----------------------|
| Proxmox    | KEY=VALUE  | `parse_ini_config()`  |
| UniFi      | KEY=VALUE  | `parse_ini_config()`  |
| AWS        | INI        | `parse_aws_config()`  |
| Azure, GCP | JSON       | `parse_json_config()` |
| Cloudflare | Token file | `parse_token_file()`  |

## 4. Credential Resolver Service

`resolve_credentials()` in `engine/nimbus/core/services/secrets.py` unifies loading:

1. **Indexed env** -- numbered variables such as `PROXMOX_1_URL` when `instance_index=1`
2. **Auto-detect env** -- all required env vars present? Use them
3. **Explicit env** -- `backend="env"` forces env var lookup
4. **Compatibility file** -- parse the `credentials_path` file
5. **None** -- no credentials available

```bash
# Verify runtime credential state without exposing secrets
nimbus providers list --format json
curl http://localhost:8000/api/providers/{provider_id}/credential-status
```

## 5. Secret Rotation

1. Generate new credentials in the provider console
2. Update the Infisical secret or runtime env vars
3. Verify: `nimbus providers list --format json`
4. Verify: `curl http://localhost:8000/api/providers/{provider_id}/credential-status`
5. Revoke old credentials in the provider console

For PostgreSQL role rotation, update the role password in PostgreSQL first, then
update the matching Infisical secrets before restarting the affected runtime or
maintenance job.

If you are still using the compatibility file flow, update the local file and then
refresh the provider cache with `POST /api/providers/{provider_id}/refresh`.

**Enforced security rules:** pre-commit hooks scan for hardcoded secrets; Claude Code
hooks block writes to protected secret locations; `local/` remains gitignored when
used as a compatibility bridge.

## Further Reading

- [Infisical Documentation](https://infisical.com/docs/)
- [Infisical CLI Reference](https://infisical.com/docs/cli/overview)
