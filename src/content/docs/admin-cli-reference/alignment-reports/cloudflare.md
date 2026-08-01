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
