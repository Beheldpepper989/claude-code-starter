---
name: sync
description: Sync claude-code-starter from GitHub — updates agents, skills, hooks, templates. Preserves your CLAUDE.md, memory files, and MCP config.
triggers:
  - /sync
---

# Sync Claude Config from GitHub

When this skill is invoked, run the sync script and report results.

## Steps

1. Run: `bash ~/.claude/sync.sh`
2. Report what was updated (agents, skills, hooks, templates)
3. Remind the user to restart Claude Code if any hooks or settings changed

## Notes

- Safe to run any time — idempotent
- Never overwrites memory files or MCP server config
- CLAUDE.md is only written if it does not already exist — your personal config is preserved
- If the repo isn't cloned yet, it will clone it to `~/claude-config/`
- If settings.json changed, a restart is needed for hooks to take effect
