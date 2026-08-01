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

All `unifi_*.py` operation descriptors now reference community-standard `ubntwiki.com` API endpoint references.

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
