#!/bin/bash
# Scenario: Our web service kept dying silently.
# Nobody noticed until users complained.
# Fixed it with 10 lines.

SERVICE="nginx"

while true; do
    if ! pgrep -x "$SERVICE" > /dev/null; then
        echo "$(date): $SERVICE is DOWN. Restarting..." \
          >> /var/log/watchdog.log
        systemctl restart $SERVICE
        echo "$(date): $SERVICE restarted." \
          >> /var/log/watchdog.log
    fi
    sleep 30
done
