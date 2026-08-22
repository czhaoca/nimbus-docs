---
title: Slack Bot
sidebar:
  order: 4
---

Set up the Nimbus Slack bot for ChatOps infrastructure management via slash commands over Socket Mode.

:::tip[Quick discovery]
To list all configured chatbot platforms or smoke-test a wiring, use the
multi-platform facade:

```bash
nimbus chat list-platforms
nimbus chat run --platform slack --dry-run
```

`nimbus slack run` is the canonical ops command — it accepts the optional
`--credential` flag to pass the bot token directly. Slack uses Socket Mode
(an outbound WebSocket), so there is no `--host`/`--port` to bind. The
facade is for discovery and quickstart only.
:::

## Prerequisites

- A Slack workspace where you can install apps (or admin approval to do so)
- Nimbus engine installed and configured

## 1. Create a Slack Application

1. Go to the [Slack API portal](https://api.slack.com/apps)
2. Click **Create New App**, then choose **From scratch** (or **From an app manifest** — see below)
3. Name it (e.g. "Nimbus Bot") and pick your workspace

### Create From a Manifest (Optional)

To pre-configure Socket Mode, scopes, and slash commands in one step, use
**From an app manifest** and paste a manifest. Adjust scopes and command
names to taste; the command names are owner-defined in the Slack UI and
Nimbus expects them prefixed `/nimbus-`.

```yaml
display_information:
  name: Nimbus Bot
features:
  bot_user:
    display_name: nimbus
    always_online: true
oauth_config:
  scopes:
    bot:
      - commands
      - chat:write
settings:
  socket_mode_enabled: true
  interactivity:
    is_enabled: true
```

The `bot` scopes above (`commands`, `chat:write`) are **inferred from
Slack's own slash-command and Block Kit requirements**, not pinned by the
Nimbus source — register the scopes Slack asks for as you add features.

### Enable Socket Mode

1. In the left sidebar, open **Socket Mode** and toggle it **on**
2. Slack will prompt you to generate an **App-Level Token** with the
   `connections:write` scope — this is the `SLACK_APP_TOKEN` (prefix
   `xapp-`). Copy it; you will need it later.

Slack transports run **Socket Mode only** (outbound WebSocket via
`slack_bolt` `AsyncApp` + `AsyncSocketModeHandler`). The adapter exposes no
inbound HTTP webhook router, so **no public URL or Cloudflare Tunnel is
required** — unlike the Telegram-webhook, WhatsApp, or Synology integrations.

## 2. Install the App and Capture the Tokens

Slack uses **two distinct tokens**:

| Token | Env var | Prefix | Purpose |
|-------|---------|--------|---------|
| Bot User OAuth Token | `SLACK_BOT_TOKEN` | `xoxb-` | Constructs the `slack_bolt` `AsyncApp`; authenticates replies |
| App-Level Token | `SLACK_APP_TOKEN` | `xapp-` | Required **only** for Socket Mode (scope `connections:write`) |

1. Open **OAuth & Permissions** in the left sidebar
2. Confirm the **Bot Token Scopes** include `commands` and `chat:write`
   (and any others your slash commands need)
3. Click **Install to Workspace** and authorize
4. Copy the **Bot User OAuth Token** (prefix `xoxb-`) — this is
   `SLACK_BOT_TOKEN`

## 3. Register Slash Commands

Slack requires each slash command to be declared in the app config (the
**Slash Commands** page, or via the manifest). Nimbus registers each
Tier-1 read command as `/nimbus-<command>` and the deploy ops as
`/nimbus-deploy-up` and `/nimbus-deploy-down`.

Create commands such as:

```
/nimbus-infra-status   Infrastructure health summary
/nimbus-network-plan   Show CIDR allocation tree
/nimbus-deploy-up      Deploy a reserved slot (operator)
/nimbus-deploy-down    Tear down a slot (operator)
```

Slash command names are **hyphenated** (`/nimbus-infra-status`), not
underscored. The exact command names are owner-defined in the Slack UI;
Nimbus matches the `/nimbus-` prefix.

## 4. Store the Tokens

Store both tokens in the vault (OpenBao) under path `/common/chat/slack/1`:

| Key | Value |
|-----|-------|
| `SLACK_BOT_TOKEN` | Your bot token (prefix `xoxb-`) |
| `SLACK_APP_TOKEN` | Your app-level token (prefix `xapp-`) |

The trailing `/1` is the vault's numbered-secret index, matching the
`SLACK_1_BOT_TOKEN` fallback the CLI checks after `SLACK_BOT_TOKEN`.

Alternatively, set the environment variables directly:

```bash
export SLACK_BOT_TOKEN="xoxb-XXXXXXXX"
export SLACK_APP_TOKEN="xapp-XXXXXXXX"
```

### Token Resolution Order

`SLACK_BOT_TOKEN` is resolved from `--credential` first, then the
`SLACK_BOT_TOKEN` env var, then `SLACK_1_BOT_TOKEN` (the Infisical
numbered fallback). `SLACK_APP_TOKEN` is read from the environment only —
if it is unset when Socket Mode starts, the bot raises
`RuntimeError: SLACK_APP_TOKEN (xapp-...) is required for Socket Mode but is not set`.

**Important:** Real `xoxb-`/`xapp-` token values must never be committed to
source control. Use placeholders in any committed example.

## 5. Run the Bot

```bash
# Using environment variables
nimbus slack run

# Or pass the bot token directly (app token still read from env)
nimbus slack run --credential "xoxb-XXXXXXXX"
```

The CLI calls `SlackChatbotAdapter().start(...)`, which opens the Socket
Mode connection and blocks. There is no bind address — Socket Mode is an
outbound WebSocket.

## Available Commands

| Command | Description |
|---------|-------------|
| `/nimbus-infra-status` | Infrastructure health summary |
| `/nimbus-infra-resources [provider]` | List resources by provider |
| `/nimbus-network-plan` | Show CIDR allocation tree |
| `/nimbus-network-allocations` | List CIDR allocations |
| `/nimbus-budget-spending [period]` | Current spending summary |
| `/nimbus-oci-arm-status` | ARM capacity poller status |
| `/nimbus-oci-vms` | List OCI compute instances |
| `/nimbus-providers-list` | Show registered providers |
| `/nimbus-deploy-status [project]` | Deployment slot status |
| `/nimbus-deploy-up` | Deploy a reserved slot (operator) |
| `/nimbus-deploy-down` | Tear down a slot (operator) |

Read commands (Tier 1) reply with Block Kit blocks (header / section /
fields / context) and are not role-gated. Every handler acknowledges
within 3 seconds before doing slow work.

### Interactive Confirmation

Unlike webhook-only platforms, Slack has **interactive Block Kit buttons**.
The deploy ops (`/nimbus-deploy-up`, `/nimbus-deploy-down`) first reply
with a dry-run preview carrying **Confirm** and **Cancel** buttons
(action IDs `nimbus_deploy_confirm` / `nimbus_deploy_cancel`). Pressing
**Confirm** re-checks your role and then executes the deploy. Because Slack
action values are not length-capped, no separate text-confirm token store
is needed (contrast with Synology, which has no buttons and uses a text
`confirm <token>` flow).

## Role configuration

Tier-1 read commands are open to everyone. The Tier-2 deploy operations
(`/nimbus-deploy-up`, `/nimbus-deploy-down`, and the **Confirm** button)
are gated to the **operator** role. Roles are resolved per platform from
the `chat_user_mappings` table by `(platform, platform_user_id)` — for
Slack the `platform_user_id` is the Slack user id (`U...`).

| Role | Privilege | Can do |
|------|-----------|--------|
| `viewer` | 1 | Tier-1 read commands |
| `operator` | 2 | Tier-1 reads **plus** Tier-2 `deploy-up` / `deploy-down` |
| `admin` | 3 | Reserved for future Tier-3 administrative commands |

Any user without a mapping row — or with an unrecognized role value —
defaults to **viewer** (the safest default). A denied operator action
replies with `:no_entry: <role> role required — not authorized.`

To grant a user a higher role, insert (or update) a row in the
`chat_user_mappings` table with `platform = 'slack'`, the user's Slack id
as `platform_user_id`, and `nimbus_role` set to one of `admin`, `operator`,
or `viewer` (lowercase, enforced by a CHECK constraint):

```sql
INSERT INTO chat_user_mappings (platform, platform_user_id, nimbus_role)
VALUES ('slack', 'U0XXXXXXX', 'operator');
```

There is no `nimbus chat`/`nimbus slack` subcommand to manage these
mappings yet — populate the table directly until a management CLI lands.

## Troubleshooting

**`RuntimeError: SLACK_APP_TOKEN (xapp-...) is required for Socket Mode`:**
The app-level token is missing. Generate one with the `connections:write`
scope from the **Socket Mode** page and export it as `SLACK_APP_TOKEN`.

**Bot connects but slash commands do nothing:**
Confirm each command is registered in the Slack app config as
`/nimbus-<command>` and that **Interactivity** is enabled (required for the
deploy Confirm/Cancel buttons).

**`not_authed` / `invalid_auth` on startup:**
The `SLACK_BOT_TOKEN` (`xoxb-`) is missing or wrong. Check the resolution
order — `--credential`, then `SLACK_BOT_TOKEN`, then `SLACK_1_BOT_TOKEN`.

**Deploy command denied unexpectedly:**
Your Slack user id is not mapped to `operator`. Add a `chat_user_mappings`
row (see [Role configuration](#role-configuration)); unmapped users are
viewers by default.
