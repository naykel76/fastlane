. "$PSScriptRoot\Validators.ps1"

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------

# Resolves an alias to its actual path using the global path map
function Resolve-Path($alias) {
    if ($Global:PathMap.ContainsKey($alias)) {
        return $Global:PathMap[$alias]
    }
    return $alias
}

# Launches Visual Studio Code with the specified path
function Start-CodeEditor($path) {
    & code $path
}

# Launches Cursor with the specified path
function Start-CursorEditor($path) {
    & cursor $path
}

# Opens Windows File Explorer at the specified path
function Start-FileExplorer($path) {
    & explorer $path
}

# -----------------------------------------------------------------------------
# Resolves an alias to a path using the global path map, validates the path
# exists, then launches either VS Code or File Explorer based on the provided
# switches.
# -----------------------------------------------------------------------------
function Open-Path {
    param(
        [string]$Alias,
        [switch]$Code,
        [switch]$Cursor,
        [switch]$Explorer
    )
    
    try {
        $resolvedPath = Resolve-Path $Alias
        Assert-ValidPath $resolvedPath
        
        if ($Code) {
            Start-CodeEditor $resolvedPath
        } elseif ($Cursor) {
            Start-CursorEditor $resolvedPath
        } else {
            Start-FileExplorer $resolvedPath
        }
    } catch {
        Write-Error "Failed to open path: $_"
    }
}