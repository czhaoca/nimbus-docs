---
title: Synology Chat Bot
sidebar:
  order: 5
---

Set up the Nimbus Synology Chat bot for infrastructure management via Synology Chat incoming and outgoing webhooks.

:::tip[Quick discovery]
To list all configured chatbot platforms, use the multi-platform facade:

```bash
nimbus chat list-platforms
```

Synology Chat is webhook-driven and does not have a long-lived adapter, so
`nimbus chat run --platform synology` is not supported. Run the standalone
webhook server with `nimbus synology run --host ... --port ...` or mount it
via the Nimbus API server (see below). The facade is for platform discovery
only on this integration.
:::

## Prerequisites

- A Synology DSM with the **Chat** package installed and admin access to it
- A publicly reachable HTTPS URL for the outgoing webhook (e.g. via Cloudflare Tunnel)
- Nimbus engine installed and configured

## 1. Create the Synology Chat Integration

Synology Chat connects to Nimbus through two webhooks that move in opposite directions:

- **Outgoing webhook** (Synology -> Nimbus) — delivers each user message to Nimbus and renders the bot's reply back into the channel.
- **Incoming webhook** (Nimbus -> Synology) — the proactive feed/alert sink that lets Nimbus push messages into a channel on its own.

There is no SDK and no native slash-command registry: Synology Chat speaks the documented Chat REST API only. Set up the outgoing webhook first (it is the request/response path), then optionally add the incoming webhook for alerts.

### Configure the Outgoing Webhook

1. In Synology Chat, open the channel you want the bot to listen in
2. Open the channel **Integration** menu and choose **Outgoing Webhook**
3. Set the **Outgoing URL** to your public Nimbus path:
   ```
   https://chat.example.test/api/chatbot/synology/webhook
   ```
4. Save the integration — Synology generates a **token** for this webhook. Copy it; you will store it as `SYNOLOGY_TOKEN` in the next step.

The outgoing webhook posts each message to Nimbus as `application/x-www-form-urlencoded` with the fields `token`, `user_id`, `username`, and `text`. The bot's reply is the JSON response body (`{"text": ...}`), which Synology renders back into the channel as a synchronous reply — there is no separate send call for replies.

### Configure the Incoming Webhook (Optional)

For proactive alerts (the feed sink), create an **Incoming Webhook** on the channel and copy its URL/token into the Nimbus feed sink configuration. This is the Nimbus -> Synology push path, distinct from the synchronous reply above. The code does not read the incoming-webhook URL/token from a named environment variable; configure it wherever your feed sink is wired.

## 2. Expose the Webhook Publicly

The outgoing webhook is inbound HTTP, so Nimbus needs a public HTTPS endpoint.

### Using Cloudflare Tunnel

If your Nimbus API is behind a Cloudflare Tunnel:

1. Ensure the tunnel routes to your Nimbus API server (default port 8000), or to the standalone Synology server (default port 8002)
2. The webhook path will be: `https://<tunnel-domain>/api/chatbot/synology/webhook`
3. Set this full path as the **Outgoing URL** in the Synology Chat integration

## 3. Store the Token

Store the outgoing-webhook token in Infisical under path `/common/chat/synology/1` with key `SYNOLOGY_TOKEN`.

| Key | Value |
|-----|-------|
| `SYNOLOGY_TOKEN` | The Synology-generated token for the outgoing webhook (shared secret) |

Alternatively, set the environment variable directly:

```bash
export SYNOLOGY_TOKEN="<your-synology-token>"
```

Nimbus verifies this token in constant time (`hmac.compare_digest`) against either the form field `token` or an `x-synology-token` request header.

:::caution[Fail-open verification]
If `SYNOLOGY_TOKEN` is **unset**, Nimbus logs `SYNOLOGY_TOKEN not set — skipping verification` and treats the request as authenticated (verification is skipped — the webhook is open). Always set `SYNOLOGY_TOKEN` in any environment that is reachable from the network.
:::

**Important:** The token must never be committed to source control.

## 4. Run the Bot

### As Part of the Nimbus API Server

When running `nimbus serve`, the Synology Chat webhook is mounted automatically. No separate process needed.

### Standalone Mode

For development or isolated deployment:

```bash
nimbus synology run --host 0.0.0.0 --port 8002
```

