# Platform Adapter: Claude — web-research

## Source Skill

- **Universal skill:** `skills/web-research/SKILL.md`
- **Version:** 1.0.0
- **Platform:** Claude (Claude Code / project instructions)

## Mapping Summary

| Universal Concept | Claude Equivalent |
|---|---|---|
| Skill name | `name: web-research` |
| Short capability description | `description` frontmatter |
| User prompt / query | `argument-hint` and the user's natural-language request |
| `web_search` tool | The agent's available web search capability |
| `web_fetch` tool | The agent's available page fetch/read capability |
| Input `query` | The user's natural-language question |
| Input `max_sources` | Inferred from the prompt or set to a default of `5` |
| Input `output_format` | Handled in the skill body (default `markdown`) |
| Output Markdown | Returned directly in the conversation |

## Installation

1. Copy the `SKILL.md` content into a project instruction, `CLAUDE.md` file, or Claude Code skills directory:

```text
CLAUDE.md
```

2. Restart or refresh the Claude Code session so the instructions are loaded.
3. Invoke the skill with a research question.

## Runtime Configuration

- No authentication is required by the skill itself.
- The agent must have access to a web search and page fetch capability.
- `allowed-tools` limits the skill to `web_search` and `webfetch`.
- `triggers: [user]` means the skill is invoked by the user, not by the model.

## Security and Confirmation Notes

- All universal safety requirements are preserved.
- The skill remains read-only; it does not create files, modify databases, or send messages.
- No credentials are embedded in the skill.
- If the platform does not support confidence labels, express them as a short sentence.
