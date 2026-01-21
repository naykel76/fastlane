# ============================================================================
# PowerShell Profile - Entry Point
# ============================================================================

$ShellScriptsDir = "$HOME\shell_scripts"

# ============================================================================
# Load configuration (paths, processes, etc)
# ============================================================================
if (Test-Path "$ShellScriptsDir\powershell\Config.ps1") {
    . "$ShellScriptsDir\powershell\Config.ps1"
}

# ============================================================================
# Load command aliases from commands/ directory
# ============================================================================
# NOTE: Aliases.ps1 has broken logic for multi-word commands (uses & instead of Invoke-Expression)
# if (Test-Path "$ShellScriptsDir\powershell\Aliases.ps1") {
#     . "$ShellScriptsDir\powershell\Aliases.ps1"
# }

# ============================================================================
# Load command functions from JSON files
# ============================================================================
if (Test-Path "$ShellScriptsDir\powershell\Functions.ps1") {
    . "$ShellScriptsDir\powershell\Functions.ps1"
}

# ============================================================================
# Load helper scripts (Open-Path, Kill, Validators)
# ============================================================================
if (Test-Path "$ShellScriptsDir\powershell\Scripts\Functions.ps1") {
    . "$ShellScriptsDir\powershell\Scripts\Functions.ps1"
}

if (Test-Path "$ShellScriptsDir\powershell\Scripts\Kill.ps1") {
    . "$ShellScriptsDir\powershell\Scripts\Kill.ps1"
}

# ============================================================================
# Create dynamic path functions (cfol, esnippets, ujtb, etc.)
# ============================================================================
# Generates functions for all PathMap entries:
# - c + alias = Open in VS Code (cfol, csnippets)
# - e + alias = Open in Explorer (efol, esnippets)
# - u + alias = Open in Cursor (ufol, usnippets)

Set-Alias -Name o -Value Open-Path

foreach ($alias in $Global:PathMap.Keys) {
    # Explorer functions (e + alias)
    $explorerFunc = "function global:e$alias { Open-Path -Alias '$alias' -Explorer }"
    Invoke-Expression $explorerFunc
    
    # Code functions (c + alias)
    $codeFunc = "function global:c$alias { Open-Path -Alias '$alias' -Code }"
    Invoke-Expression $codeFunc
    
    # Cursor functions (u + alias)
    $cursorFunc = "function global:u$alias { Open-Path -Alias '$alias' -Cursor }"
    Invoke-Expression $cursorFunc
}

Write-Host "✓ Profile loaded" -ForegroundColor Green

# ============================================================================
# Theme and Prompt Configuration (LOAD LAST)
# ============================================================================
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\aliens.omp.json" | Invoke-Expression

