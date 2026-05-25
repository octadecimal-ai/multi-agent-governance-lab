# Governance Overview

The governance model separates three concerns:

1. **Intent** - what an agent wants to do and why.
2. **Authority** - who is allowed to approve the action.
3. **Execution** - which isolated runtime performs the action and records the result.

## Control plane

A practical multi-agent control plane contains:

- actor registry with roles, teams and privilege level,
- tool registry with risk classification,
- request queue for actions requiring approval,
- approval queue owned by a human or privileged controller,
- executor loop that performs only approved actions,
- audit log written as append-only events,
- watchdog that detects stuck, risky or policy-breaking flows,
- evidence directory for snapshots and security baselines.

## Runtime roles

| Role | Responsibility | Typical privileges |
| --- | --- | --- |
| Human owner | Business decision, final approval, risk acceptance | Full approval authority |
| Admin operator | System setup, permission changes, incident response | Elevated OS privileges |
| Agent developer | Code and docs contribution | Repository-scoped write |
| Executor | Performs approved tool actions | Narrow tool access |
| Watchdog | Observes status and escalates | Read-mostly monitoring |
| Auditor | Reviews logs, policies and evidence | Read-only access |

## Mandatory controls

- Every privileged operation has an approval record.
- The executor rejects unknown action types.
- The executor logs both start and final state.
- Approval files move through explicit states: pending, approved, executed, rejected or failed.
- Agents cannot directly write to locked context areas.
- Secrets are outside repository scope and outside prompt scope.

