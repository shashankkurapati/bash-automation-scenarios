#!/bin/bash
# Real scenario: Got a 2am alert. Disk at 95%. 
# Found the culprit in 30 seconds.

df -h | awk 'NR>1 {print $5, $6}' | sort -rn | head -5

# Output showed /var/log at 94%
# One command to find the exact file eating space:

find /var/log -type f -exec du -sh {} + 2>/dev/null \
  | sort -rh | head -10

# Deleted old rotated logs. Disk dropped to 40%.
# Total time: 4 minutes.
# Without Linux knowledge: ticket raised, wait 2 hours.
