# ============================================================================
# PowerShell Aliases - Load from commands/ JSON files
# ============================================================================
# Creates functions for each command alias defined in JSON files
# Functions support arguments: gr HEAD~1 → git reset HEAD~1

$CommandsDir = "$HOME\shell_scripts\commands"

if (-not (Test-Path $CommandsDir)) {
    Write-Warning "commands directory not found"
    return
}

$jsonFiles = @(Get-ChildItem -Path $CommandsDir -Filter "*.json" -ErrorAction SilentlyContinue)

foreach ($file in $jsonFiles) {
    try {
        $commands = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
        
        foreach ($property in $commands.PSObject.Properties) {
            $alias = $property.Name
            $command = $property.Value
            
            # Parse command to get base command
            $parts = $command -split '\s+', 2
            $baseCommand = $parts[0]
            
            # For simple commands without args, use native alias (faster)
            if ($parts.Count -eq 1 -and $baseCommand -ne 'clear') {
                Set-Alias -Name $alias -Value $baseCommand -Force -Scope Global
            }
            # Special case for 'clear' to avoid recursion
            elseif ($baseCommand -eq 'clear') {
                $scriptBlock = [scriptblock]::Create('Clear-Host')
                New-Item -Path "function:" -Name $alias -Value $scriptBlock -Force | Out-Null
            }
            # For commands with arguments, create a function
            else {
                $scriptBlock = [scriptblock]::Create("& $command `$args")
                New-Item -Path "function:" -Name $alias -Value $scriptBlock -Force | Out-Null
            }
        }
    } catch {
        Write-Warning "Error loading $($file.Name): $_"
    }
}
