#!/bin/bash
# Hook: Stop
# Reminds Claude to write memory before the turn ends.

INPUT=$(cat)

STOP_HOOK_ACTIVE=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(str(d.get('stop_hook_active', False)).lower())
" 2>/dev/null || echo "false")

if [ "$STOP_HOOK_ACTIVE" = "true" ]; then
  exit 0
fi

echo "STOP REMINDER: Before ending this turn, check if any of the following occurred and write memory if so:"
echo "- User stated a new preference or gave feedback on your approach"
echo "- New project context, decisions, or phase changes were discussed"
echo "- A task was completed that changes the project state"
echo "If nothing new, do nothing. Do not write duplicate or trivial memories."
