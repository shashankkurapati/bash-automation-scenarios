#!/bin/bash
# Scenario: Team was manually zipping project folders
# every Friday. Someone always forgot.
# I automated it in 15 lines.

BACKUP_DIR="/home/shashank/backups"
SOURCE="/var/www/project"
DATE=$(date +%F_%H-%M)
FILENAME="project_backup_$DATE.tar.gz"

mkdir -p $BACKUP_DIR

tar -czf "$BACKUP_DIR/$FILENAME" "$SOURCE" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✅ Backup successful: $FILENAME"
else
    echo "❌ Backup failed! Check source path."
    exit 1
fi
