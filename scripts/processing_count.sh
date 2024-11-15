#!/usr/bin/env bash

count=$(curl -s "http://172.17.32.18/build.php?function=list-build-id&gerritAccount=austin.su" | grep -o '"status":"Processing"' | wc -l)
echo "🔄 $count"