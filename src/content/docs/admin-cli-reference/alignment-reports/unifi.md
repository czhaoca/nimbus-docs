# CLI Docs Alignment Report — UniFi

| Field | Value |
|-------|-------|
| **Provider** | UniFi (`unifi`) |
| **Last reviewed** | 2026-07-24T16:05:00Z |
| **Reviewed at commit** | *(pending commit)* |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 18 total, 18 with refs, 0 skipped |
| **SDK dependency** | N/A (REST API) |
| **Gaps found** | 0 |
| **PR** | *(pending)* |

## Reference Coverage

`unifi_firewall.py` and `unifi_vlan.py` reference the official versioned Integration spec; the other op files reference community `ubntwiki.com` endpoints for legacy-only APIs.

| Op File | Ops | Status |
|---------|-----|--------|
| `unifi_client.py` | 1 | ✅ aligned |
| `unifi_device.py` | 2 | ✅ aligned |
| `unifi_firewall.py` | 3 | ✅ aligned |
| `unifi_fixed_ip.py` | 2 | ✅ aligned |
| `unifi_port_profile.py` | 3 | ✅ aligned |
| `unifi_vlan.py` | 4 | ✅ aligned |
| `unifi_wlan.py` | 3 | ✅ aligned |

## Dependency Status

*(Skipped for UniFi as it uses raw REST API requests without a Python SDK extra.)*

## API currency

| Field | Value |
|-------|-------|
| **Reviewed** | 2026-11-25 (#456 research, #460 fixes) |
| **Packages** | none: stdlib `urllib`, `X-API-KEY` header; nothing in `engine/uv.lock` belongs to this provider |
| **Locked / latest** | N/A (no SDK). Newest Network releases at review: 11.1.58 (2026-11-24), 11.0.104, 10.6.111 |
| **Spec read** | official Integration spec `https://apidoc-cdn.ui.com/network/v<version>/integration.json`: 9.1.120 to 9.5.21, 10.0.162, 10.1.68, 10.1.84, 10.3.58 (newest readable; 10.4 to 11.1 answered 403) |
| **Release notes read** | `https://community.ui.com/rss/releases/UniFi-Network-Controller/e6712595-81bb-4829-8e42-9e2630fabcfe` through 11.1.58 (RSS summary; the full 11.x API notes were not seen) |
| **Next pass starts from** | the first spec newer than 10.3.58 that answers, and release notes after 11.1.58 |

Op references now point at the official versioned spec, not the community wiki:
`unifi_firewall.py` and `unifi_vlan.py` cite `https://apidoc-cdn.ui.com/network/v10.3.58/integration.json`
with the v1 path each op uses (#460). The other five op files still cite the wiki for legacy-only endpoints
(port profiles, fixed IPs, WLANs, devices, clients); their v1 equivalents are listed below.

| # | Class | Finding | Status |
|---|-------|---------|--------|
| 1 | BREAKING | v1 firewall policies were read from `/firewall-policies`; every published spec (10.1.68, 10.1.84, 10.3.58) has `/v1/sites/{siteId}/firewall/policies`, and no version has the hyphenated path. Probable cause of the 2026-07-03 live 404. | Fixed (#460): official path, plus `/firewall/zones`, paged at the spec's 200 maximum; v1 preferred, v2 then legacy kept as fallbacks for READS. For writes the firewall mode must be read positively (zone, legacy or unknown, `firewall_mode.py`): an error, an unreadable version or a malformed answer is unknown and refuses the write before any request. Live confirmation pending (owner probe F460-01). |
| 2 | BREAKING | `create_vlan` (v1 POST `/networks`) sent no `management` discriminator, no `cellularBackupEnabled` / `internetAccessEnabled` / `isolationEnabled`, no `ipv4Configuration.autoScaleEnabled`, no DHCP `leaseTimeSeconds` / `pingConflictDetectionEnabled`, and returned an empty id as `active` on a failed POST. | Fixed (#460): GATEWAY body checked offline against a vendored 10.3.58 schema subset (`engine/nimbus/providers/unifi/tests/fixtures/`); error answers raise. Sent only to Network 10.3.x controllers (10.1.x still requires `mdnsForwardingEnabled`, 10.0.x / 10.1.68 a `zoneId`); other lines are refused until an owner-run acceptance (F460-02/03) proves them. Each write body (network, network with DHCP, firewall policy) has its own verified-lines set, widened only by its own acceptance run. |
| 3 | CHANGED | Network 11.0.97 migrates every site to the Zone-Based Firewall; legacy `/rest/firewallrule` writes cannot express zone policies. | Fixed (#460): on zone-based controllers (11.x, or 10.x with a non-empty v1 zone list) create/delete go to v1 POST/DELETE `/firewall/policies`; a rule the legacy arguments cannot express exactly (one-sided, non-`LAN_IN`, protocol other than `all`) is refused; VLAN `--isolate` refuses before any write. Legacy controllers keep `/rest/firewallrule`. Whether `/rest/firewallrule` still answers on 11.x: pending (owner probe). |
| 4 | CHANGED | The v2 site API (`/v2/api/site/{site}/firewall-policies`, `/firewall/zone`) is undocumented; the official v1 now serves the same data. | v2 kept as a fallback only (#460). No deprecation published. |
| 5 | CHANGED | No deprecation schedule for the classic `/api/s/{site}/` API. v1 now covers WiFi broadcasts (10.1+), networks, devices, clients, ACL rules, DNS policies; port profiles, fixed-IP edits and AP/user groups have no v1 equivalent. | Open: WLAN and other legacy reads/writes stay on the classic API; revisit when a newer spec is readable. Gating those legacy writes on 11.x is follow-up #469. |
| 6 | NONE | v1 GET `/sites`, `/devices`, `/clients`, `/networks` and the `X-API-KEY` auth are unchanged from 9.1.120 / 10.0.162 through 10.3.58. | No action. Note: these lists are not paged (spec default page 25); a site with more than 25 clients is truncated. Pre-existing, outside #460. |

Not verified: specs for 10.4 to 11.1 (403); the full 11.x API notes; whether legacy `/rest/firewallrule` and
`/rest/wlanconf` work on 11.x after the PostgreSQL migration; that the 2026-07-03 404 was the hyphenated path;
whether a 10.x legacy-firewall controller answers v1 `/firewall/zones` with an empty list or an error (an
empty authenticated list reads as legacy; an error reads as unknown, so writes are refused).
