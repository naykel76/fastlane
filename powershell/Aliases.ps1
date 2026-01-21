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
            
            # Create a function that passes arguments
            $scriptBlock = [scriptblock]::Create("& $command `$args")
            New-Item -Path "function:" -Name $alias -Value $scriptBlock -Force | Out-Null
        }
    } catch {
        Write-Warning "Error loading $($file.Name): $_"
    }
}
