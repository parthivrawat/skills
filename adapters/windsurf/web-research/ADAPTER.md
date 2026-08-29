# Platform Adapter: Windsurf — web-research

## Source Skill

- **Universal skill:** `skills/web-research/SKILL.md`
- **Version:** 1.0.0
- **Platform:** Windsurf (Codeium)

## Mapping Summary

| Universal Concept | Windsurf Equivalent |
|---|---|
| Skill name | `name: web-research` |
| Short capability description | `description` frontmatter |
| User prompt / query | `argument-hint` |
| `web_search` tool | The agent's available web search capability |
| `web_fetch` tool | The agent's available page fetch/read capability |
| Input `query` | The user's natural-language question |
| Output Markdown | Returned directly in the conversation |

## Installation

1. Copy this directory to the Windsurf skills directory, e.g.:

```text
~/.codeium/windsurf/skills/web-research/
```

2. Restart or refresh the Windsurf skill index.
3. Invoke the skill with a research question.

## Runtime Configuration

- No authentication is required by the skill itself.
- The agent must have access to a web search and page fetch capability.
- `max_sources` and `output_format` from the universal input contract become optional natural-language constraints in the adapted body.

## Security and Confirmation Notes

- All universal safety requirements are preserved.
- The skill remains read-only; it does not create files, modify databases, or send messages.
- No credentials are embedded.
- If the platform does not support confidence labels, express them as a short sentence.
