#!/bin/bash

# ============================================================================
# Bash Profile - Entry Point
# ============================================================================

SHELL_SCRIPTS_DIR="$HOME/shell_scripts"

# ============================================================================
# Load configuration (paths, processes, etc)
# ============================================================================
if [[ -f "$SHELL_SCRIPTS_DIR/bash/config.sh" ]]; then
    source "$SHELL_SCRIPTS_DIR/bash/config.sh"
fi

# ============================================================================
# TODO: Load command aliases from commands/ directory
# ============================================================================
if [[ -f "$SHELL_SCRIPTS_DIR/bash/aliases.sh" ]]; then
    source "$SHELL_SCRIPTS_DIR/bash/aliases.sh"
fi

# ============================================================================
# Load special functions (functions with arguments, etc)
# ============================================================================
if [[ -f "$SHELL_SCRIPTS_DIR/bash/functions.sh" ]]; then
    source "$SHELL_SCRIPTS_DIR/bash/functions.sh"
fi

# ============================================================================
# Load local configuration (personal aliases, not tracked in git)
# ============================================================================
if [[ -f "$SHELL_SCRIPTS_DIR/bash/local.sh" ]]; then
    source "$SHELL_SCRIPTS_DIR/bash/local.sh"
fi