# ============================================================================
# Shell Scripts Configuration - Loads from config.json
# ============================================================================
# Single source of truth for all path and process aliases
# Both PowerShell and Bash parse the same JSON file
# ---------------------------------------------------------------------------

$Global:ScriptPath = "$HOME\PowerShell"
$Global:ConfigFile = "$HOME\shell_scripts\config.json"

# Load configuration from JSON
if (Test-Path $Global:ConfigFile) {
    $config = Get-Content $Global:ConfigFile -Raw | ConvertFrom-Json
    
    # Build PathMap from JSON
    $Global:PathMap = @{}
    foreach ($alias in $config.paths.PSObject.Properties) {
        # Expand environment variables in the path
        $pathValue = $alias.Value.path
        $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathValue)
        $Global:PathMap[$alias.Name] = $expandedPath
    }
    
    # Build ProcessAliasMap from JSON
    $Global:ProcessAliasMap = @{}
    foreach ($alias in $config.processes.PSObject.Properties) {
        $Global:ProcessAliasMap[$alias.Name] = $alias.Value
    }
} else {
    Write-Warning "config.json not found at $Global:ConfigFile"
    Write-Warning "Using hardcoded defaults"
    
    # Fallback to hardcoded values if JSON not available
    $GuitarPaths = @{
        'guitar' = "$HOME\OneDrive\Guitar"
        'sone'   = "$HOME\OneDrive\Documents\Studio One"
        'gp'     = "$HOME\OneDrive\Guitar\Guitar Pro"
    }

    $SitePaths = @{
        'fol'     = "$HOME\sites\fol"
        'gotime'  = "$HOME\sites\gotime-site"
        'jtb'     = "$HOME\sites\nk_jtb"
        'nbw'     = "$HOME\sites\nbw"
        'nk'      = "$HOME\sites\naykel"
        'sites'   = "$HOME\sites"
        'wiggity' = "$HOME\sites\wiggity"
    }

    $PackagePaths = @{
        'authit'    = "$HOME\sites\nk_packages\authit"
        'contactit' = "$HOME\sites\nk_packages\contactit"
        'devit'     = "$HOME\sites\nk_packages\devit"
        'gt'        = "$HOME\sites\nk_packages\gotime"
        'postit'    = "$HOME\sites\nk_packages\postit"
    }

    $SystemPaths = @{
        'snippets' = "$HOME\AppData\Roaming\Code\User\snippets"
        'ps'       = "$HOME\OneDrive\Documents\PowerShell"
    }

    $Global:PathMap = $SitePaths + $PackagePaths + $SystemPaths + $GuitarPaths

    $Global:ProcessAliasMap = @{
        'ter'  = 'WindowsTerminal'
        'node' = 'node'
        'es'   = 'esbuild'
        'con'  = 'conhost'
        'code' = 'Code'
    }
}

