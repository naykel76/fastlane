#!/bin/bash

# ============================================================================
# Bash Aliases - Load from commands/ JSON files
# ============================================================================
# Creates functions for each command alias defined in JSON files
# Functions support arguments: gr HEAD~1 → git reset HEAD~1

COMMANDS_DIR="$HOME/shell_scripts/commands"

if [[ ! -d "$COMMANDS_DIR" ]]; then
    echo "Warning: commands directory not found at $COMMANDS_DIR" >&2
    return
fi

# Counter for debugging
LOADED_COUNT=0

# Loop through all JSON files
for json_file in "$COMMANDS_DIR"/*.json; do
    if [[ ! -f "$json_file" ]]; then
        continue
    fi
    
    # Parse JSON and create functions
    while IFS='=' read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
        [[ "$line" =~ ^[[:space:]]*\{[[:space:]]*$ || "$line" =~ ^[[:space:]]*\}[[:space:]]*$ ]] && continue
        
        # Extract alias and command from JSON line
        # Format: "alias": "command value",
        if [[ $line =~ \"([^\"]+)\"[[:space:]]*:[[:space:]]*\"([^\"]+)\" ]]; then
            alias_name="${BASH_REMATCH[1]}"
            command_value="${BASH_REMATCH[2]}"
            
            # Create the function - arguments will be passed with "$@"
            eval "function $alias_name() { $command_value \"\$@\"; }"
            ((LOADED_COUNT++))
        fi
    done < "$json_file"
done

# Optional: uncomment to debug
# echo "Loaded $LOADED_COUNT functions from commands/"
