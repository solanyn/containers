#!/bin/sh

# Wait for initial database
while [ ! -f "$KIRO_CLI_DB_FILE" ]; do
  echo "Waiting for $KIRO_CLI_DB_FILE..."
  echo "Run: kubectl cp ~/Library/Application\\ Support/kiro-cli/data.sqlite3 <pod-name>:$KIRO_CLI_DB_FILE -n <namespace>"
  sleep 10
done

# Start main application
exec python main.py
