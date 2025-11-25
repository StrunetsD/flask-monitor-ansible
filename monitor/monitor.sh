#!/bin/bash
if [ -f "$(dirname "$0")/.env" ]; then
  set -a
  source "$(dirname "$0")/.env"
  set +a
fi

APP_URL="${APP_URL}"
CHECK_INTERVAL="${CHECK_INTERVAL}"
RESTART_CMD="${RESTART_CMD}"
LOG="${MONITOR_LOG}"


while true; do
    if curl  "$APP_URL" | grep -q "Hello, World"; then
        echo "$(date): OK" >> "$LOG"
    else
        echo "$(date): ERROR – app unreachable" >> "$LOG"
        $RESTART_CMD
        echo "$(date): Restart performed" >> "$LOG"
    fi
    sleep "$CHECK_INTERVAL"
done
