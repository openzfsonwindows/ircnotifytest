#!/bin/bash

COMMITS_JSON="${1:-""}"
ACTOR="${2:-unknown}"
BRANCH="${3:-unknown}"
COMPARE_URL="${4:-unknown}"

commit_count=$(echo "$COMMITS_JSON" | jq 'length')
commit_count=${commit_count:-0}

if [ "$commit_count" -eq 0 ]; then
    echo "message=[openzfs] $ACTOR pushed no commits to $BRANCH at $COMPARE_URL"
else
    echo "message=[openzfs] $ACTOR pushed $commit_count commits to $BRANCH at $COMPARE_URL"
fi



