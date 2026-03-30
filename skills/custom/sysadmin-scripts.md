---
name: sysadmin-scripts
description: Generates production-ready PowerShell and Bash scripts for sysadmin tasks. Enforces error handling, logging, idempotency, and safe defaults. Use when asked to write, review, or improve automation scripts for Windows or Linux systems.
---

## When to use this skill

Use when writing or reviewing scripts for:
- User and group management (AD, local, Linux)
- Disk, storage, and filesystem tasks
- Service monitoring and management
- Log collection, rotation, and archiving
- Scheduled tasks and cron jobs
- System health checks and reporting
- File and directory operations (bulk, recursive, conditional)
- Network config and testing scripts
- Backup and restore automation
- Package and patch management
- Remote execution (WinRM, SSH, PSRemoting)

## Standards — apply to every script

### PowerShell
```powershell
#Requires -Version 5.1
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [string]$Param1,
    [string]$LogPath = "$env:TEMP\script-name.log"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Write-Log {
    param([string]$Message, [string]$Level = 'INFO')
    $entry = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] [$Level] $Message"
    Add-Content -Path $LogPath -Value $entry
    if ($Level -eq 'ERROR') { Write-Error $Message }
    else { Write-Verbose $Message }
}

try {
    # main logic
}
catch {
    Write-Log "Script failed: $_" -Level 'ERROR'
    exit 1
}
```

Rules:
- `Set-StrictMode -Version Latest` and `$ErrorActionPreference = 'Stop'` always
- `[CmdletBinding(SupportsShouldProcess)]` for scripts that modify state
- Parameters declared with types and `[Parameter(Mandatory)]` where appropriate
- All output goes through `Write-Log` — no bare `Write-Host`
- `try/catch` around all logic that can fail
- Exit codes: 0 = success, 1 = error
- `-WhatIf` support for destructive operations
- No hardcoded credentials — use `Get-Credential` or environment variables

### Bash
```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_NAME=$(basename "$0")
LOG_FILE="/var/log/${SCRIPT_NAME%.sh}.log"

log() {
    local level="$1"; shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_FILE"
}

cleanup() {
    log INFO "Script exiting"
    # cleanup temp files etc.
}
trap cleanup EXIT

main() {
    # logic here
}

main "$@"
```

Rules:
- `set -euo pipefail` always — fail fast, no unbound variables, pipe errors caught
- Functions for all logic blocks — no monolithic scripts
- `trap cleanup EXIT` for resource cleanup
- Double-quote all variable expansions: `"$VAR"` not `$VAR`
- Check command existence with `command -v tool || { log ERROR "tool not found"; exit 1; }`
- No `sudo` inside scripts — document required privileges in header comments
- Idempotent where possible — check before acting (`if ! id "$user"; then useradd...`)

## Script header template

Every script must start with:
```
# Script:      [name]
# Description: [one line]
# Author:      [author]
# Created:     [date]
# Requires:    [PowerShell version / OS / modules / privileges]
# Usage:       [example invocation]
```

## Output format

Produce:
1. The complete script with header and all standards applied
2. A usage example
3. Any prerequisites (modules, permissions, OS requirements)
4. Notes on idempotency and what gets logged

For review tasks: list violations of the above standards and provide corrected version.

## Keywords
PowerShell, Bash, script, automation, sysadmin, Windows, Linux, user management, Active Directory, cron, scheduled task, monitoring, logging, backup, patch
