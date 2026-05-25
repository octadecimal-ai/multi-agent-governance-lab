# Knowledge Propagation Model

Agent work creates operational knowledge. Without a promotion path, that knowledge stays trapped in chat context and disappears.

## Layers

| Layer | Purpose | Governance |
| --- | --- | --- |
| Session notes | Immediate reasoning and scratch context | Ephemeral |
| Team memory | Reusable team-specific learnings | Team review |
| Shared knowledge | Cross-team rules, runbooks and patterns | Maintainer review |
| Canonical documentation | Stable source of truth | Human approval |
| Embeddings/indexes | Retrieval acceleration | Derived from approved docs |

## Promotion workflow

1. Capture a finding during execution.
2. Classify it as local, team, shared or canonical.
3. Write a concise durable note.
4. Link it to the originating task or incident.
5. Review before promoting to shared/canonical documentation.
6. Rebuild indexes from approved documentation only.

## Anti-patterns

- Treating chat history as documentation.
- Letting agents silently edit canonical policy.
- Embedding unreviewed transcripts into retrieval stores.
- Mixing customer material with framework knowledge.
- Allowing generated summaries to overwrite original evidence.

