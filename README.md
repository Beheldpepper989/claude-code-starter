# Claude Code Starter — IT Edition

A ready-to-go Claude Code setup for IT professionals. Includes a full agent hierarchy, custom IT skills, hooks, and project templates. Install once, sync forever.

---

## What you get

- **Agent hierarchy** — Orchestrator, Infra, Network, Security, Ops, Research, Browser, Dev, Docs, UI/UX agents that Claude routes tasks to automatically
- **Custom skills** — incident response, runbook builder, network analysis, sysadmin scripts, cloud review
- **Marketplace skills** — Playwright testing, MCP builder, Claude API, PDF, Word, Excel, PowerPoint, and more
- **Project templates** — drop a `CLAUDE.md` into any project folder to pre-load the right context
- **Hooks** — session memory reminders, desktop notifications, bash guard, stop reminders
- **Sync** — keep your setup current from this repo with one command

---

## Prerequisites

- [Claude Code](https://claude.ai/download) installed
- `git` installed
- `python3` available (used by sync script for settings merge)

---

## Install

### Linux / WSL (Ubuntu)

```bash
git clone https://github.com/Beheldpepper989/claude-code-starter.git ~/claude-code-starter
bash ~/claude-code-starter/setup.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/Beheldpepper989/claude-code-starter.git "$env:USERPROFILE\claude-code-starter"
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\claude-code-starter\setup.ps1"
```

Then restart Claude Code.

---

## First steps after install

Open `~/.claude/CLAUDE.md` and fill in the two placeholder sections:

**1. About You** — your role and tech background. This shapes how Claude explains things and what level of detail it assumes.

```markdown
## About You
- Role: Infrastructure Engineer
- Background: networking, sysadmin, Proxmox, OPNsense, Docker, PowerShell
```

**2. Environments** — the machines you use Claude Code on. Claude uses this to detect which conventions to apply (Linux paths vs Windows paths, WSL quirks, etc.).

```markdown
| Machine | OS | Shell | Home path | Username |
|---|---|---|---|---|
| Work laptop | Windows + WSL | Ubuntu (WSL) | /home/yourname | yourname |
| Home PC | Windows 11 | Git Bash | C:\Users\yourname | yourname |
```

Everything else in `CLAUDE.md` works out of the box.

---

## Syncing updates

To pull the latest agents, skills, hooks, and templates:

```bash
bash ~/.claude/sync.sh
```

Or from within a Claude session:

```
/sync
```

Sync never overwrites your `CLAUDE.md`, memory files, or MCP server config — only the shared components get updated.

---

## Want your own private config?

If you want to customize and maintain your own setup (recommended once you're comfortable):

1. **Fork this repo** on GitHub
2. Update `REPO_URL` in `sync.sh` and `sync.ps1` to point to your fork
3. Run `bash ~/.claude/sync.sh` — it will now pull from your fork
4. Commit your own changes (custom skills, agent tweaks, etc.) to your fork
5. Sync any machine from your fork whenever you update it

This is how to go from "using the starter" to "owning your config".

---

## What to customize

| What | Where | Notes |
|---|---|---|
| Your background and role | `~/.claude/CLAUDE.md` → About You | Shapes Claude's tone and depth |
| Your machines | `~/.claude/CLAUDE.md` → Environments | Affects path conventions |
| MCP servers | Claude Code settings | Machine-local, never committed |
| Agent behavior | `~/.claude/agents/*.md` | Edit roles, responsibilities, report formats |
| Custom skills | `~/.claude/skills/custom/` | Add new skills or edit existing ones |
| Project templates | `~/.claude/templates/` | Copy a template's `CLAUDE.md` into any project |
| Hooks | `~/.claude/hooks/` | Modify session reminders, notifications, guards |

---

## Contributing

Found a bug, improved an agent, or built a skill worth sharing? PRs welcome.

- Keep agents generic — no personal or org-specific context
- Custom skills should be broadly applicable to IT work
- Test hooks on both Linux/WSL and Windows before submitting
