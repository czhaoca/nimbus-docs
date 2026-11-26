# CLI Docs Alignment Report — Cloudflare

| Field | Value |
|-------|-------|
| **Provider** | Cloudflare (`cloudflare`) |
| **Last reviewed** | 2026-07-24T16:05:00Z |
| **Reviewed at commit** | *(pending commit)* |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 35 total, 35 with refs, 0 skipped |
| **SDK dependency** | N/A (REST API) |
| **Gaps found** | 0 |
| **PR** | *(pending)* |

## Reference Coverage

All `cloudflare_*.py` operation descriptors now reference official `developers.cloudflare.com` URLs.

| Op File | Ops | Status |
|---------|-----|--------|
| `cloudflare_device.py` | 5 | ✅ aligned |
| `cloudflare_dns.py` | 4 | ✅ aligned |
| `cloudflare_network.py` | 5 | ✅ aligned |
| `cloudflare_site.py` | 5 | ✅ aligned |
| `cloudflare_tunnel.py` | 7 | ✅ aligned |
| `cloudflare_zerotrust.py` | 8 | ✅ aligned |
| `cloudflare_zone.py` | 1 | ✅ aligned |

## Dependency Status

*(Skipped for Cloudflare as it uses raw REST API requests without a Python SDK extra.)*

## API currency

| Field | Value |
|-------|-------|
| **Reviewed** | 2026-11-25 (#456 research, fixed under #459) |
| **Locked / latest** | No SDK: REST over stdlib urllib against API v4, which has no version pinning (nothing in uv.lock) |
| **Changelog range read** | Cloudflare API deprecations page (every entry through the 2026-10-05 tunnel `connections` removal) and the Cloudflare changelog through 2026-11-25 (2026-07-09 tunnel routes/connections notice, 2026-01-22 granular Access token permissions, 2026-05-21 Tunnel/Mesh scopable permissions) |
| **Sources** | https://developers.cloudflare.com/fundamentals/api/reference/deprecations/ ; https://developers.cloudflare.com/api/resources/zero_trust/subresources/devices/ ; https://developers.cloudflare.com/changelog/2026-07-09-tunnel-routes-and-connections-api-changes/ ; https://developers.cloudflare.com/cloudflare-one/access-controls/policies/policy-management/ |

| Severity | nimbus call | Upstream change | Fix (#459) |
|---|---|---|---|
| BREAKING | `cloudflare.device.list` (GET /devices) | End of life 2025-11-11; replaced by /devices/physical-devices + /devices/registrations (the user moved to registrations) | Registrations joined to physical devices on device.id, cursor-paginated; an unreadable list raises; row `id` = registration id |
| BREAKING | `cloudflare.device.revoke` (DELETE /devices/{id}, undocumented) | Legacy revoke reached end of life; DELETE /devices/registrations/{id} documented (Zero Trust Write) | Deletes the registration; op param `device_id` kept (it is the registration id the list reports), so no contract change |
| CHANGED | `cloudflare.tunnel.list`, site status (tunnel `connections` array) | Removed from cfd_tunnel list/get 2026-10-05 | Count read from GET /cfd_tunnel/{id}/connections for healthy/degraded tunnels; inactive/down = 0 with no call; unreadable = null |
| CHANGED | `cloudflare.dns.update` (PUT with a new type) | Type change through update unsupported since 2026-06-30 | Live type read first; a type change is refused before any write (delete and create instead) |
| CHANGED | gateway rule create/update `audit_ssh` | Action removed 2026-07-15 | Dropped from the docstring; create/update refuse it (use SSH with Access for Infrastructure) |
| CHANGED | `tunnel.publish` email/group identity (app-scoped policy on a new app) | Legacy app-scoped policies cannot be added to newly created Access apps | One reusable allow policy per hostname (`nimbus-publish-<hostname>`), attached by id in the app body; deleted on a failed app create, and on unpublish only when the registry recorded it at publish, its live name still matches and Cloudflare reports `app_count == 0`; shared reusable policies never deleted. Migration 041 clears the policy ids recorded before #459, all of which name shared policies |
| NONE | teamnet routes, Access app `domain`, DNS list/create, rulesets, tunnel configurations/token, zones, accounts, token verify | CIDR route endpoints removed 2026-10-05 (nimbus uses route ids); self_hosted_domains deprecated (nimbus uses `domain`); Service Key auth ended 2026-09-30 (nimbus uses API tokens) | None needed |

Live-only, pending the owner-run read-only probe (F459-01): whether the end-of-life GET /devices still answers, the live field names of physical-devices, registrations and /connections, whether access/policies?per_page=1000 is accepted, and the token scope for deleting a registration.

Also changed by #459 (callers see these):
- Device revoke is now a registration delete (re-enrolment possible), following Cloudflare's replacement for the end-of-life revoke; the op is still called "revoke".
- In a device-list row, `device_id` is the physical device id; the revoke parameter `device_id` takes the registration id (the row's `id`).
- `connections` on tunnel list and site status is nullable: `null` when the per-tunnel read fails (since 2026-10-05 it had silently been 0 for every tunnel).
- `tunnel.unpublish` results gain an optional `access_policies_deleted`; a `policy:` identity naming a `nimbus-publish-*` policy is refused at plan time.
- DNS update reads the record first and refuses a type change, or an unreadable record, before any write.
