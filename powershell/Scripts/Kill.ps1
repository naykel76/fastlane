. "$PSScriptRoot\..\Config.ps1"

# kill all instances of a process by alias
function kp($alias, [switch]$c) {
    if ($alias -eq 'exp') {
        Write-Host "Restarting Explorer..."
        taskkill /f /im explorer.exe
        Start-Process explorer.exe
        return
    }

    if ($ProcessAliasMap.ContainsKey($alias)) {
        $proc = $ProcessAliasMap[$alias]
        Write-Host "Killing process: $proc.exe"
        taskkill /f /im "$proc.exe"
    } else {
        Write-Warning "Alias '$alias' not found in ProcessAliasMap."
    }

    if ($c) { 
        # graceful exit
        exit 0
    }
}

# clean up the poop left by Vite dev server
function killvite {
    $aliases = @('node', 'es', 'con')
    foreach ($a in $aliases) {
        kp $a
    }
    # Replace with your Quake's close hotkey or process name
    # Common options:
    # Send-Keys "^``"  # Ctrl + backtick
    # Stop-Process -Name "quake" -Force
    exit
}
