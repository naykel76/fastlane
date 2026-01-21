# ============================================================================
# PowerShell Aliases - Dynamically loaded from commands/ directory
# ============================================================================
# Single source of truth: all command aliases in separate JSON files
# This script scans commands/ and creates aliases from each file

$CommandsDir = "$HOME\shell_scripts\commands"

# Check if commands directory exists
if (-not (Test-Path $CommandsDir)) {
    Write-Warning "commands directory not found at $CommandsDir"
    return
}

# Loop through all JSON files in commands directory
$CommandFiles = Get-ChildItem -Path $CommandsDir -Filter "*.json" -ErrorAction SilentlyContinue

foreach ($cmdFile in $CommandFiles) {
    try {
        # Load and parse each JSON file
        $Commands = Get-Content -Path $cmdFile.FullName -Raw | ConvertFrom-Json
        
        # Loop through all commands and create aliases
        foreach ($cmd in $Commands.PSObject.Properties) {
            $aliasName = $cmd.Name
            $aliasValue = $cmd.Value
            
            # Create alias
            Set-Alias -Name $aliasName -Value $aliasValue -Force -Scope Global -ErrorAction SilentlyContinue
        }
    } catch {
        Write-Warning "Error parsing $($cmdFile.Name): $_"
    }
}
