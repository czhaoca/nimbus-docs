---
title: Discord Bot
sidebar:
  order: 1
---

Set up the Nimbus Discord bot for ChatOps infrastructure management via slash commands.

:::tip[Quick discovery]
To list all configured chatbot platforms or smoke-test a wiring, use the
multi-platform facade:

```bash
nimbus chat list-platforms
nimbus chat run --platform discord --dry-run
```

`nimbus discord run` is the canonical ops command — it exposes the
Discord-specific flags (`sync` for slash-command registration). The
facade is for discovery and quickstart only.
:::

## Prerequisites

- A Discord server where you have **Manage Server** permissions
- Nimbus engine installed and configured

## 1. Create a Discord Application

1. Go to the [Discord Developer Portal](https://discord.com/developers/applications)
2. Click **New Application**, name it (e.g. "Nimbus Bot")
3. Navigate to the **Bot** tab in the left sidebar
4. Click **Reset Token** and copy the bot token — you will need this later

### Configure Intents

On the **Bot** tab, under **Privileged Gateway Intents**:

- **Message Content Intent** — leave **disabled** (the bot uses slash commands, not message content)
- All other intents can remain at their defaults

## 2. Invite the Bot to Your Server

1. Go to the **OAuth2** tab, then **URL Generator**
2. Under **Scopes**, select:
   - `bot`
   - `applications.commands`
3. Under **Bot Permissions**, select:
   - Send Messages
   - Embed Links
   - Use Slash Commands
4. Copy the generated URL and open it in your browser
5. Select your server and authorize

## 3. Store the Bot Token

Store the token in the vault (OpenBao) under path `/common/discord/1` with key `DISCORD_BOT_TOKEN`.

Alternatively, set the environment variable directly:

```bash
export DISCORD_BOT_TOKEN="your-token-here"
```

### Guild ID (Recommended)

For instant slash command availability (no 1-hour global sync delay), set the guild ID. Without this, commands sync globally and may take up to one hour to appear.

```bash
export DISCORD_GUILD_ID="your-guild-id"
```

**Important:** The guild ID must never be committed to source control.

To find your guild ID: enable Developer Mode in Discord settings, then right-click your server name and select **Copy Server ID**.

## 4. Run the Bot

```bash
# Using environment variable
nimbus discord run

# Or pass token directly
nimbus discord run --credential "your-token-here"

# Sync commands to guild (one-time setup)
nimbus discord sync
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/infra-status` | Infrastructure health summary |
| `/infra-resources [provider]` | List resources by provider |
| `/network-plan` | Show CIDR allocation tree |
| `/network-allocations` | List CIDR allocations |
| `/budget-spending [period]` | Current spending summary |
| `/oci-arm-status` | ARM capacity poller status |
| `/oci-vms` | List OCI compute instances |
| `/providers-list` | Show registered providers |
| `/deploy-status [project]` | Deployment slot status |

All commands are read-only (Tier 1). Action and admin commands will be available in future phases.

## Role configuration

Nimbus gates command access by role. `NimbusRole` defines three
privilege-ordered tiers (`viewer` < `operator` < `admin`):

| Role | Can do |
|------|--------|
| `viewer` | Tier-1 read commands (status, lists, plans) |
| `operator` | Everything `viewer` can, plus Tier-2 deploy ops (`deploy-up` / `deploy-down`) |
| `admin` | Reserved for future Tier-3 administrative commands |

Roles are resolved per caller from the `chat_user_mappings` table, keyed by the
composite `(platform, platform_user_id)`. For Discord, `platform` is `discord`
and `platform_user_id` is the caller's Discord user ID (the integer snowflake,
stored as a string). A row's `nimbus_role` must be one of `admin`, `operator`,
or `viewer` (lowercase, enforced by a CHECK constraint).

**Unmapped users degrade to `viewer` by default** — any user without a row, or
with an unrecognized role value, gets the safest (read-only) role. Tier-2/Tier-3
commands run a role check (e.g. `operator` for deploy ops) and reply with a
not-authorized message when the caller's role is insufficient.

To grant a user `operator`, insert a row into `chat_user_mappings`:

```sql
INSERT INTO chat_user_mappings (platform, platform_user_id, platform_user_name, nimbus_role)
VALUES ('discord', '000000000000000000', 'alice', 'operator');
```

:::note
There is currently no `nimbus` CLI command to manage chat-user roles — mappings
are populated directly in the database (or carried forward by migration). A
role-management CLI is a candidate future enhancement.
:::

## Troubleshooting

**Commands don't appear in Discord:**
Run `nimbus discord sync` to force-sync slash commands to your guild. Guild-scoped commands appear instantly; global commands can take up to one hour.

**Bot shows as offline:**
Verify the bot token is correct and the bot has been invited with the required scopes. Check logs for authentication errors.

**Permission errors:**
Ensure the bot has "Send Messages" and "Embed Links" permissions in the channels where you want to use it.
