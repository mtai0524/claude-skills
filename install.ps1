<#
.SYNOPSIS
  Install (or update) these skills and rules into a project's .claude folder, kept out of git.

.EXAMPLE
  .\install.ps1 -Target C:\code\MyProject
  .\install.ps1 -Target C:\code\MyProject -Force   # also overwrite an existing .claude\settings.json
#>
param(
    [Parameter(Mandatory = $true)][string]$Target,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$source = $PSScriptRoot
$target = (Resolve-Path $Target).Path
$dest = Join-Path $target '.claude'

foreach ($dir in 'skills', 'rules') {
    New-Item -ItemType Directory -Force (Join-Path $dest $dir) | Out-Null
    Copy-Item (Join-Path $source "$dir\*") (Join-Path $dest $dir) -Recurse -Force
}

# settings.json may hold project-specific settings: only written when missing, or with -Force.
$settings = Join-Path $dest 'settings.json'
if ($Force -or -not (Test-Path $settings)) {
    Copy-Item (Join-Path $source 'settings.json') $settings -Force
} else {
    Write-Host "Kept existing $settings (use -Force to overwrite)."
}

# Keep .claude/ out of the project's git without touching its .gitignore: .git/info/exclude is local only.
git -C $target rev-parse --is-inside-work-tree 2>$null | Out-Null
if ($LASTEXITCODE -eq 0) {
    git -C $target check-ignore -q .claude/skills 2>$null
    if ($LASTEXITCODE -ne 0) {
        $exclude = Join-Path $target (git -C $target rev-parse --git-path info/exclude)
        New-Item -ItemType Directory -Force (Split-Path $exclude) | Out-Null
        Add-Content $exclude "`n.claude/"
        Write-Host "Added .claude/ to $exclude"
    }

    $tracked = git -C $target ls-files .claude
    if ($tracked) {
        Write-Warning "These .claude files are already tracked by git and will still be committed:`n$($tracked -join "`n")"
    }
}

Write-Host "Installed skills and rules into $dest"
