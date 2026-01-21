# Shell Scripts Repository

A unified shell scripting environment for Windows that works in both PowerShell
and Git Bash. Provides consistent aliases and functions across both shells with
a **single source of truth** configuration file.

## Setup

## Bash Setup

**1. Create symlink:**

```bash
rm ~/.bash_profile
ln -sf ~/shell_scripts/profile.sh ~/.bash_profile
```

This creates a symlink at `~/.bash_profile` (in your home directory) that points
to the actual file `~/profile` (in the repo).

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
