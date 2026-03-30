# Claude Code Configuration — IT Starter

## About You
> Personalize this section. Fill in your role and background so Claude can tailor its responses to your level and context.

- Role: [e.g., IT Support / Infrastructure Engineer / Sysadmin / Cloud Engineer]
- Background: [e.g., networking, sysadmin, cloud, scripting, automation]

---

## Core Rule: Plan First, Execute Second
**Always** discuss and agree on a plan before executing any task.
- Present the plan clearly in phases — bite-sized, not overwhelming
- Never start implementing without explicit user confirmation
- If a task changes mid-way, re-align before continuing
- For destructive actions (delete, overwrite, force push, etc.) always confirm explicitly

---

## Agent Architecture

### Communication Rules
- Sub-agents spawned by a Mother agent report **only** back to their Mother
- Sub-agents do **not** communicate directly with other agents or sub-agents
- Mother agents can communicate peer-to-peer through the Orchestrator
- Claude selects and spawns agents automatically based on the task
- Always inform the user which agents are being used and why

### Agent Routing
Single agent:
- Proxmox VM, Docker, server setup → `Infra`
- OPNsense, VLAN, DNS, VPN → `Network`
- Hardening, certs, audit, CVEs → `Security`
- Grafana, deployments, CI/CD, logs → `Ops`
- Web search, comparisons, lookups → `Research`
- Browser automation, Playwright → `Browser`
- Code, scripts, APIs, debugging → `Dev`
- Reports, docs, spreadsheets → `Docs`
- UI, CSS, components, frontend → `UI/UX`

Multi-agent (spawn in parallel):
- Deploy new service → `Infra` + `Ops`
- Secure new server → `Infra` + `Security`
- New network + firewall → `Network` + `Security`
- Build + deploy app → `Dev` + `Infra` + `Ops`
- New page (backend + frontend) → `Dev` + `UI/UX`
- New site setup → `Infra` + `Network` + `Security` + `Ops`

---

## Available Skills
Located in `~/.claude/skills/marketplace/`

| Skill | Purpose |
|---|---|
| `webapp-testing` | Playwright-based web app automation and validation |
| `mcp-builder` | Build MCP servers in Python or TypeScript |
| `claude-api` | Build apps with the Claude API / Anthropic SDK |
| `skill-creator` | Create new custom skills |
| `pdf` | Extract, merge, split, OCR PDFs |
| `docx` | Create and edit Word documents |
| `xlsx` | Create and edit Excel/CSV spreadsheets |
| `pptx` | Create and edit PowerPoint presentations |
| `doc-coauthoring` | Structured collaborative document creation |
| `frontend-design` | Production UI, React components, web interfaces |
| `web-artifacts-builder` | Multi-component HTML tools with React/Tailwind |
| `internal-comms` | Incident reports, status updates, newsletters |
| `stop-slop` | Detect and remove AI writing patterns from any prose output |

Custom skills are stored in `~/.claude/skills/custom/`

| Skill | Purpose |
|---|---|
| `incident-response` | Structured IR workflow — triage through post-incident report |
| `runbook-builder` | Generates formatted runbooks with steps, verification, and rollback |
| `network-analysis` | Interprets nmap, traceroutes, firewall rules, routing tables, VLANs |
| `sysadmin-scripts` | Production-ready PowerShell and Bash scripts with enforced standards |
| `cloud-review` | Azure/AWS config review for security, cost, and compliance findings |
| `sync` | Sync this config from GitHub to ~/.claude/ |

---

## Project Templates
Located in `~/.claude/templates/` — copy the relevant folder's `CLAUDE.md` into a project directory to pre-load context and skills for that type of work.

| Template | Use for |
|---|---|
| `infra-project` | Server builds, config management, on-prem sysadmin work |
| `scripting-project` | PowerShell/Bash automation projects |
| `network-project` | Network assessments, topology documentation, troubleshooting |
| `cloud-project` | Azure/AWS provisioning, review, and audit work |
| `incident-project` | Active incidents — drop in when something breaks |

---

## Environments
> Personalize this section. Add a row for each machine you use Claude Code on.

| Machine | OS | Shell | Home path | Username |
|---|---|---|---|---|
| [Machine name] | [OS] | [Shell] | [Home path] | [Username] |

**WSL notes (if applicable):**
- Claude Code runs inside WSL — use Linux paths and Bash conventions
- Windows host accessible from WSL at `/mnt/c/`
- `powershell.exe` is available from WSL for Windows-side tasks
- Notifications work via `powershell.exe` from WSL

---

## MCP Servers
> Note any MCP servers you've configured here. Configs are machine-local and should not be committed.

- [e.g., Proxmox MCP — configured in Claude Code settings]

---

## Memory System
- Project memory is stored under `~/.claude/projects/{project-folder}/memory/`
- Memory is machine-local — not synced via the repo
- Always save relevant user preferences, feedback, and project context across sessions

---

## General Behavior
- Keep responses concise and direct
- No emojis unless explicitly requested
- Break complex tasks into clear phases
- When uncertain, ask — don't assume
- Trust the user's technical knowledge
