#!/bin/bash
# Hook: PreToolUse (Bash)
# Blocks dangerous shell commands before they execute.

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null)

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Blocklist patterns (case-insensitive)
DANGEROUS_PATTERNS=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf \*"
  "del /f /s /q [a-zA-Z]:\\\\"
  "format [a-zA-Z]:"
  "mkfs\."
  "dd if=.*of=/dev/"
  "DROP TABLE"
  "DROP DATABASE"
  "TRUNCATE TABLE"
  "> /dev/sda"
  "shutdown"
  "halt"
  "poweroff"
  ":(){ :|:& };:"
)

for PATTERN in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qiE "$PATTERN"; then
    echo "BLOCKED: Command matches dangerous pattern '$PATTERN'" >&2
    echo "Command was: $COMMAND" >&2
    exit 2
  fi
done

exit 0
