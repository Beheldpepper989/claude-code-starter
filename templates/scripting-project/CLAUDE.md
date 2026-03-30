# Scripting Project

## Context
This is a scripting and automation project. Output is PowerShell, Bash, or both. Scripts may run on Windows, Linux, or both.

## Active Skills
- `sysadmin-scripts` — all scripts must conform to these standards, no exceptions
- `stop-slop` — apply to all comments, headers, and documentation

## Script Standards (enforced)

### Every script must have:
- Header block: name, description, author, date, requires, usage
- Logging to file (not just console)
- `Set-StrictMode -Version Latest` + `$ErrorActionPreference = 'Stop'` (PS) or `set -euo pipefail` (Bash)
- Proper exit codes: 0 = success, 1 = error
- Idempotency — safe to re-run without side effects where possible

### Never:
- Hardcode credentials, tokens, or secrets
- Use `Write-Host` in PowerShell (use `Write-Verbose` / log function)
- Leave bare variables unquoted in Bash
- Use `sudo` inside scripts (document required privileges in the header)

## Project structure
Maintain a `changelog.md` in the project root. Log every script change:
```
## [date] — [script name]
- [what changed and why]
```

## Testing checklist
Before marking a script complete:
- [ ] Runs without errors on target OS
- [ ] Handles missing inputs gracefully
- [ ] Log file written correctly
- [ ] Tested with `-WhatIf` (PS) or dry-run mode where applicable
- [ ] Re-run produces same result (idempotency check)

## Assumptions to clarify at session start
- Target OS(es)?
- PowerShell version constraint?
- Will scripts run interactively or unattended?
- Where do log files go?
