# Platform Adapter: Devin CLI — web-research

## Source Skill

- **Universal skill:** `skills/web-research/SKILL.md`
- **Version:** 1.0.0
- **Platform:** Devin CLI

## Mapping Summary

| Universal Concept | Devin CLI Equivalent |
|---|---|
| Skill name | `name: web-research` |
| Short capability description | `description` frontmatter |
| User query | `argument-hint` and the slash command argument (e.g., `/web-research "..."`) |
| `web_search` tool | `web_search` tool or an equivalent MCP tool |
| `web_fetch` tool | `webfetch` tool or an equivalent MCP tool |
| Input `query` | The slash command argument |
| Input `max_sources` | Inferred from the prompt or set to a default |
| Input `output_format` | Handled in the skill body (default `markdown`) |
| Output Markdown | Returned by the subagent |

## Installation

1. Copy this directory to a Devin skills directory, e.g.:

```text
.devin/skills/web-research/SKILL.md
```

or globally:

```text
%APPDATA%\devin\skills\web-research\SKILL.md
```

2. If `web_search` or `webfetch` are not built-in Devin tools, configure an MCP server and update `allowed-tools` accordingly.
3. Restart Devin or refresh the skill index.
4. Invoke with `/web-research "<research question>"`.

## Runtime Configuration

- `subagent: true` keeps the research work out of the main conversation.
- `triggers: [user]` means the skill is only invoked by the user, not by the model.
- `allowed-tools` limits the subagent to the web tools.

## Security and Confirmation Notes

- All universal safety requirements are preserved.
- The skill is read-only; it does not create files, modify databases, or send messages.
- No credentials are embedded in the skill.
- If an MCP tool is used, ensure it does not expose user data.
