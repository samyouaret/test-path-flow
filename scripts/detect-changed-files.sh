#!/bin/bash

BASE_REF=$1
CURRENT_SHA=$2
PATTERN=$3

CHANGED_FILES=$(git diff --name-only "$BASE_REF" "$CURRENT_SHA" | grep -E "$PATTERN")
echo "Changed files: $CHANGED_FILES"

# Extract all environments from changed files
ENVS=$(echo "$CHANGED_FILES" | grep -o -E "environments/(prd|stg|qa)/" | sort | uniq | wc -l)
if [ "$ENVS" -gt 1 ]; then
  echo "Error: Changes spanning multiple environments detected ($ENVS). Please limit changes to one environment at a time."
  exit 1
fi

FIRST_FILE=$(echo "$CHANGED_FILES" | head -n 1)
echo "file=$FIRST_FILE" >> "$GITHUB_OUTPUT"
