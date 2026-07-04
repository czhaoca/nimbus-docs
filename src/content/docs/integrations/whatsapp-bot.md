---
title: WhatsApp Bot
sidebar:
  order: 3
---

Set up the Nimbus WhatsApp bot for infrastructure management via the WhatsApp Cloud API.

:::tip[Quick discovery]
To list all configured chatbot platforms, use the multi-platform facade:

```bash
nimbus chat list-platforms
```

WhatsApp is webhook-driven and does not have a long-lived adapter, so
`nimbus chat run --platform whatsapp` is not supported. Run the
standalone webhook server with `nimbus whatsapp run --host ... --port ...`
or mount it via the Nimbus API server (see below). The facade is for
platform discovery only on this integration.
:::

## Prerequisites

- A [Meta for Developers](https://developers.facebook.com/) account
- A Meta Business App (or willingness to create one)
- A publicly reachable HTTPS URL for webhooks (e.g. via Cloudflare Tunnel)
- Nimbus engine installed and configured

## 1. Create a Meta Business App

1. Go to [Meta for Developers](https://developers.facebook.com/) and log in
2. Click **My Apps** -> **Create App**
3. Select **Business** as the app type
4. Fill in the app name (e.g. "Nimbus Bot") and contact email
5. Click **Create App**

## 2. Add the WhatsApp Product

1. In your app dashboard, click **Add Product**
2. Find **WhatsApp** and click **Set Up**
3. You'll be taken to the WhatsApp **Getting Started** page

### Get Your Credentials

From the WhatsApp Getting Started page, note:

- **Phone Number ID** — the ID of the test phone number Meta provides
- **Temporary Access Token** — valid for 24 hours (for initial testing)

For production, generate a **permanent token**:

1. Go to **Business Settings** -> **System Users**
2. Create a system user with Admin role
3. Click **Generate New Token**
4. Select your WhatsApp app
5. Grant permissions: `whatsapp_business_messaging`, `whatsapp_business_management`
6. Copy the token

## 3. Store Credentials

Store in Infisical under path `/common/whatsapp/1`:

| Key | Value |
|-----|-------|
| `WHATSAPP_ACCESS_TOKEN` | Your permanent access token |
| `WHATSAPP_PHONE_NUMBER_ID` | Your phone number ID |
| `WHATSAPP_VERIFY_TOKEN` | A secret string you choose for webhook verification |
| `WHATSAPP_APP_SECRET` | Your Meta app's secret key (for HMAC signature verification) |

Or set environment variables:

```bash
export WHATSAPP_ACCESS_TOKEN="your-token"
export WHATSAPP_PHONE_NUMBER_ID="your-phone-id"
export WHATSAPP_VERIFY_TOKEN="your-chosen-secret"
export WHATSAPP_APP_SECRET="your-app-secret"
```

### Finding Your App Secret

1. Go to your Meta app dashboard -> **Settings** -> **Basic**
2. Under **App Secret**, click **Show** and copy the value
3. This is used to verify that incoming webhook requests actually came from Meta (HMAC-SHA256 signature verification)

## 4. Configure the Webhook

1. In your Meta app dashboard, go to **WhatsApp** -> **Configuration**
2. Under **Webhook**, click **Edit**
3. Set the **Callback URL** to:
   ```
   https://your-domain.com/api/chatbot/whatsapp/webhook
   ```
4. Set the **Verify Token** to the same value as your `WHATSAPP_VERIFY_TOKEN`
5. Click **Verify and Save**
6. Under **Webhook Fields**, subscribe to the `messages` field

### Using Cloudflare Tunnel

If your Nimbus API is behind a Cloudflare Tunnel:

1. Ensure the tunnel routes to your Nimbus API server (default port 8000)
2. The webhook path will be: `https://<tunnel-domain>/api/chatbot/whatsapp/webhook`
3. Meta will send a verification GET request first, then POST messages

## 5. Run the Bot

### As Part of the Nimbus API Server

When running `nimbus serve`, the WhatsApp webhook is automatically mounted. No separate process needed.

### Standalone Mode

For development or isolated deployment:

```bash
nimbus whatsapp run --port 8001
```

This starts a lightweight FastAPI server with only the WhatsApp webhook routes.

## Sending Commands

Send text messages to your WhatsApp bot number. Commands are parsed from the message text:

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

You can prefix commands with `/` or `!` — they are stripped automatically. Unrecognized messages return the help text.

## Role configuration

Nimbus gates command access by role. `NimbusRole` defines three
privilege-ordered tiers (`viewer` < `operator` < `admin`):

| Role | Can do |
|------|--------|
| `viewer` | Tier-1 read commands (status, lists, plans) |
| `operator` | Everything `viewer` can, plus Tier-2 deploy ops (`deploy-up` / `deploy-down`) |
| `admin` | Reserved for future Tier-3 administrative commands |

Roles are resolved per caller from the `chat_user_mappings` table, keyed by the
composite `(platform, platform_user_id)`. For WhatsApp, `platform` is `whatsapp`
and `platform_user_id` is the sender's phone number (stored as a string). A
row's `nimbus_role` must be one of `admin`, `operator`, or `viewer` (lowercase,
enforced by a CHECK constraint).

**Unmapped users degrade to `viewer` by default** — any user without a row, or
with an unrecognized role value, gets the safest (read-only) role. Tier-2/Tier-3
commands run a role check (e.g. `operator` for deploy ops) and reply with a
not-authorized message when the caller's role is insufficient.

To grant a user `operator`, insert a row into `chat_user_mappings`:

```sql
INSERT INTO chat_user_mappings (platform, platform_user_id, platform_user_name, nimbus_role)
VALUES ('whatsapp', '15555550100', 'alice', 'operator');
```

:::note
There is currently no `nimbus` CLI command to manage chat-user roles — mappings
are populated directly in the database (or carried forward by migration). A
role-management CLI is a candidate future enhancement.
:::

## Test Phone Number

Meta provides a test phone number for development. To test:

1. Go to **WhatsApp** -> **Getting Started** in your app dashboard
2. Under **Send and Receive Messages**, add your personal number as a recipient
3. Send a message from Meta's test panel first to initiate the conversation
4. Then send commands from your phone to the test number

## Production Phone Number

For production:

1. Register a real phone number in **WhatsApp** -> **Phone Numbers**
2. Complete business verification in Meta Business Suite
3. Update `WHATSAPP_PHONE_NUMBER_ID` to the new phone number ID

## Troubleshooting

**Webhook verification fails:**
Ensure `WHATSAPP_VERIFY_TOKEN` matches exactly between your environment and the Meta dashboard. The callback URL must be HTTPS.

**Bot doesn't reply:**
Check that `WHATSAPP_ACCESS_TOKEN` and `WHATSAPP_PHONE_NUMBER_ID` are set. Look for "WhatsApp API error" in logs.

**Messages not arriving:**
Ensure you've subscribed to the `messages` webhook field. For test numbers, you must initiate the conversation from the Meta test panel first.

**Token expired:**
Temporary tokens expire after 24 hours. Generate a permanent system user token for production use (see Step 2).
