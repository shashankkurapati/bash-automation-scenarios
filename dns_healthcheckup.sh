#!/bin/bash

# =========================================================
# DNS & Network Health Check Script
# Purpose:
#   Validate DNS resolution and internet connectivity
#   after patching/reboot activities.
# =========================================================

LOGFILE="/var/log/dns_healthcheck.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "=================================================" >> "$LOGFILE"
echo "DNS Validation Started : $DATE" >> "$LOGFILE"
echo "=================================================" >> "$LOGFILE"

# ---------------------------------------------------------
# Check if /etc/resolv.conf exists
# ---------------------------------------------------------
if [ ! -f /etc/resolv.conf ]; then
    echo "[ERROR] /etc/resolv.conf file is missing!" >> "$LOGFILE"
    exit 1
fi

# ---------------------------------------------------------
# Check if nameserver entry exists
# ---------------------------------------------------------
if ! grep -q "^nameserver" /etc/resolv.conf; then
    echo "[ERROR] No nameserver configured in /etc/resolv.conf" >> "$LOGFILE"
    exit 1
fi

# ---------------------------------------------------------
# Check DNS Resolution
# ---------------------------------------------------------
if ! ping -c 2 google.com > /dev/null 2>&1; then
    echo "[ERROR] DNS resolution failed! Unable to resolve domain names." >> "$LOGFILE"
    exit 1
fi

# ---------------------------------------------------------
# Check Internet Connectivity
# ---------------------------------------------------------
if ! ping -c 2 8.8.8.8 > /dev/null 2>&1; then
    echo "[ERROR] Internet connectivity failed!" >> "$LOGFILE"
    exit 1
fi

# ---------------------------------------------------------
# Success Message
# ---------------------------------------------------------
echo "[SUCCESS] DNS and Network are healthy." >> "$LOGFILE"
echo "" >> "$LOGFILE"

exit 0
