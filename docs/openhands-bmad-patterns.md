# OpenHands and BMAD Patterns

This document captures safe, reusable patterns observed in OpenHands/BMAD-style agent workflows.

## Useful patterns

| Pattern | Use |
| --- | --- |
| Role-specific skills | Keep analyst, architect, developer, QA and writer behavior explicit |
| Spec-driven work | Require a small spec before implementation begins |
| Checklist-based readiness | Verify scope, dependencies, tests and acceptance criteria |
| Story automation | Convert goals into reviewed stories and implementation tasks |
| Adversarial review | Assign a critic role for risk, edge cases and missing tests |
| Technical research templates | Separate facts, assumptions, references and recommendations |
| Sprint status files | Make workflow state machine-readable |
| Retrospective notes | Feed process improvements back into team rules |

## Governance additions

For production-like use, add controls that are often missing in prototype agent teams:

- tool risk classification,
- approval gates for privileged tools,
- audit logs for both accepted and rejected actions,
- explicit secret resolution pattern,
- sandbox boundary documentation,
- data classification for input documents,
- retention policy for transcripts and generated artifacts.

## Public portfolio use

The most valuable public artifacts are not raw transcripts. They are reusable patterns: lifecycle diagrams, policy matrices, audit schemas, examples and small guardrail scripts.

