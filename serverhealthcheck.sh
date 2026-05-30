#!/bin/bash
# Server Health Monitor
# Replaces 25 hours of manual work daily

THRESHOLD=80
SERVERS=("web01" "web02" "db01" "db02" "cache01")
LOG="/var/log/health_$(date +%F).log"

for SERVER in "${SERVERS[@]}"; do
    USAGE=$(ssh $SERVER "df -h / | awk 'NR==2{print \$5}' | tr -d '%'")
    CPU=$(ssh $SERVER "top -bn1 | grep 'Cpu(s)' | awk '{print \$2}'")

    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        echo "🚨 CRITICAL: $SERVER disk at $USAGE%" \
        | slack-notify "#alerts"
    fi

    echo "$SERVER | Disk: $USAGE% | CPU: $CPU%" >> $LOG
done
