#!/bin/bash
# Hook: SessionStart
# Injects a memory reminder into Claude's context at the start of every session.

echo "SESSION START REMINDER:"
echo "- Check \$HOME/.claude/projects/ for the memory folder matching the current project."
echo "- Load all memory files listed in that project's MEMORY.md before proceeding."
echo "- Before this session ends, write any new user preferences, feedback, or project state to memory."
echo "- Do not let the memory folder stay empty or go stale."
