---
title: Telegram Bot
sidebar:
  order: 2
---

Set up the Nimbus Telegram bot for infrastructure management via chat commands.

:::tip[Quick discovery]
To list all configured chatbot platforms or smoke-test a wiring, use the
multi-platform facade:

```bash
nimbus chat list-platforms
nimbus chat run --platform telegram --dry-run
```

`nimbus telegram run` is the canonical ops command — it exposes the
Telegram-specific `--mode polling|webhook` flag. The facade is for
discovery and quickstart only.
:::

## Prerequisites

- A Telegram account
- Nimbus engine installed and configured

## 1. Create a Telegram Bot

1. Open Telegram and message [@BotFather](https://t.me/BotFather)
2. Send `/newbot`
3. Follow the prompts:
   - Enter a **name** for your bot (e.g. "Nimbus Infra Bot")
   - Enter a **username** ending in `bot` (e.g. `nimbus_infra_bot`)
4. BotFather will reply with your **bot token** — copy it

### Set Bot Commands (Optional)

Tell BotFather about the available commands so Telegram shows them in the command menu:

```
/setcommands
```

Then select your bot and paste:

```
infra_status - Infrastructure health summary
infra_resources - List resources by provider
network_plan - Show CIDR allocation tree
network_allocations - List CIDR allocations
budget_spending - Current spending summary
oci_arm_status - ARM capacity poller status
oci_vms - List OCI compute instances
providers_list - Show registered providers
deploy_status - Deployment slot status
help - List available commands
```

Note: Telegram commands use underscores, not hyphens.

## 2. Store the Bot Token

Store the token in the vault (OpenBao) under path `/common/telegram/1` with key `TELEGRAM_BOT_TOKEN`.

Or set the environment variable:

```bash
export TELEGRAM_BOT_TOKEN="your-token-here"
```

## 3. Choose a Run Mode

### Polling Mode (Recommended for Getting Started)

The bot connects to Telegram's servers and polls for updates. No public URL needed.

```bash
nimbus telegram run --mode polling
```

### Webhook Mode (Production)

Telegram pushes updates to your server via HTTPS. Requires a publicly reachable URL (e.g. via Cloudflare Tunnel).

```bash
nimbus telegram run --mode webhook
```

#### Webhook Setup Steps

1. Ensure your Nimbus API is reachable at a public HTTPS URL
2. If using Cloudflare Tunnel, point a tunnel to your Nimbus API server
3. Set the webhook URL via the Telegram API:

```bash
curl -X POST "https://api.telegram.org/bot<YOUR_TOKEN>/setWebhook" \
  -d "url=https://your-domain.com/api/chatbot/telegram/webhook"
```

4. Verify the webhook is set:

```bash
curl "https://api.telegram.org/bot<YOUR_TOKEN>/getWebhookInfo"
```

When running as part of the Nimbus API server (`nimbus serve`), the webhook route is automatically mounted at `/api/chatbot/telegram/webhook`.

## Available Commands

| Command | Description |
|---------|-------------|
| `/infra_status` | Infrastructure health summary |
| `/infra_resources [provider]` | List resources by provider |
| `/network_plan` | Show CIDR allocation tree |
| `/network_allocations` | List CIDR allocations |
| `/budget_spending [period]` | Current spending summary |
| `/oci_arm_status` | ARM capacity poller status |
| `/oci_vms` | List OCI compute instances |
| `/providers_list` | Show registered providers |
| `/deploy_status [project]` | Deployment slot status |
| `/start` | Show help / available commands |

Pass arguments after the command: `/infra_resources oci` or `/deploy_status nimbus`.

## Role configuration

Nimbus gates command access by role. `NimbusRole` defines three
privilege-ordered tiers (`viewer` < `operator` < `admin`):

| Role | Can do |
|------|--------|
| `viewer` | Tier-1 read commands (status, lists, plans) |
| `operator` | Everything `viewer` can, plus Tier-2 deploy ops (`deploy-up` / `deploy-down`) |
| `admin` | Reserved for future Tier-3 administrative commands |

Roles are resolved per caller from the `chat_user_mappings` table, keyed by the
composite `(platform, platform_user_id)`. For Telegram, `platform` is `telegram`
and `platform_user_id` is the caller's numeric Telegram user ID (stored as a
string). A row's `nimbus_role` must be one of `admin`, `operator`, or `viewer`
(lowercase, enforced by a CHECK constraint).

**Unmapped users degrade to `viewer` by default** — any user without a row, or
with an unrecognized role value, gets the safest (read-only) role. Tier-2/Tier-3
commands run a role check (e.g. `operator` for deploy ops) and reply with a
not-authorized message when the caller's role is insufficient.

To grant a user `operator`, insert a row into `chat_user_mappings`:

```sql
INSERT INTO chat_user_mappings (platform, platform_user_id, platform_user_name, nimbus_role)
VALUES ('telegram', '000000000', 'alice', 'operator');
```

:::note
There is currently no `nimbus` CLI command to manage chat-user roles — mappings
are populated directly in the database (or carried forward by migration). A
role-management CLI is a candidate future enhancement.
:::

## Troubleshooting

**Bot doesn't respond to commands:**
In polling mode, ensure the bot process is running. In webhook mode, verify the webhook URL is correct and reachable.

**"Unauthorized" error on startup:**
The bot token is incorrect. Regenerate it via BotFather with `/token`.

**Webhook returns 500:**
Ensure `TELEGRAM_BOT_TOKEN` is set in the environment where the API server runs.
