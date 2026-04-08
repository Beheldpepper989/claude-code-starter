#!/usr/bin/env bash
# Hook: PreToolUse (matcher: Edit, Write)
# Logs all file writes. Blocks writes to ~/.ssh/. Warns on ~/.claude/ config files.

LOG_FILE="$HOME/.claude/logs/file-writes.log"
mkdir -p "$(dirname "$LOG_FILE")"

# Read tool input from stdin
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('file_path',''))" 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

# Expand ~ to $HOME
FILE_PATH="${FILE_PATH/#\~/$HOME}"

# Log the write
echo "[$(date '+%Y-%m-%d %H:%M:%S')] $FILE_PATH" >> "$LOG_FILE"

# Block writes to SSH directory
if [[ "$FILE_PATH" == "$HOME/.ssh/"* ]]; then
  echo "Blocked: Writing to ~/.ssh/ is not allowed."
  exit 1
fi

# Warn on Claude config files (allow, but surface it)
CLAUDE_CONFIGS=(
  "$HOME/.claude/settings.json"
  "$HOME/.claude/CLAUDE.md"
  "$HOME/.claude/hooks/"
)

for pattern in "${CLAUDE_CONFIGS[@]}"; do
  if [[ "$FILE_PATH" == "$pattern"* ]] || [[ "$FILE_PATH" == "$pattern" ]]; then
    echo "Note: Writing to Claude config file: $FILE_PATH - changes here won't be in GitHub until you push manually."
    exit 0
  fi
done

exit 0
