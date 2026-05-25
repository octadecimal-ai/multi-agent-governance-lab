# Approval and Audit Model

## Request lifecycle

```mermaid
flowchart LR
  A[Agent request] --> B[Policy classification]
  B -->|low risk| C[Direct execution]
  B -->|medium or high risk| D[Pending approval]
  D --> E[Human review]
  E -->|approve| F[Approved queue]
  E -->|reject| G[Rejected queue]
  F --> H[Executor loop]
  H -->|success| I[Executed archive]
  H -->|failure| J[Failed archive]
  C --> K[Audit log]
  I --> K
  J --> K
  G --> K
```

## Audit event fields

Each event should include:

- timestamp,
- request id,
- actor id,
- effective OS user or runtime identity,
- action name,
- target path, resource or service,
- risk level,
- approval id when required,
- result status,
- failure reason when applicable,
- correlation id for multi-step workflows.

## Executor behavior

The executor should be intentionally small:

- read only approved request files,
- parse structured JSON,
- route by explicit action name,
- reject unknown actions,
- never infer missing destructive intent,
- move processed requests to immutable result folders,
- append audit events before and after execution.

## Why this matters

This structure creates evidence for regulatory and security review: who requested an action, who approved it, what actually ran, when it ran and what happened.

