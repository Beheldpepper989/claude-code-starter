#!/bin/bash
# Hook: SessionStart (matcher: compact)
# Reinjects key context after Claude Code compacts the conversation.
#
# MAINTENANCE NOTE: The skill lists, agent hierarchy, and templates below are
# hardcoded snapshots. If you add or remove agents, skills, or templates, update
# this file manually to match. It does not auto-update from CLAUDE.md or the repo.

# Detect environment
if grep -qi microsoft /proc/version 2>/dev/null; then
  ENV_LABEL="WSL (Ubuntu)"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
  ENV_LABEL="Windows (Git Bash)"
else
  ENV_LABEL="Linux"
fi

cat <<EOF
CONTEXT RESTORED AFTER COMPACTION:

Environment: $ENV_LABEL
User home: $HOME
Config: $HOME/.claude/
Memory: $HOME/.claude/projects/ (find folder matching current project CWD)

User: IT professional. Concise responses only. No emojis. Plan first, confirm, then execute.

Agent hierarchy: Orchestrator > Infra / Network / Security / Ops / Research / Browser / Dev / Docs / UI/UX agents > sub-agents

Skills (marketplace): webapp-testing, mcp-builder, claude-api, skill-creator, pdf, docx, xlsx, pptx, doc-coauthoring, frontend-design, web-artifacts-builder, internal-comms, stop-slop
Skills (custom): incident-response, runbook-builder, network-analysis, sysadmin-scripts, cloud-review, sync

Templates: infra-project, scripting-project, network-project, cloud-project, incident-project, dev-project

Reload memory files from the current project's memory/ folder before continuing.
EOF
