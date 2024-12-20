#!/bin/bash
# notify.sh
# This script formats the IRC notification message.

echo "COMMITS_JSON: $1"
echo "GITHUB_ACTOR: $2"
echo "GITHUB_REF_NAME: $3"
echo "GITHUB_COMPARE_URL: $4"

# Extract input from environment variables (set by GitHub Actions)
COMMITS_JSON="$1"
ACTOR="$2"
BRANCH="$3"
COMPARE_URL="$4"

# Parse the JSON to extract commit titles
COMMIT_TITLES=$(echo "$COMMITS_JSON" | jq -r '.[0:8][] | "\(.id[0:7]) - \(.message | split("\n")[0])"')

# Count the commits
COMMIT_COUNT=$(echo "$COMMITS_JSON" | jq -r 'length')
COMMIT_COUNT=${COMMIT_COUNT:-0}  # Default to 0 if jq fails

# Format the message
if [ "$COMMIT_COUNT" -eq 1 ]; then
  echo "[openzfs] $ACTOR pushed 1 commit to $BRANCH"
else
  echo "[openzfs] $ACTOR pushed $COMMIT_COUNT commits to $BRANCH"
fi

echo "$COMPARE_URL"

# Print each commit title
echo "$COMMIT_TITLES"

