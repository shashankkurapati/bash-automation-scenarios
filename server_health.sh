#!/bin/bash
# Scenario: Manager asked "how do we know
# if the server is struggling?"
# Wrote this in 20 minutes.

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
RAM=$(free | awk '/Mem/{printf "%.0f", $3/$2*100}')
DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

echo "=============================="
echo " Server Health Report"
echo " $(date '+%Y-%m-%d %H:%M:%S')"
echo "=============================="
echo " CPU Usage  : $CPU%"
echo " RAM Usage  : $RAM%"
echo " Disk Usage : $DISK%"
echo "=============================="

# Auto alert if anything crosses 85%
if [ $CPU -gt 85 ] || [ $RAM -gt 85 ] || [ $DISK -gt 85 ]; then
    echo "⚠️  WARNING: Resource threshold crossed!"
fi
