# setup.ps1 — First-time install of claude-code-starter on Windows
# Run from the cloned repo root: .\setup.ps1
# For subsequent updates use: powershell -File "$env:USERPROFILE\.claude\sync.ps1"

$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = "$env:USERPROFILE\.claude"

Write-Host "[claude-code-starter] Installing to $ClaudeDir"

@(
  "agents", "skills\marketplace", "skills\custom", "templates", "hooks"
) | ForEach-Object { New-Item -ItemType Directory -Force -Path "$ClaudeDir\$_" | Out-Null }

if (Test-Path "$ClaudeDir\CLAUDE.md") {
  Write-Host "[claude-code-starter] CLAUDE.md already exists — skipping"
} else {
  Copy-Item "$RepoDir\CLAUDE.md" "$ClaudeDir\CLAUDE.md"
  Write-Host "[claude-code-starter] Installed CLAUDE.md"
}

if (Test-Path "$ClaudeDir\settings.json") {
  Copy-Item "$ClaudeDir\settings.json" "$ClaudeDir\settings.json.bak"
  Write-Host "[claude-code-starter] settings.json already exists — backup saved"
} else {
  Copy-Item "$RepoDir\settings.json" "$ClaudeDir\settings.json"
  Write-Host "[claude-code-starter] Installed settings.json"
}

Get-ChildItem "$RepoDir\agents\*.md" | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\agents\$($_.Name)" -Force }
Write-Host "[claude-code-starter] Agents installed"

Get-ChildItem "$RepoDir\skills\marketplace\*.md" | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\skills\marketplace\$($_.Name)" -Force }
Get-ChildItem "$RepoDir\skills\custom\*.md" -ErrorAction SilentlyContinue | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\skills\custom\$($_.Name)" -Force }
Write-Host "[claude-code-starter] Skills installed"

Get-ChildItem "$RepoDir\templates" -Directory | ForEach-Object {
  $tDir = "$ClaudeDir\templates\$($_.Name)"
  New-Item -ItemType Directory -Force -Path $tDir | Out-Null
  Copy-Item "$($_.FullName)\CLAUDE.md" "$tDir\CLAUDE.md" -Force
}
Write-Host "[claude-code-starter] Templates installed"

Get-ChildItem "$RepoDir\hooks\*.sh" | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\hooks\$($_.Name)" -Force }
Copy-Item "$RepoDir\sync.ps1" "$ClaudeDir\sync.ps1" -Force
Write-Host "[claude-code-starter] Hooks installed"

Write-Host ""
Write-Host "[claude-code-starter] Done."
Write-Host "Next steps:"
Write-Host "  1. Edit $ClaudeDir\CLAUDE.md — fill in 'About You' and 'Environments'"
Write-Host "  2. Restart Claude Code"
Write-Host "  3. To sync updates later: powershell -File '$ClaudeDir\sync.ps1'"
