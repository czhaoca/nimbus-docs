---
title: Chatbots Overview
sidebar:
  order: 0
---

Nimbus ships a multi-platform chatbot runtime with adapters for Discord,
Telegram, WhatsApp, Slack, and Synology Chat. Two CLI surfaces sit on top of
that runtime:

- **`nimbus chat`** — the multi-platform facade. Use it to discover which
  platforms are registered and to smoke-test a single platform without
  remembering its specific flags.
- **`nimbus discord` / `nimbus telegram` / `nimbus whatsapp` / `nimbus slack`
  / `nimbus synology`** — the per-platform CLIs. Use these for production ops,
  because they expose the flags each platform actually needs.

The runtime supervisor (`_start_bot_supervisors` in the FastAPI
lifespan) starts long-lived bots automatically when their credentials
are present in the environment. The CLIs are for dev, debugging, and
manual one-shot launches.

## Facade — discovery and quickstart

List all registered chatbot platforms:

```bash
nimbus chat list-platforms
```

Smoke-test a single platform without starting a long-lived connection.
This resolves the adapter class and the credential but skips the actual
`.start()` call:

```bash
nimbus chat run --platform discord --dry-run
nimbus chat run --platform telegram --dry-run
```

Run a platform with default settings (no platform-specific flags). Use
this only for quick local checks — switch to the per-platform CLI for
anything you want to deploy:

```bash
nimbus chat run --platform discord
nimbus chat run --platform telegram
```

The facade pulls credentials from `${PLATFORM}_BOT_TOKEN` or
`${PLATFORM}_1_BOT_TOKEN` (the Infisical numbered pattern). WhatsApp
needs more credentials than a single bot token, so `chat run --platform
whatsapp` is unsupported — see the [WhatsApp page](./whatsapp-bot.md)
for the canonical launch path.

## Per-platform CLIs — production ops

Each platform has flags the facade doesn't expose:

| Platform | Canonical command | Platform-specific flags |
|----------|-------------------|--------------------------|
| Discord  | `nimbus discord run` | `nimbus discord sync` (slash-command registration) |
| Telegram | `nimbus telegram run` | `--mode polling\|webhook` |
| WhatsApp | `nimbus whatsapp run` | `--host`, `--port` (webhook server) |
| Slack    | `nimbus slack run` | Socket Mode — outbound WebSocket, no bind address |
| Synology | `nimbus synology run` | `--host`, `--port` (webhook server) |

Configure credentials and run setup steps in the per-platform pages:

- [Discord Bot](./discord-bot.md)
- [Telegram Bot](./telegram-bot.md)
- [WhatsApp Bot](./whatsapp-bot.md)
- [Slack Bot](./slack-bot.md)
- [Synology Chat Bot](./synology-chat-bot.md)

## When the runtime supervisor takes over

When the Nimbus API server boots (`nimbus serve`), the FastAPI lifespan
spawns one supervised task per platform whose credentials are present
in the environment. That path is independent of the CLI — you do not
need to invoke `nimbus discord run` to keep the bot alive in a
governed deployment, because the API server already manages it.

Use the CLIs when you want to:

- Run a bot outside the API server (isolated process, dev laptop).
- Sync Discord slash commands one-off (`nimbus discord sync`).
- Run the WhatsApp webhook standalone behind a separate Cloudflare
  Tunnel.
- Verify a platform is wired correctly via `nimbus chat run
  --platform X --dry-run` before flipping the credential into prod.
