---
title: "Set Up CI/CD"
sidebar:
  order: 8
---

# Set Up CI/CD

Nimbus uses self-hosted Woodpecker CI on Proxmox as the governed CI/CD system.
The canonical ephemeral cron/job runner strategy is Woodpecker LXC agents
managed as runner resources, separate from governed app environment slots.

:::note[Canonical Runner Strategy]
Use Woodpecker LXC agents for governed pipeline, cron, and job execution.
GitHub self-hosted runner tooling remains compatibility-only for migration or
manual fallback operations.
:::

## Governed CI Baseline

Nimbus includes Woodpecker pipeline files in `.woodpecker/engine.yml` and
`.woodpecker/ui.yml`. Woodpecker and SonarQube are governed apps in the Nimbus
environment registry when deployed.

Register the governed CI apps with the registry:

```bash
nimbus deploy onboard-cicd --target <target-id> --pool <pool-id>
```

Deploy Woodpecker and SonarQube through registry-assigned slots:

```bash
nimbus deploy up --project woodpecker --env prod --slot primary
nimbus deploy up --project sonarqube --env prod --slot primary
```

## Runner Lifecycle

Woodpecker server receives GitHub webhooks and schedules jobs. Woodpecker LXC
agents execute jobs in isolated Docker containers and report status back to the
Woodpecker server.

Runner resources are not app environment slots:

- App environments use canonical `dev` and `prod` slots in the registry.
- Runner capacity is controlled by Woodpecker agent configuration and Proxmox
  target policy.
- Workflow files must not hardcode target hosts, VMIDs, host ports, or private
  network bindings.

## Pipeline Secrets

Store Woodpecker and SonarQube secrets in Infisical or runtime environment
variables. Recommended paths:

```text
/common/ci/woodpecker/1
/common/ci/sonarqube/1
```

Required values typically include GitHub OAuth credentials, Woodpecker agent
secret, SonarQube token, and webhook secrets.

## Repo Pipeline Setup

Each integrated repository should keep Woodpecker pipeline config in either
`.woodpecker.yml` or `.woodpecker/`. Start from a template in
`templates/woodpecker-pipelines/`:

- `python-fastapi.yml` — lint + test + Sonar for Python/FastAPI repos.
- `node-monorepo.yml` — pnpm-workspace lint + test + build.
- `fullstack-python-node.yml` — composite Python + Node.
- `cron-oci-arm-poller.yml` — cron-triggered Nimbus task pipeline.
- `arm-poller-2week-verify.yml` — one-shot post-migration audit.

Before deploying an app from CI:

```bash
nimbus deploy validate --project <project> --env <dev-or-prod> --slot <slot>
nimbus deploy compose --project <project> --env <dev-or-prod> --template
```

For multi-project rollout:

```bash
nimbus deploy all --env dev --slot default --dry-run
nimbus deploy all --env dev --slot default
```

Use `--dry-run` before non-dry-run deployment to inspect selected projects,
targets, and strategies.

## GitHub Runner Compatibility

The `nimbus gh-runner` CLI and `deploy/gh-runner/` helpers are retained only for
migration or manual fallback. Do not use them as the canonical governed runner
path for new repositories.

If compatibility runners are used, keep credentials on the operator machine and
avoid committing runner host bindings, VMIDs, or tokens.

## Further Reading

- `design/deploy/ci-cd-platform-evaluation.md`
- `design/deploy/proxmox-lxc-architecture.md`
- `requirements/REQUIREMENT_GAPS.md`
