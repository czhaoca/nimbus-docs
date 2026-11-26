# CLI Docs Alignment Report — Proxmox

| Field | Value |
|-------|-------|
| **Provider** | Proxmox (`pve`) |
| **Last reviewed** | 2026-07-24T16:05:00Z |
| **Reviewed at commit** | *(pending commit)* |
| **Reviewed by** | cli-docs-alignment skill |
| **Ops audited** | 23 total, 23 with refs, 0 skipped |
| **SDK dependency** | N/A (REST API) |
| **Gaps found** | 0 |
| **PR** | *(pending)* |

## Reference Coverage

All `pve_*.py` operation descriptors now reference official `pve.proxmox.com/pve-docs/api-viewer` URLs.

| Op File | Ops | Status |
|---------|-----|--------|
| `pve_lxc.py` | 11 | ✅ aligned |
| `pve_network.py` | 2 | ✅ aligned |
| `pve_node.py` | 2 | ✅ aligned |
| `pve_storage.py` | 2 | ✅ aligned |
| `pve_vm.py` | 6 | ✅ aligned |

## Dependency Status

*(Skipped for Proxmox as it uses raw REST API requests without a Python SDK extra.)*

## API currency

| Field | Value |
|-------|-------|
| **Reviewed** | 2026-11-25 by update-provider-apis (#464) |
| **Locked -> latest** | No SDK: stdlib `urllib` against the PVE REST API (no package to lock). Node: pve-manager 9.2.28 (read with `pveversion` on 2026-11-25); latest release Proxmox VE 9.3 (2026-11-25) |
| **Changelog range reviewed** | PVE 9.0 (2025-08-05) .. 9.3 (2026-11-25) release notes, plus the PVE security advisories through PSA-2026-00102-1 (sources: https://pve.proxmox.com/wiki/Roadmap; the "Proxmox Virtual Environment Security Advisories" forum thread; qemu-server commits bd451bed and 443fcec6, pve-storage 626b13f8, pve-container 1581c6c9) |
| **Advisories** | PSA-2026-00035-1 (VM.PowerMgmt checked on container start-after-create; pve-container >= 6.1.12); PSA-2026-00070-1 (storage access check for `cicustom` snippet volumes, Datastore.AllocateSpace on the snippet storage; qemu-server >= 9.2.11); PSA-2026-00071-1 (VM.Config.Network no longer changes non-network cloud-init options; qemu-server >= 9.2.11). The 9.3 release bundles many more host-side PSAs: upgrading the node is a separate security action with no nimbus code change |
| **Findings** | CHANGED: POST /nodes/{node}/lxc with start=1 needs VM.PowerMgmt (in NimbusOps; doc row updated, #464). CHANGED: PUT /nodes/{node}/qemu/{vmid}/config with cicustom needs Datastore.AllocateSpace on /storage/{snippet_storage} (covered by the /storage grant; doc updated, #464). CHANGED: cloud-init auth options need VM.Config.Cloudinit (in the role). CHANGED (opt-in): PVE 9.3 cluster-wide API Token Policy; affects only new or extended tokens. NONE: no endpoint or parameter nimbus uses was removed or renamed in 9.0-9.3 (release notes; no full api-viewer schema diff); `cpus` is now always a number (adapter compatible); privileged containers need Sys.Modify (nimbus defaults to unprivileged=1) |
| **Live-only, not yet proven** | The token's effective privileges on /vms, /storage and each snippets storage (`pveum user token permissions` for nimbus's API token, per path); installed qemu-server and pve-container versions (whether the checks are enforced yet); whether a cluster API Token Policy is enabled. Owner-run read-only handoff: F464-01-probe then F464-02-verify |
