---
title: "Manage Users"
sidebar:
  order: 6
---

# Manage Users

RBAC roles, JWT authentication, API keys, and audit log access.

## Prerequisites

- Nimbus engine running with `NIMBUS_JWT_SECRET` configured
- An admin account created (first user or seeded via CLI)

## 1. Creating Users and Assigning Roles

Three roles: **admin**, **operator**, **viewer**.

```bash
# Login to get a JWT token
curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "your-password"}'

# Create a new user (admin only)
curl -X POST http://localhost:8000/api/auth/users \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{"username": "ops-user", "password": "secure-pass", "role": "operator"}'

# List users | Update role | Delete user
curl -H "Authorization: Bearer <token>" http://localhost:8000/api/auth/users
curl -X PUT http://localhost:8000/api/auth/users/{user_id} \
  -H "Authorization: Bearer <token>" -H "Content-Type: application/json" \
  -d '{"role": "viewer"}'
curl -X DELETE http://localhost:8000/api/auth/users/{user_id} \
  -H "Authorization: Bearer <token>"
```

## 2. JWT Authentication Flow

Tokens contain: `sub` (user ID), `username`, `role`, `exp`, `iat`. Expiry configured via `NIMBUS_JWT_EXPIRE_MINUTES`.

```bash
# Check current user
curl -H "Authorization: Bearer <token>" http://localhost:8000/api/auth/me

# Change your password
curl -X PUT http://localhost:8000/api/auth/password \
  -H "Authorization: Bearer <token>" -H "Content-Type: application/json" \
  -d '{"current_password": "old-pass", "new_password": "new-pass"}'
```

## 3. API Key Management

Generated API keys are durable automation credentials. Nimbus stores only hashed
key material, shows the raw key once at creation, and rejects revoked keys
immediately. The configured `NIMBUS_API_KEY` remains supported for compatibility.

```bash
# Create a key (shown only once -- save it)
curl -X POST http://localhost:8000/api/keys \
  -H "Content-Type: application/json" \
  -d '{"name": "ci-pipeline", "scopes": ["read", "write"]}'

# List keys (masked) | Revoke a key
curl http://localhost:8000/api/keys
curl -X DELETE http://localhost:8000/api/keys/{key_id}

# Use the generated key
curl -H "Authorization: Bearer <generated-key>" http://localhost:8000/api/resources
```

## 4. Role Permissions Matrix

| Action                 | Admin | Operator | Viewer |
|------------------------|:-----:|:--------:|:------:|
| View resources/budgets |  Yes  |   Yes    |  Yes   |
| Provision/modify       |  Yes  |   Yes    |   No   |
| Manage budgets         |  Yes  |   Yes    |   No   |
| Create/delete users    |  Yes  |    No    |   No   |
| Manage API keys        |  Yes  |    No    |   No   |
| View CI runners        |  Yes  |    No    |   No   |
| System configuration   |  Yes  |    No    |   No   |

## 5. Audit Log Viewing

Every action is recorded with user attribution.

```bash
# List recent entries (with optional filters)
curl "http://localhost:8000/api/audit?provider_id=my-provider&action_type=provision&limit=20"

# Export as CSV or JSON (with date range)
curl "http://localhost:8000/api/audit/export?format=csv" -o audit.csv
curl "http://localhost:8000/api/audit/export?format=json&since=2026-01-01" -o audit.json
```

Each entry includes: `action_type`, `resource_id`, `status`, `initiated_by`, `user_id`, `created_at`.

In the UI, navigate to **Activity > Audit Log** to browse and export entries.

:::tip[API Reference]
See [Auth API](/api/auth) and [Audit API](/api/audit) for full endpoint docs.
:::
