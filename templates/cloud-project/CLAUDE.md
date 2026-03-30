# Cloud Project

## Context
This is a cloud infrastructure project. Work involves Azure or AWS resources — provisioning, reviewing, auditing, or troubleshooting.

## Active Skills
- `cloud-review` — use for all config review and audit tasks
- `sysadmin-scripts` — use for any CLI scripts or automation
- `runbook-builder` — use for deployment and change procedures
- `stop-slop` — apply to all written output

## Environment
Set this at session start — it controls how aggressively Claude confirms before acting:

| Environment | Behaviour |
|---|---|
| **prod** | Confirm every action, no exceptions. Read before write. |
| **staging** | Confirm destructive actions. Changes allowed with brief confirmation. |
| **lab** | Confirm only irreversible actions. Move faster. |

**Default: treat as prod until confirmed otherwise.**

## Behaviour Rules
- **Read before write** — retrieve current state before modifying it
- **No live changes without explicit confirmation** — state the change and what it affects, wait for approval
- **Principle of least privilege** — recommend narrowest permission scope that meets the requirement
- **IaC preferred** — prefer ARM/Bicep/Terraform over portal clicks; document manual steps if CLI/portal is used
- **Tag everything** — new resources must have: environment, owner, project tags minimum

## CLI conventions
```bash
# Azure
az [command] --output table   # default to table for readability
az [command] --dry-run        # use where available before applying

# AWS
aws [service] [command] --output table
aws [service] [command] --dry-run  # EC2 / some services support this
```

## Assumptions to clarify at session start
- Azure or AWS (or both)?
- Subscription / account and resource group scope?
- Environment: prod / staging / lab?
- IaC tool in use (ARM, Bicep, Terraform, CDK, none)?
- Any compliance requirements (ISO 27001, CIS, SOC2)?
