#!/usr/bin/env bash
set -euo pipefail

queue_dir="${1:-./requests/pending}"
now_epoch="$(date +%s)"
threshold_seconds="$((4 * 60 * 60))"

find "$queue_dir" -type f -name '*.json' 2>/dev/null | while read -r request; do
  modified_epoch="$(stat -f %m "$request" 2>/dev/null || stat -c %Y "$request")"
  age="$((now_epoch - modified_epoch))"
  if (( age > threshold_seconds )); then
    printf '{"ts":"%s","type":"stale_request","path":"%s","age_seconds":%s}\n' \
      "$(date -Iseconds)" "$request" "$age"
  fi
done

