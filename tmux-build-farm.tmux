#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

# Define placeholders for different build statuses
build_placeholders=(
    "\#{build_completed}"
    "\#{build_processing}" 
    "\#{build_inqueue}"
)

build_commands=(
    "#($CURRENT_DIR/scripts/completed_count.sh)"
    "#($CURRENT_DIR/scripts/processing_count.sh)"
    "#($CURRENT_DIR/scripts/inqueue_count.sh)"
)

replace_placeholder() {
    local value="$1"
    for ((i=0; i<${#build_commands[@]}; i++)); do
        value=${value//${build_placeholders[$i]}/${build_commands[$i]}}
    done
    echo "$value"
}

update_tmux_option() {
    local option=$1
    local old_option_value=$(get_tmux_option "$option")
    local new_option_value=$(replace_placeholder "$old_option_value")
    $(set_tmux_option "$option" "$new_option_value")
}

main() {
    update_tmux_option "status-right"
}
main