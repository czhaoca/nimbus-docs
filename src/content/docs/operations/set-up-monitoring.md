---
title: "Set Up Monitoring"
sidebar:
  order: 5
---

# Set Up Monitoring

Configure health checks, alerts, WebSocket events, and resilience features.

:::note[Partial]
Health checks, alerts, resilience status, WebSocket support, and runner heartbeat
building blocks exist. Provider coverage and UI depth vary by provider and are
tracked in the roadmap and gap register.
:::

## Prerequisites

- Nimbus engine running (`nimbus serve` or `docker compose up`)
- At least one provider registered (`nimbus providers add`)
- Alert config: `cp templates/alerts.template.json local/config/alerts.json`

## 1. Health Check Configuration

```bash
# Basic health check (load balancers / uptime monitors)
curl http://localhost:8000/health
# Returns: {"status": "ok", "checks": {"database": "ok"}, "version": "..."}

# Provider health — checks adapter connectivity and measures latency
curl http://localhost:8000/api/providers/health/check
curl "http://localhost:8000/api/providers/health/check?provider_id=my-provider"

# Health history time-series for a provider
curl http://localhost:8000/api/providers/{provider_id}/health-history
```

A background probe loop (`provider_health_probe_loop`, started by the
engine alongside the other scheduled tasks) records one sample per
provider every 2 minutes and prunes rows older than
`health_probe_retention_days` (default 7) on each tick.

## 2. Alert Setup

Nimbus dispatches to webhook, Slack, Discord, and email channels.

```bash
# Check if alerts are configured
curl http://localhost:8000/api/alerts/config-status

# Update config via API
curl -X PUT http://localhost:8000/api/alerts/config \
  -H "Content-Type: application/json" \
  -d '{"webhooks": ["https://example.com/hook"], "enabled_channels": ["webhook"]}'

# Send a test alert to all configured destinations
curl -X POST http://localhost:8000/api/alerts/test \
  -H "Content-Type: application/json" \
  -d '{"title": "Test alert from Nimbus"}'
```

```bash
# Create an alert rule (spending > $100 triggers warning)
curl -X POST http://localhost:8000/api/alerts/rules \
  -H "Content-Type: application/json" \
  -d '{"name": "High spend", "metric": "spending", "operator": "gt", "threshold": 100, "severity": "warning"}'

# List / delete rules
curl http://localhost:8000/api/alerts/rules
curl -X DELETE http://localhost:8000/api/alerts/rules/{rule_id}
```

Valid metrics: `spending`, `resource_count`, `health_status`. Operators: `gt`, `lt`, `eq`.

## 3. WebSocket Real-Time Events

```javascript
const ws = new WebSocket("ws://localhost:8000/ws");
ws.onmessage = (event) => {
  const data = JSON.parse(event.data);
  // data.type === "resource_change"
  // data.action, data.resource_id, data.provider_id
};
// Keep-alive: server responds to "ping" with {"type": "pong"}
setInterval(() => ws.send("ping"), 30000);
```

Events broadcast on resource create, update, and delete operations,
including the bulk-action, sync, single-resource action (start / stop /
terminate / health_check), and workflow-engine create paths.

## 4. Circuit Breaker and Retry Mechanisms

**Circuit Breaker** states: `closed` (normal) -> `open` (rejects calls after 5 failures) -> `half_open` (probes recovery after 60s).

**Retry** applies exponential backoff: 3 attempts, 1s base delay, 2x multiplier, 30s cap, with jitter.

```bash
# View circuit breaker + error status for all providers
curl http://localhost:8000/api/providers/status/resilience

# Credential health for a specific provider
curl http://localhost:8000/api/providers/{provider_id}/credential-status
```

## 5. Provider Health Monitoring

```bash
# Create a health check alert rule
curl -X POST http://localhost:8000/api/health/alerts \
  -H "Content-Type: application/json" \
  -d '{"check_type": "http", "threshold": 3, "notify_channel": "webhook"}'

# List health alert rules
curl http://localhost:8000/api/health/alerts
```

In the UI, navigate to **Monitoring > Provider Health** for real-time status and latency charts.

:::tip[API Reference]
See [Health API](/api/health) and [Alerts API](/api/alerts) for full endpoint docs.
:::
