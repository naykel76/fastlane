#!/bin/bash

# ============================================================================
# Shell Scripts Configuration
# ============================================================================
# Loads configuration from config.json (single source of truth)
# Parses JSON and populates associative arrays for paths and processes
# ---------------------------------------------------------------------------

# Export the script path for sourcing other scripts
export SCRIPT_PATH="$HOME/shell_scripts/bash"

# Initialize associative arrays
declare -gA PathMap
declare -gA ProcessAliasMap

# ============================================================================
# Load configuration from JSON
# ============================================================================

load_config_from_json() {
    local config_file="$HOME/shell_scripts/config.json"
    
    if [[ ! -f "$config_file" ]]; then
        echo "Error: config.json not found at $config_file" >&2
        return 1
    fi
    
    # Parse paths from JSON
    # Extract all key-value pairs from the "paths" section
    while IFS='=' read -r key value; do
        # Remove quotes and whitespace
        key=$(echo "$key" | sed 's/^[[:space:]]*"\(.*\)"[[:space:]]*$/\1/')
        value=$(echo "$value" | sed 's/^[[:space:]]*"\(.*\)"[[:space:]]*,*[[:space:]]*$/\1/')
        
        # Expand environment variables in value
        value=$(eval echo "$value")
        
        if [[ -n "$key" && -n "$value" ]]; then
            PathMap[$key]="$value"
        fi
    done < <(sed -n '/"paths"/,/^[[:space:]]*}/p' "$config_file" | grep ':' | grep -v '"paths"' | grep -v '^}')
    
    # Parse processes from JSON
    # Extract all key-value pairs from the "processes" section
    while IFS='=' read -r key value; do
        # Remove quotes and whitespace
        key=$(echo "$key" | sed 's/^[[:space:]]*"\(.*\)"[[:space:]]*$/\1/')
        value=$(echo "$value" | sed 's/^[[:space:]]*"\(.*\)"[[:space:]]*,*[[:space:]]*$/\1/')
        
        if [[ -n "$key" && -n "$value" ]]; then
            ProcessAliasMap[$key]="$value"
        fi
    done < <(sed -n '/"processes"/,/^[[:space:]]*}/p' "$config_file" | grep ':' | grep -v '"processes"' | grep -v '^}')
}

# Load configuration
load_config_from_json
