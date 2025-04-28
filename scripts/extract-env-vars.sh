#!/bin/bash

# Get the file from input
FILE="$1"
echo "File used for reference: $FILE"

# Extract environment from the path
ENV=$(echo "$FILE" | cut -d'/' -f2)
WORKING_DIR=$(dirname "$FILE")
PROJECT_ID="ysr-lmd-odoo-$ENV"
SERVICE_ACCOUNT="${PROJECT_ID}-sa@${PROJECT_ID}.iam.gserviceaccount.com"

echo "env=$ENV" >> $GITHUB_OUTPUT
echo "project_id=$PROJECT_ID" >> $GITHUB_OUTPUT
echo "working_directory=$WORKING_DIR" >> $GITHUB_OUTPUT
echo "service_account=$SERVICE_ACCOUNT" >> $GITHUB_OUTPUT

# Print the extracted variables for debugging
echo "Extracted environment variables:"
echo "ENV: $ENV"
echo "WORKING_DIR: $WORKING_DIR"
echo "PROJECT_ID: $PROJECT_ID"
echo "SERVICE_ACCOUNT: $SERVICE_ACCOUNT"