#!/bin/bash

echo "Dumping ENV"
env

COMMITS_JSON="${1:-""}"
ACTOR="${2:-unknown}"
BRANCH="${3:-unknown}"
COMPARE_URL="${4:-unknown}"

commit_count=$(echo "$COMMITS_JSON" | jq 'length')
commit_count=${commit_count:-0}

if [ "$commit_count" -eq 0 ]; then
    echo "[openzfs] $ACTOR pushed no commits to $BRANCH at $COMPARE_URL"
else
    echo "[openzfs] $ACTOR pushed $commit_count commits to $BRANCH at $COMPARE_URL"
fi

# Limit to the first 8 commits if there are any
if [ "$commit_count" -gt 0 ]; then
  # Extract and print up to 8 commits
  commits=$(echo "$COMMITS_JSON" | jq -r '.[:8] | .[] | "\(.id[:7]) - \(.message | split("\n")[0])"')

  # Print each commit's short ID and title
  while IFS= read -r commit; do
    echo "<zfs-consus> $commit"
  done <<< "$commits"
fi



