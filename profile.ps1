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
# Load special functions (functions with arguments, etc)
# ============================================================================
if (Test-Path "$ShellScriptsDir\powershell\Functions.ps1") {
    . "$ShellScriptsDir\powershell\Functions.ps1"
}

Write-Host "✓ Profile loaded" -ForegroundColor Green

# ============================================================================
# Theme and Prompt Configuration (LOAD LAST)
# ============================================================================
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\aliens.omp.json" | Invoke-Expression

