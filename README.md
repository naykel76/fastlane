# Shell Scripts Repository

A unified shell scripting environment for Windows that works in both PowerShell
and Git Bash. Provides consistent aliases and functions across both shells with
a **single source of truth** configuration file.

## Setup

## Bash Setup

**1. Create symlink:**

```bash
ln -sf ~/shell_scripts/bash_profile ~/.bash_profile
```

This creates a symlink at `~/.bash_profile` (in your home directory) that points
to the actual file `~/shell_scripts/bash_profile` (in the repo).

**2. Load it:**

```bash
source ~/.bash_profile
```

## PowerShell Setup

**1. Check where PowerShell looks for your profile:**

```powershell
$PROFILE
```

Should show:
`C:\Users\natha\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

**2. Make sure the directory exists:**

```powershell
$profileDir = Split-Path $PROFILE
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force
}
```

**3. Create the symlink (run PowerShell as Admin):**

This makes PowerShell use the profile file from this repo.

It removes the existing profile file and replaces it with a symlink. The symlink
sits where PowerShell expects the profile to be and points to the `profile.ps1`
file in this repo.

```powershell
Remove-Item $PROFILE -Force
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$HOME\shell_scripts\profile.ps1" -Force
```

**4. Load it:**

```powershell
. $PROFILE
```

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
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$HOME\shell_scripts\profile.ps1" -Force
. $PROFILE
```

**Bash:**

```bash
ln -sf ~/shell_scripts/profile.sh ~/.bash_profile
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
