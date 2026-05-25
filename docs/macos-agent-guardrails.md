# macOS Agent Guardrails

This pattern is adapted from macOS-based agent workspace experiments. The goal is to let agents work on local machines while keeping destructive actions visible and controlled.

## Hook lifecycle

| Hook | Purpose |
| --- | --- |
| Session start | Load project context and current policy |
| User prompt submit | Detect high-risk instructions before planning |
| Pre-tool use | Block dangerous commands and require approval |
| Post-tool batch | Log what tools ran and what changed |
| Config change | Detect policy or runtime modifications |
| Pre-compact | Extract durable notes before context compression |
| Subagent stop | Promote useful subagent findings |
| Stop/session end | Produce summary and evidence pointers |

## Watchdog checks

The watchdog should detect:

- commands matching destructive patterns,
- writes outside allowed roots,
- attempts to read secret locations,
- unresolved approvals,
- long-running blocked tasks,
- repeated tool failures,
- config changes affecting guardrails.

## Example pre-tool policy

```bash
#!/usr/bin/env bash
set -euo pipefail

payload="${1:-}"

case "$payload" in
  *"rm -rf /"*|*"diskutil erase"*|*"security find-generic-password"*)
    echo "blocked: high-risk command requires explicit approval" >&2
    exit 42
    ;;
esac

exit 0
```

## macOS-specific controls

- Use separate OS accounts for owner, admin and agent runtime.
- Restrict SSH access to accounts that need it.
- Keep secret material in Keychain or a secret manager, not files in repos.
- Prefer group-based shared directories with setgid for predictable ownership.
- Use ACL deny rules for locked context areas when POSIX mode bits are insufficient.
- Collect evidence with read-only commands before changing permissions.

