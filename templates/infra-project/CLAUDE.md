# Infrastructure Project

## Context
This is an infrastructure/sysadmin project. Work may involve servers, services, config files, OS-level changes, or on-prem systems.

## Active Skills
- `sysadmin-scripts` — all scripts must meet the standards defined in this skill
- `runbook-builder` — use for any multi-step procedure
- `stop-slop` — apply to all written output

## Behaviour Rules
- **Confirm before any destructive action** — file deletion, service restart, config overwrite, user removal
- **Log everything** — scripts must write to a log file; ad-hoc commands must be noted in the session
- **Idempotency first** — check state before changing it; scripts must be safe to re-run
- **Least privilege** — never use root/admin unless required; document why when it is
- **Test before prod** — if a staging or test system exists, use it first

## Assumptions to clarify at session start
- What OS and version?
- Prod, staging, or lab environment?
- Any change freeze or maintenance window in effect?
- Is there a rollback path if something goes wrong?

## Output standards
- Commands go in code blocks with the shell specified
- Multi-step procedures use the `runbook-builder` format
- Scripts follow the `sysadmin-scripts` standards (header, logging, error handling, exit codes)
