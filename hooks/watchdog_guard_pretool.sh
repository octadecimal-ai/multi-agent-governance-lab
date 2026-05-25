#!/usr/bin/env bash
set -euo pipefail

payload="${1:-}"

blocked_patterns=(
  "rm -rf /"
  "diskutil erase"
  "mkfs"
  "security find-generic-password"
  "chmod -R 777"
)

for pattern in "${blocked_patterns[@]}"; do
  if [[ "$payload" == *"$pattern"* ]]; then
    echo "blocked: command requires explicit approval: $pattern" >&2
    exit 42
  fi
done

exit 0

