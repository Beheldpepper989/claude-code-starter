# sync.ps1 - Sync claude-code-starter from GitHub to ~/.claude/
# Safe to run any time. Never touches memory or MCP config.
# Usage: powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\sync.ps1"

$RepoUrl  = "https://github.com/Beheldpepper989/claude-code-starter.git"
$RepoDir  = "$env:USERPROFILE\claude-code-starter"
$ClaudeDir = "$env:USERPROFILE\.claude"

Write-Host "[sync] Environment: Windows"
Write-Host "[sync] Repo:        $RepoUrl"
Write-Host "[sync] Local repo:  $RepoDir"
Write-Host "[sync] Claude dir:  $ClaudeDir"
Write-Host ""

if (Test-Path "$RepoDir\.git") {
  Write-Host "[sync] Pulling latest from GitHub..."
  git -C $RepoDir pull --ff-only
} else {
  Write-Host "[sync] Cloning repo to $RepoDir..."
  git clone $RepoUrl $RepoDir
}

Write-Host ""

if (-not (Test-Path "$ClaudeDir\CLAUDE.md")) {
  Copy-Item "$RepoDir\CLAUDE.md" "$ClaudeDir\CLAUDE.md" -Force
  Write-Host "[sync] CLAUDE.md installed (personalize the About You and Environments sections)"
} else {
  Write-Host "[sync] CLAUDE.md skipped (already exists - edit manually to pick up upstream changes)"
}

$settingsPath = "$ClaudeDir\settings.json"
if (Test-Path $settingsPath) {
  $live = Get-Content $settingsPath | ConvertFrom-Json
  $repo = Get-Content "$RepoDir\settings.json" | ConvertFrom-Json
  if ($live.mcpServers) { $repo | Add-Member -Force -NotePropertyName mcpServers -NotePropertyValue $live.mcpServers }
  $live.PSObject.Properties | Where-Object { $_.Name -notin $repo.PSObject.Properties.Name } | ForEach-Object {
    $repo | Add-Member -Force -NotePropertyName $_.Name -NotePropertyValue $_.Value
  }
  $repo | ConvertTo-Json -Depth 10 | Set-Content $settingsPath
  Write-Host "[sync] settings.json updated (mcpServers and personal settings preserved)"
} else {
  Copy-Item "$RepoDir\settings.json" $settingsPath -Force
  Write-Host "[sync] settings.json installed"
}

New-Item -ItemType Directory -Force -Path "$ClaudeDir\agents" | Out-Null
Get-ChildItem "$RepoDir\agents\*.md" | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\agents\$($_.Name)" -Force }
Get-ChildItem "$ClaudeDir\agents\*.md" | Where-Object { -not (Test-Path "$RepoDir\agents\$($_.Name)") } | ForEach-Object {
  Remove-Item $_.FullName; Write-Host "[sync] Removed agent: $($_.Name)"
}
Write-Host "[sync] Agents updated"

New-Item -ItemType Directory -Force -Path "$ClaudeDir\skills\marketplace" | Out-Null
New-Item -ItemType Directory -Force -Path "$ClaudeDir\skills\custom" | Out-Null
Get-ChildItem "$RepoDir\skills\marketplace\*.md" | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\skills\marketplace\$($_.Name)" -Force }
Get-ChildItem "$ClaudeDir\skills\marketplace\*.md" | Where-Object { -not (Test-Path "$RepoDir\skills\marketplace\$($_.Name)") } | ForEach-Object {
  Remove-Item $_.FullName; Write-Host "[sync] Removed marketplace skill: $($_.Name)"
}
Get-ChildItem "$RepoDir\skills\custom\*.md" -ErrorAction SilentlyContinue | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\skills\custom\$($_.Name)" -Force }
Get-ChildItem "$ClaudeDir\skills\custom\*.md" | Where-Object { -not (Test-Path "$RepoDir\skills\custom\$($_.Name)") } | ForEach-Object {
  Remove-Item $_.FullName; Write-Host "[sync] Removed custom skill: $($_.Name)"
}
Write-Host "[sync] Skills updated"

New-Item -ItemType Directory -Force -Path "$ClaudeDir\templates" | Out-Null
Get-ChildItem "$RepoDir\templates" -Directory | ForEach-Object {
  $tDir = "$ClaudeDir\templates\$($_.Name)"
  New-Item -ItemType Directory -Force -Path $tDir | Out-Null
  $src = "$($_.FullName)\CLAUDE.md"
  if (Test-Path $src) { Copy-Item $src "$tDir\CLAUDE.md" -Force }
}
Write-Host "[sync] Templates updated"

New-Item -ItemType Directory -Force -Path "$ClaudeDir\hooks" | Out-Null
Get-ChildItem "$RepoDir\hooks\*.sh" | ForEach-Object { Copy-Item $_.FullName "$ClaudeDir\hooks\$($_.Name)" -Force }
Copy-Item "$RepoDir\sync.ps1" "$ClaudeDir\sync.ps1" -Force
Write-Host "[sync] Hooks updated"

Write-Host ""
Write-Host "[sync] Done. Restart Claude Code to pick up any changes."
