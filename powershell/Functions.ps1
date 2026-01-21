# ============================================================================
# PowerShell Functions - Dynamically loaded from commands/ directory
# ============================================================================
# Creates functions for command aliases 

$CommandsDir = "$HOME\shell_scripts\commands"

if (-not (Test-Path $CommandsDir)) {
    return
}

# Loop through all JSON files in commands directory
Get-ChildItem -Path $CommandsDir -Filter "*.json" -ErrorAction SilentlyContinue | ForEach-Object {
    try {
        $Commands = Get-Content -Path $_.FullName -Raw | ConvertFrom-Json
        
        # Loop through all commands and create functions
        $Commands.PSObject.Properties | ForEach-Object {
            $functionName = $_.Name
            $commandString = $_.Value
            
            # Skip if function name matches command exactly (prevents infinite recursion)
            if ($functionName -eq $commandString) {
                return
            }
            
            # Create function dynamically with proper escaping
            $code = @"
            param([Parameter(ValueFromRemainingArguments=`$true)]`$args)
            `$cmd = '$commandString'
            if (`$args) {
                Invoke-Expression "`$cmd `$(`$args -join ' ')"
            } else {
                Invoke-Expression `$cmd
            }
"@
            
            New-Item -Path Function: -Name $functionName -Value ([scriptblock]::Create($code)) -Force -ErrorAction SilentlyContinue | Out-Null
        }
    } catch {
        # Silently skip
    }
}


