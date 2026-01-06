#!/bin/sh

# Wait for initial database
while [ ! -f "$KIRO_CLI_DB_FILE" ]; do
  echo "Waiting for $KIRO_CLI_DB_FILE..."
  echo "Run: kubectl cp ~/Library/Application\\ Support/kiro-cli/data.sqlite3 <pod-name>:$KIRO_CLI_DB_FILE -n <namespace>"
  sleep 10
done

# Start token refresh daemon in background
{
  while true; do
    sleep 300  # Check every 5 minutes
    
    # Check if tokens are expiring soon (within 30 minutes)
    if sqlite3 "$KIRO_CLI_DB_FILE" "SELECT datetime(json_extract(value, '$.expires_at')) < datetime('now', '+30 minutes') FROM auth_kv WHERE key = 'kirocli:odic:token'" | grep -q 1; then
      echo "Token expiring soon, refreshing via kiro-cli..."
      if kiro-cli chat "hi" --non-interactive --agent default >/dev/null 2>&1; then
        echo "Token refreshed successfully"
      else
        echo "Token refresh failed"
      fi
    fi
  done
} &

# Start main application
exec python main.py
