#!/bin/bash

df -h | awk 'NR>1 {print $5, $6}' | sort -rn | head -5

find /var/log -type f -exec du -sh {} + 2>/dev/null \
  | sort -rh | head -10
