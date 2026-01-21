#!/bin/bash

# ============================================================================
# Bash Profile - Entry Point
# ============================================================================

SHELL_SCRIPTS_DIR="$HOME/shell_scripts"

# ============================================================================
# TODO: Load configuration (paths, processes, etc)
# ============================================================================
# if [[ -f "$SHELL_SCRIPTS_DIR/bash/config.sh" ]]; then
#     source "$SHELL_SCRIPTS_DIR/bash/config.sh"
# fi

# ============================================================================
# TODO: Load command aliases from commands/ directory
# ============================================================================
if [[ -f "$SHELL_SCRIPTS_DIR/bash/aliases.sh" ]]; then
    source "$SHELL_SCRIPTS_DIR/bash/aliases.sh"
fi

# ============================================================================
# TODO: Load special functions (functions with arguments, etc)
# ============================================================================
# if [[ -f "$SHELL_SCRIPTS_DIR/bash/functions.sh" ]]; then
#     source "$SHELL_SCRIPTS_DIR/bash/functions.sh"
# fi

