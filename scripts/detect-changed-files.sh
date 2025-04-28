#!/bin/bash

#  echo github env vars
echo "GITHUB_EVENT_NAME: $GITHUB_EVENT_NAME"
echo "GITHUB_SHA: $GITHUB_SHA"
echo "GITHUB_REF: $GITHUB_REF"
# Set the right reference based on event type
if [ "$GITHUB_EVENT_NAME" == "pull_request" ]; then
  BASE_REF="$PR_BASE_SHA"
else
  BASE_REF="$BEFORE_SHA"
fi

echo "Base reference: $BASE_REF"
echo "Current Head reference: $GITHUB_SHA"

CHANGED_FILES=$(git diff --name-only $BASE_REF $GITHUB_SHA | grep -E "^environments/.+/lmd-odoo-integration-service/")
echo "Changed files: $CHANGED_FILES"

# Extract all environments from changed files
ENVS=$(echo "$CHANGED_FILES" | grep -o -E "environments/(prd|stg|qa)/" | sort | uniq | wc -l)
if [ $ENVS -gt 1 ]; then
  echo "Error: Changes spanning multiple environments detected ($ENVS). Please limit changes to one environment at a time."
  exit 1
fi

FIRST_FILE=$(echo "$CHANGED_FILES" | head -n 1)
echo "file=$FIRST_FILE" >> $GITHUB_OUTPUT