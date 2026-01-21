# Shell Scripts Repository

A unified shell scripting environment for Windows that works in both PowerShell
and Git Bash. Provides consistent aliases and functions across both shells with
a **single source of truth** configuration file.

## Key Features

- **Single Source of Truth**: All paths and aliases defined once in
  `config.json`, used by both shells
- **Unified Aliases**: Git, Laravel, NPM, and Pest commands work identically in
  PowerShell and Bash
- **Path Shortcuts**: Quick navigation to 17 frequently used directories
- **Dynamic Functions**: Auto-generated shortcuts for opening paths in Explorer,
  VS Code, or Cursor

## Configuration

All paths and process aliases are defined in a single `config.json` file. Both
PowerShell and Bash load this file and populate their respective data structures
automatically. To update paths or add new aliases, edit `config.json` once and
both shells will use the new values immediately (after reloading).

## Quick Start

**PowerShell:**

```powershell
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$HOME\shell_scripts\powershell\Microsoft.PowerShell_profile.ps1" -Force
. $PROFILE
```

**Bash:**

```bash
ln -sf ~/shell_scripts/bash_profile ~/.bash_profile
source ~/.bash_profile
```

## Adding New Aliases

### Adding a Path Alias

1. Edit `config.json` - that's it! Both shells will automatically load the
   changes.
2. Reload your profile (`. $PROFILE` in PowerShell, `source ~/.bash_profile` in
   Bash)

This automatically creates `e[alias]`, `c[alias]`, and `u[alias]` functions for
each new path.

### Adding a Process Alias

Edit `config.json` under the `processes` section and reload your profile.

## Reload

**PowerShell:** `. $PROFILE`  
**Bash:** `source ~/.bash_profile`