This starts a lightweight FastAPI + uvicorn server titled "Nimbus Synology Chat Bot" with only the Synology webhook routes. The defaults are `--host 0.0.0.0` and `--port 8002`.

## Sending Commands

Synology Chat has no native slash-command registry and no interactive buttons, so "commands" are plain text the outgoing webhook forwards to Nimbus. A leading `/` or `!` is stripped automatically, and the first token is matched against the shared command list (prefix matches are accepted); anything unrecognized returns the help text.

| Message | Description |
|---------|-------------|
| `infra-status` | Infrastructure health summary |
| `infra-resources oci` | List OCI resources |
| `network-plan` | Show CIDR allocation tree |
| `network-allocations` | List CIDR allocations |
| `budget-spending` | Current spending summary |
| `oci-arm-status` | ARM capacity poller status |
| `oci-vms` | List OCI compute instances |
| `providers-list` | Show registered providers |
| `deploy-status nimbus` | Nimbus deployment status |
| `help` | List available commands |

Unlike Discord (`sync`) or Telegram (`setcommands`), there is no per-command registration step — the outgoing webhook simply forwards message text and Nimbus matches it against the registry-derived command list.

### Capabilities and Degradation

Replies use the Synology Chat markdown subset via the Nimbus formatter: `**bold**`, `_italic_`, inline `` `code` ``, fenced code blocks, and `<URL|label>` angle-bracket links. Because Synology has no attachment color bar, message color maps to a leading emoji (green ✅, orange ⚠️, red ❌, blue ℹ️, gray ▫️).

Synology Chat has **no interactive buttons**, so Tier-2 deploy operations cannot use a Confirm/Cancel button flow the way Slack does. Instead, `deploy-up` and `deploy-down` use a **text-confirm flow**:

1. The dry-run reply issues a short confirmation token.
2. You reply `confirm <token>` (or `cancel <token>`) in the channel.
3. Nimbus re-checks your role, consumes the token, and runs the deploy off-thread.

An expired or already-used token returns `That confirmation has expired or was already used.`

## Role configuration

Commands are gated by a Nimbus role attached to each chat user. There are three privilege-ordered roles; a command runs only when the user's role is at least the level the command requires.

| Role | Level | Can do |
|------|-------|--------|
| `viewer` | 1 | Tier-1 read commands (status, resources, network, budget, deploy-status) |
| `operator` | 2 | Everything a viewer can, plus Tier-2 `deploy-up` / `deploy-down` |
| `admin` | 3 | Reserved for future Tier-3 administrative commands |

Roles are looked up from the `chat_user_mappings` table by `(platform, platform_user_id)`. For Synology, `platform` is `synology` and `platform_user_id` is the Synology Chat `user_id` field (a string). **Any user without a mapping row — or with an unrecognized role value — is treated as a `viewer`** (the safest default), so granting elevated access is always an explicit action.

To grant a user the operator role, insert a row into `chat_user_mappings`:

| Column | Value |
|--------|-------|
| `platform` | `synology` |
| `platform_user_id` | the Synology Chat `user_id` string |
| `platform_user_name` | display name (optional) |
| `nimbus_role` | one of `admin`, `operator`, `viewer` (stored lowercase) |

A denied command replies with a ❌-prefixed "role required" message.

:::note
There is no `nimbus chat set-role` (or equivalent) management CLI yet — role rows are seeded via migration or inserted directly into `chat_user_mappings`. A management command is a candidate gap.
:::

## Troubleshooting

**The webhook is open / unverified:**
Set `SYNOLOGY_TOKEN` in the environment. When it is unset, Nimbus logs `SYNOLOGY_TOKEN not set — skipping verification` and accepts every request. Confirm the value matches the token Synology generated for the outgoing webhook.

**Bot doesn't reply:**
Verify the outgoing webhook **Outgoing URL** points at `.../api/chatbot/synology/webhook` over HTTPS and that the standalone server (or `nimbus serve`) is reachable from Synology. Check logs for token-mismatch warnings.

**Deploy commands don't run:**
`deploy-up` / `deploy-down` require the `operator` role. Confirm a `chat_user_mappings` row exists for your `synology` `user_id` with `nimbus_role` set to `operator` (or `admin`). Also confirm you replied with the exact `confirm <token>` text before the token expired.

**Commands not recognized:**
Messages match the first token against the shared command list. Send `help` to list the available commands; a leading `/` or `!` is stripped automatically.
