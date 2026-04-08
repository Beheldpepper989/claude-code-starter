# Claude Code Starter — IT Edition

A ready-to-go Claude Code setup for IT professionals. Includes a full agent hierarchy, custom IT skills, hooks, and project templates. Install once, sync forever.

---

## What you get

- **Agent hierarchy** — Orchestrator, Infra, Network, Security, Ops, Research, Browser, Dev, Docs, UI/UX agents that Claude routes tasks to automatically
- **Custom skills** — incident response, runbook builder, network analysis, sysadmin scripts, cloud review
- **Marketplace skills** — Playwright testing, MCP builder, Claude API, PDF, Word, Excel, PowerPoint, and more
- **Project templates** — drop a `CLAUDE.md` into any project folder to pre-load the right context
- **Hooks** — session memory reminders, desktop notifications, bash guard, file write guard, stop reminders
- **Sync** — keep your setup current from this repo with one command

---

## Prerequisites

- [Claude Code](https://claude.ai/download) installed
- `git` installed
- `python3` available (used by the sync script to merge `settings.json` without clobbering your MCP server config)

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

> **Note for Windows users:** The hooks included in this setup are bash scripts. They will work out of the box if you have WSL or Git Bash installed and `bash` is in your PATH. If you are running Claude Code on Windows without either, the hooks will silently not fire — Claude Code will still work, but you won't get session reminders, notifications, or the bash guard.

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

**If `settings.json.bak` was created:** this means you already had a `settings.json` before running setup. The installer backed it up and installed the new one. Open both files in a text editor and check whether your old file had anything under `"mcpServers"` or custom hook entries. If so, copy those back into the new `settings.json`. The key to preserve is `"mcpServers"` — that holds your MCP server connections and is not tracked in this repo.

---

## Syncing updates

To pull the latest agents, skills, hooks, and templates, run this in your terminal:

**Linux / WSL:**
```bash
bash ~/.claude/sync.sh
```

**Windows:**
```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\sync.ps1"
```

> **Note:** `/sync` is not a slash command in Claude Code — typing it will return "unknown skill". Run the script above in your terminal instead. You can also just ask Claude to "sync my config" and it will run the script for you.

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

## Hooks reference

Hooks are shell scripts that Claude Code runs automatically at specific points. All hooks are installed to `~/.claude/hooks/` and wired up in `settings.json`.

| Hook file | Trigger | What it does |
|---|---|---|
| `session-start.sh` | Every new session | Injects a memory reminder — tells Claude to load the current project's memory files before doing anything |
| `session-start-compact.sh` | After conversation compaction | Reinjects key context (environment, agent hierarchy, skill list) so Claude doesn't lose its bearings after the conversation is compressed |
| `notify.sh` | Notification events | Sends a desktop notification when Claude needs your attention. Works on WSL (via `powershell.exe`), Git Bash, and native Linux (`notify-send`) |
| `bash-guard.sh` | Before any Bash tool call | Blocks a list of dangerous commands (`rm -rf /`, `dd if=...of=/dev/`, `DROP TABLE`, etc.) before they execute |
| `file-guard.sh` | Before any Edit or Write tool call | Logs all file writes to `~/.claude/logs/file-writes.log`, blocks writes to `~/.ssh/`, and warns when Claude modifies its own config files |
| `stop.sh` | End of each turn | Reminds Claude to write memory if something worth saving happened this turn |

**What is compaction?** Claude Code automatically compresses long conversations to stay within context limits. When this happens, the `session-start-compact.sh` hook fires to restore the key context Claude needs to keep working correctly.

**Bypassing bash-guard:** If the guard blocks a command you intentionally want to run, you can run it directly in your terminal outside of Claude Code. The guard only applies to commands Claude executes via the Bash tool.

---

## Troubleshooting

**Hooks aren't firing (Windows)**
Hooks require `bash` to be in your PATH. Install [Git for Windows](https://git-scm.com/download/win) or use WSL. Verify with `bash --version` in a terminal.

**`python3` not found during sync**
Install Python 3 and make sure it's in your PATH. On Windows: `winget install Python.Python.3`. On Ubuntu/WSL: `sudo apt install python3`. If `python3` is missing, the sync script falls back to overwriting `settings.json` entirely rather than merging — your `mcpServers` config will be lost, so restore it from the `.bak` file.

**`settings.json.bak` exists but I'm not sure what to merge**
Open both files. Copy the value of `"mcpServers"` from `.bak` into the current `settings.json`. That's the only field you need to worry about — everything else comes from the repo.

**bash-guard is blocking a command I need**
Run the command directly in your terminal (not through Claude Code). If the pattern is too aggressive for your workflow, edit `~/.claude/hooks/bash-guard.sh` and remove the offending entry from `DANGEROUS_PATTERNS`.

**Claude isn't loading memory at session start**
Check that `~/.claude/hooks/session-start.sh` exists and is executable (`chmod +x ~/.claude/hooks/session-start.sh`). Also verify the hook is wired in `~/.claude/settings.json` under `"SessionStart"`.

**Setup script failed partway through**
Re-run it — both `setup.sh` and `setup.ps1` are safe to run again. They skip `CLAUDE.md` if it already exists and back up `settings.json` before touching it.

---

## Contributing

Found a bug, improved an agent, or built a skill worth sharing? PRs welcome.

- Keep agents generic — no personal or org-specific context
- Custom skills should be broadly applicable to IT work
- Test hooks on both Linux/WSL and Windows before submitting
