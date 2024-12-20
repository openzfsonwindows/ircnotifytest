#!/bin/bash

EVENT_PATH="${GITHUB_EVENT_PATH}"

# Read the commits data from the GITHUB_EVENT_PATH JSON file
COMMITS_JSON=$(jq -r '.commits' "$EVENT_PATH")
ACTOR="${GITHUB_ACTOR:-unknown}"
BRANCH="${GITHUB_REF_NAME:-unknown}"
COMPARE_URL="${GITHUB_COMPARE_URL:-unknown}"

commit_count=$(echo "$COMMITS_JSON" | jq 'length')
commit_count=${commit_count:-0}



# Create an initial message
message="[openzfs] $ACTOR pushed $commit_count commit(s) to $BRANCH at $COMPARE_URL"

# Add commits to the message
if [ "$commit_count" -gt 0 ]; then
  # Extract and format up to 8 commits
  commits=$(echo "$COMMITS_JSON" | jq -r '.[:8] | .[] | "\(.id[:7]) - \(.message | split("\n")[0])"')

  # Append each commit to the message
  while IFS= read -r commit; do
    message="$message\n<zfs-consus> $commit"
  done <<< "$commits"
fi

# Escape newlines and format the message to a single line
formatted_message=$(echo "$message" | sed ':a;N;$!ba;s/\n/\\n/g')

# Print the formatted message
echo "message=$formatted_message" >> $GITHUB_OUTPUT



