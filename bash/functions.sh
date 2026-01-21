#!/bin/bash

# ============================================================================
# Helper Functions
# ============================================================================

# Resolves an alias to its actual path using the path map
resolve_path() {
    local alias="$1"
    if [[ -v PathMap[$alias] ]]; then
        echo "${PathMap[$alias]}"
    else
        echo "$alias"
    fi
}

# Checks if a path exists
test_path_exists() {
    local path="$1"
    [[ -e "$path" ]]
}

# Validates that a path exists, exits with error if not found
assert_valid_path() {
    local path="$1"
    if ! test_path_exists "$path"; then
        echo "Error: Path does not exist: $path" >&2
        return 1
    fi
}

# Opens Windows File Explorer at the specified path
start_file_explorer() {
    local path="$1"
    explorer.exe "$(cygpath -w "$path")" &>/dev/null &
}

# Launches VS Code with the specified path
start_code_editor() {
    local path="$1"
    code "$(cygpath -w "$path")" &>/dev/null &
}

# Launches Cursor with the specified path
start_cursor_editor() {
    local path="$1"
    cursor "$(cygpath -w "$path")" &>/dev/null &
}

# ============================================================================
# open_path - Main function for opening paths
# ============================================================================
# Opens a path from the alias map in Explorer, VS Code, or Cursor
# Falls back to cd if no flag specified
#
# Usage:
#   open_path -alias jtb                # cd to jtb directory
#   open_path -alias jtb --explorer     # open jtb in Explorer
#   open_path -alias jtb --code         # open jtb in VS Code
#   open_path -alias jtb --cursor       # open jtb in Cursor
# ============================================================================
open_path() {
    local alias=""
    local mode="cd"  # default: cd
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -alias)
                alias="$2"
                shift 2
                ;;
            --explorer)
                mode="explorer"
                shift
                ;;
            --code)
                mode="code"
                shift
                ;;
            --cursor)
                mode="cursor"
                shift
                ;;
            *)
                shift
                ;;
        esac
    done
    
    if [[ -z "$alias" ]]; then
        echo "Error: -alias parameter is required" >&2
        return 1
    fi
    
    local resolved_path
    resolved_path=$(resolve_path "$alias")
    
    if ! assert_valid_path "$resolved_path"; then
        return 1
    fi
    
    case "$mode" in
        explorer)
            start_file_explorer "$resolved_path"
            ;;
        code)
            start_code_editor "$resolved_path"
            ;;
        cursor)
            start_cursor_editor "$resolved_path"
            ;;
        cd)
            cd "$resolved_path" || return 1
            ;;
    esac
}

# Convenience alias for open_path
alias o='open_path'
