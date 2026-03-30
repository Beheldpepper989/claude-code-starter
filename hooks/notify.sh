#!/bin/bash
# Hook: Notification
# Sends a desktop notification when Claude needs attention.
# Detects environment: WSL, Linux, or Windows Git Bash.

INPUT=$(cat)
MESSAGE=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('message', 'Claude Code needs your attention'))
" 2>/dev/null || echo "Claude Code needs your attention")

# Detect environment
if grep -qi microsoft /proc/version 2>/dev/null; then
  # WSL — can call powershell.exe on the Windows host
  powershell.exe -NoProfile -Command "
    Add-Type -AssemblyName System.Windows.Forms
    \$n = New-Object System.Windows.Forms.NotifyIcon
    \$n.Icon = [System.Drawing.SystemIcons]::Information
    \$n.BalloonTipTitle = 'Claude Code'
    \$n.BalloonTipText = '$MESSAGE'
    \$n.Visible = \$true
    \$n.ShowBalloonTip(5000)
    Start-Sleep -Seconds 6
    \$n.Dispose()
  " &

elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
  # Windows Git Bash
  powershell.exe -NoProfile -Command "
    Add-Type -AssemblyName System.Windows.Forms
    \$n = New-Object System.Windows.Forms.NotifyIcon
    \$n.Icon = [System.Drawing.SystemIcons]::Information
    \$n.BalloonTipTitle = 'Claude Code'
    \$n.BalloonTipText = '$MESSAGE'
    \$n.Visible = \$true
    \$n.ShowBalloonTip(5000)
    Start-Sleep -Seconds 6
    \$n.Dispose()
  " &

else
  # Native Linux — try notify-send, fall back to terminal bell
  if command -v notify-send &>/dev/null; then
    notify-send "Claude Code" "$MESSAGE" --icon=dialog-information &
  else
    echo -e "\a"
  fi
fi

exit 0
