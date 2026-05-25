# Multi-Agent Governance Lab

Public, sanitized portfolio extract showing governance patterns for multi-agent engineering systems.

This repository focuses on control design rather than private infrastructure. It documents how agent teams can be governed with explicit authority boundaries, human approval, immutable audit events, watchdog escalation, role-based operating rules and secret isolation.

## What is inside

- [Governance overview](docs/governance-overview.md)
- [Approval and audit model](docs/approval-and-audit-model.md)
- [Agent order lifecycle](docs/agent-order-lifecycle.md)
- [Knowledge propagation model](docs/knowledge-propagation-model.md)
- [macOS agent guardrails](docs/macos-agent-guardrails.md)
- [OpenHands and BMAD patterns](docs/openhands-bmad-patterns.md)
- [Security architecture pattern](docs/security-architecture-pattern.md)
- [Source selection and sanitization notes](docs/source-selection.md)
- [Tool risk matrix](policies/tool-risk-matrix.yaml)
- [Escalation policy](policies/escalation-policy.yaml)
- [Example approval request](examples/approval-request.example.json)
- [Example audit events](examples/audit-events.example.jsonl)

## Design principles

1. Agents propose, humans authorize irreversible or privileged actions.
2. Approval and execution are separate responsibilities.
3. Runtime identity is explicit and visible in every audit event.
4. Logs describe action intent, target, actor, approval source and result.
5. Secrets are resolved outside model context and never copied into prompts.
6. Guardrails are enforced before tools execute, not only after a failure.
7. Knowledge created during work must be promoted into durable, reviewable documentation.

## Scope

This is a lab-quality reference implementation and documentation set. It intentionally excludes customer material, private domains, credentials, host inventories and transcripts.

## Provenance

The structure is adapted from private research and implementation work around multi-agent engineering, macOS agent workspaces, OpenHands/BMAD workflows, tool approval queues and audit logging. Only sanitized patterns are included here.

