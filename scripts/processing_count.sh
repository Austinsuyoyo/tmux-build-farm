#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

gerrit_id=$(get_tmux_option "@farm_gerrit_id" "")
count=$(curl -s "http://172.17.32.18/build.php?function=list-build-id&gerritAccount=$gerrit_id" | grep -o '"status":"Processing"' | wc -l)
echo "🔄 $count"