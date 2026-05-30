#!/bin/bash

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 🔧 CONFIG
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SERVERS=("server1" "server2" "server3")
LOG="/var/log/backup_$(date +%F).log"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 💾 BACKUP EACH SERVER
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
for SERVER in "${SERVERS[@]}"; do
    rsync -avz $SERVER:/etc/ /backup/$SERVER/ >> $LOG 2>&1
    echo "✅ $SERVER backed up" | mail -s "Backup Report" admin@company.com
done

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 📊 CHECK DISK USAGE
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━
df -h | awk '$5 > 80 {print "⚠️ ALERT: "$1" at "$5}' \
      | mail -s "Disk Alert" admin@company.com
