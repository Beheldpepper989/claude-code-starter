#!/usr/bin/env bash
# sync.sh — Sync claude-code-starter from GitHub to ~/.claude/
# Safe to run any time. Never touches memory or MCP config.
# Usage: bash ~/.claude/sync.sh

set -euo pipefail

REPO_URL="https://github.com/Beheldpepper989/claude-code-starter.git"
REPO_DIR="$HOME/claude-code-starter"
CLAUDE_DIR="$HOME/.claude"

# ── Detect environment ──────────────────────────────────────────────────────
if grep -qi microsoft /proc/version 2>/dev/null; then
  ENV="wsl"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
  ENV="windows"
else
  ENV="linux"
fi

echo "[sync] Environment: $ENV"
echo "[sync] Repo:        $REPO_URL"
echo "[sync] Local repo:  $REPO_DIR"
echo "[sync] Claude dir:  $CLAUDE_DIR"
echo ""

# ── Clone or pull repo ───────────────────────────────────────────────────────
if [ -d "$REPO_DIR/.git" ]; then
  echo "[sync] Pulling latest from GitHub..."
  git -C "$REPO_DIR" pull --ff-only
else
  echo "[sync] Cloning repo to $REPO_DIR..."
  git clone "$REPO_URL" "$REPO_DIR"
fi

echo ""

# ── Sync CLAUDE.md (only if not yet personalised) ────────────────────────────
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
  echo "[sync] CLAUDE.md installed (personalize the About You and Environments sections)"
else
  echo "[sync] CLAUDE.md skipped (already exists — edit manually to pick up upstream changes)"
fi

# ── Sync settings.json (hooks only — preserve mcpServers and personal settings) ──────
if command -v python3 &>/dev/null && [ -f "$CLAUDE_DIR/settings.json" ]; then
  python3 - <<PYEOF
import json

with open("$CLAUDE_DIR/settings.json") as f:
    live = json.load(f)

with open("$REPO_DIR/settings.json") as f:
    repo = json.load(f)

repo_merged = repo.copy()
repo_merged["mcpServers"] = live.get("mcpServers", {})

for k, v in live.items():
    if k not in repo_merged:
        repo_merged[k] = v

with open("$CLAUDE_DIR/settings.json", "w") as f:
    json.dump(repo_merged, f, indent=2)
    f.write("\n")

print("[sync] settings.json updated (mcpServers and personal settings preserved)")
PYEOF
else
  cp "$REPO_DIR/settings.json" "$CLAUDE_DIR/settings.json"
  echo "[sync] settings.json updated"
fi

# ── Sync agents ──────────────────────────────────────────────────────────────
mkdir -p "$CLAUDE_DIR/agents"
ADDED=0; UPDATED=0
for f in "$REPO_DIR/agents/"*.md; do
  dest="$CLAUDE_DIR/agents/$(basename "$f")"
  if [ ! -f "$dest" ]; then ADDED=$((ADDED+1)); else UPDATED=$((UPDATED+1)); fi
  cp "$f" "$dest"
done
for f in "$CLAUDE_DIR/agents/"*.md; do
  [ -f "$REPO_DIR/agents/$(basename "$f")" ] || { rm "$f"; echo "[sync] Removed agent: $(basename "$f")"; }
done
echo "[sync] Agents: $UPDATED updated, $ADDED added"

# ── Sync skills ──────────────────────────────────────────────────────────────
mkdir -p "$CLAUDE_DIR/skills/marketplace" "$CLAUDE_DIR/skills/custom"
for f in "$REPO_DIR/skills/marketplace/"*.md; do cp "$f" "$CLAUDE_DIR/skills/marketplace/$(basename "$f")"; done
for f in "$CLAUDE_DIR/skills/marketplace/"*.md; do
  [ -f "$REPO_DIR/skills/marketplace/$(basename "$f")" ] || { rm "$f"; echo "[sync] Removed marketplace skill: $(basename "$f")"; }
done
for f in "$REPO_DIR/skills/custom/"*.md; do cp "$f" "$CLAUDE_DIR/skills/custom/$(basename "$f")"; done
for f in "$CLAUDE_DIR/skills/custom/"*.md; do
  [ -f "$REPO_DIR/skills/custom/$(basename "$f")" ] || { rm "$f"; echo "[sync] Removed custom skill: $(basename "$f")"; }
done
echo "[sync] Skills updated"

# ── Sync templates ───────────────────────────────────────────────────────────
mkdir -p "$CLAUDE_DIR/templates"
for d in "$REPO_DIR/templates/"/*/; do
  tname=$(basename "$d")
  mkdir -p "$CLAUDE_DIR/templates/$tname"
  cp "$d/CLAUDE.md" "$CLAUDE_DIR/templates/$tname/CLAUDE.md"
done
echo "[sync] Templates updated"

# ── Sync hooks ───────────────────────────────────────────────────────────────
mkdir -p "$CLAUDE_DIR/hooks"
for f in "$REPO_DIR/hooks/"*.sh; do
  cp "$f" "$CLAUDE_DIR/hooks/$(basename "$f")"
  chmod +x "$CLAUDE_DIR/hooks/$(basename "$f")"
done
cp "$REPO_DIR/sync.sh" "$CLAUDE_DIR/sync.sh"
chmod +x "$CLAUDE_DIR/sync.sh"
echo "[sync] Hooks updated"

echo ""
echo "[sync] Done. Restart Claude Code to pick up any changes."
