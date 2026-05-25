# MCP Governance Notes

MCP servers are powerful because they turn model intent into tool calls. Treat each server as a privilege boundary.

## Recommended controls

- Maintain an allowlist of MCP servers per agent role.
- Prefer read-only servers for research agents.
- Split write-capable servers into separate profiles.
- Require approval for tools that mutate external systems.
- Do not expose raw credentials as model-readable resources.
- Log server name, tool name, actor and target for every call.

## Tool classification template

| Server | Tool | Risk | Approval | Notes |
| --- | --- | --- | --- | --- |
| git | diff | low | no | Read-only |
| git | push | high | yes | Publishes code |
| filesystem | write_file | medium | conditional | Repository root only |
| secret-manager | resolve | high | yes | Metadata logging only |

