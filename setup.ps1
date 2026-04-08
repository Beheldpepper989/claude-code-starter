# setup.ps1 - First-time install of claude-code-starter on Windows
# Run from the cloned repo root: .\setup.ps1
# For subsequent updates use: powershell -File "$env:USERPROFILE\.claude\sync.ps1"

$ErrorActionPreference = "Stop"
$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = "$env:USERPROFILE\.claude"

Write-Host "[setup] Repo dir:   $RepoDir"
Write-Host "[setup] Claude dir: $ClaudeDir"
Write-Host ""

# Create directories
@("agents", "skills\marketplace", "skills\custom", "templates", "hooks") | ForEach-Object {
    New-Item -ItemType Directory -Force -Path "$ClaudeDir\$_" | Out-Null
}
Write-Host "[setup] Directories created"

# CLAUDE.md - skip if already exists to preserve personalisation
if (Test-Path "$ClaudeDir\CLAUDE.md") {
    Write-Host "[setup] CLAUDE.md already exists — skipping"
} else {
    Copy-Item "$RepoDir\CLAUDE.md" "$ClaudeDir\CLAUDE.md" -Force
    Write-Host "[setup] CLAUDE.md installed -> $ClaudeDir\CLAUDE.md"
}

# settings.json - backup if exists, then install
if (Test-Path "$ClaudeDir\settings.json") {
    Copy-Item "$ClaudeDir\settings.json" "$ClaudeDir\settings.json.bak" -Force
    Write-Host "[setup] settings.json backed up"
}
Copy-Item "$RepoDir\settings.json" "$ClaudeDir\settings.json" -Force
Write-Host "[setup] settings.json installed"

# Agents
Get-ChildItem "$RepoDir\agents\*.md" | ForEach-Object {
    Copy-Item $_.FullName "$ClaudeDir\agents\$($_.Name)" -Force
}
Write-Host "[setup] Agents installed"

# Skills
Get-ChildItem "$RepoDir\skills\marketplace\*.md" | ForEach-Object {
    Copy-Item $_.FullName "$ClaudeDir\skills\marketplace\$($_.Name)" -Force
}
Get-ChildItem "$RepoDir\skills\custom\*.md" -ErrorAction SilentlyContinue | ForEach-Object {
    Copy-Item $_.FullName "$ClaudeDir\skills\custom\$($_.Name)" -Force
}
Write-Host "[setup] Skills installed"

# Templates
Get-ChildItem "$RepoDir\templates" -Directory | ForEach-Object {
    $tDir = "$ClaudeDir\templates\$($_.Name)"
    New-Item -ItemType Directory -Force -Path $tDir | Out-Null
    $src = "$($_.FullName)\CLAUDE.md"
    if (Test-Path $src) { Copy-Item $src "$tDir\CLAUDE.md" -Force }
}
Write-Host "[setup] Templates installed"

# Hooks and sync script
Get-ChildItem "$RepoDir\hooks\*.sh" | ForEach-Object {
    Copy-Item $_.FullName "$ClaudeDir\hooks\$($_.Name)" -Force
}
Copy-Item "$RepoDir\sync.ps1" "$ClaudeDir\sync.ps1" -Force
Write-Host "[setup] Hooks and sync script installed"

Write-Host ""
Write-Host "[setup] Done. Everything installed to $ClaudeDir"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open $ClaudeDir\CLAUDE.md and fill in the 'About You' and 'Environments' sections"
Write-Host "  2. Restart Claude Code"
Write-Host "  3. To sync updates later: powershell -File $ClaudeDir\sync.ps1"
