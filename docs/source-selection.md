# Source Selection and Sanitization Notes

This repository is assembled from sanitized patterns, not from raw private operational material.

## Included directly

- Generic developer team rules.
- Generic security audit checklist.
- Public-safe governance documentation created for this repository.
- Synthetic examples for approvals, audit logs and watchdog events.

## Adapted conceptually

- macOS agent hook lifecycle and watchdog ideas.
- OpenHands/BMAD role, checklist and story workflow patterns.
- Multi-agent approval queues and executor-loop separation.
- Knowledge promotion between session, team and canonical documentation.

## Excluded

- Customer-specific architecture documents.
- Real hostnames, domains, IP addresses and service inventory.
- Transcripts with personal or private project context.
- Secret manager token names, local Keychain service identifiers and runtime paths.
- Operational runbooks that expose production topology.
- Raw monitoring digests and generated logs.

## History policy

The public history is intentionally reduced to safe source documents and a sanitization commit. Removing a file in the latest commit is not enough, because Git history would still expose previous content. Sensitive or noisy files must be removed from history before publication.

