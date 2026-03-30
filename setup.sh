#!/usr/bin/env bash
# setup.sh — First-time install of claude-code-starter on Linux/WSL
# Run from the cloned repo root: bash setup.sh
# For subsequent updates use: bash ~/.claude/sync.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "[claude-code-starter] Installing to $CLAUDE_DIR"

if grep -qi microsoft /proc/version 2>/dev/null; then
  echo "[claude-code-starter] Environment: WSL"
else
  echo "[claude-code-starter] Environment: Native Linux"
fi

mkdir -p "$CLAUDE_DIR/agents" "$CLAUDE_DIR/skills/marketplace" "$CLAUDE_DIR/skills/custom" "$CLAUDE_DIR/templates" "$CLAUDE_DIR/hooks"

if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  echo "[claude-code-starter] CLAUDE.md already exists — skipping"
else
  cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
  echo "[claude-code-starter] Installed CLAUDE.md"
fi

if [ -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
  echo "[claude-code-starter] settings.json already exists — backup saved to settings.json.bak"
else
  cp "$REPO_DIR/settings.json" "$CLAUDE_DIR/settings.json"
  echo "[claude-code-starter] Installed settings.json"
fi

for f in "$REPO_DIR/agents/"*.md; do cp "$f" "$CLAUDE_DIR/agents/$(basename "$f")"; done
echo "[claude-code-starter] Agents installed"

for f in "$REPO_DIR/skills/marketplace/"*.md; do cp "$f" "$CLAUDE_DIR/skills/marketplace/$(basename "$f")"; done
for f in "$REPO_DIR/skills/custom/"*.md; do [ -f "$f" ] && cp "$f" "$CLAUDE_DIR/skills/custom/$(basename "$f")"; done
echo "[claude-code-starter] Skills installed"

for d in "$REPO_DIR/templates/"/*/; do
  tname=$(basename "$d")
  mkdir -p "$CLAUDE_DIR/templates/$tname"
  cp "$d/CLAUDE.md" "$CLAUDE_DIR/templates/$tname/CLAUDE.md"
done
echo "[claude-code-starter] Templates installed"

for f in "$REPO_DIR/hooks/"*.sh; do
  cp "$f" "$CLAUDE_DIR/hooks/$(basename "$f")"
  chmod +x "$CLAUDE_DIR/hooks/$(basename "$f")"
done
cp "$REPO_DIR/sync.sh" "$CLAUDE_DIR/sync.sh"
chmod +x "$CLAUDE_DIR/sync.sh"
echo "[claude-code-starter] Hooks installed"

echo ""
echo "[claude-code-starter] Done."
echo ""
echo "Next steps:"
echo "  1. Edit ~/.claude/CLAUDE.md — fill in 'About You' and 'Environments'"
echo "  2. If settings.json.bak was created, compare and merge hooks manually"
echo "  3. Restart Claude Code"
echo "  4. To sync updates later: bash ~/.claude/sync.sh"
