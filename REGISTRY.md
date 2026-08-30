# Skill Registry

This file lists the skills and platform adapters in the library.

## Skills

| Skill | Version | Status | Tags | Adapters |
|---|---|---|---|---|
| [web-research](skills/web-research/SKILL.md) | 1.0.0 | stable | web, research, search, summarization | windsurf, devin, openai, claude, cursor |
| [code-review](skills/code-review/SKILL.md) | 1.0.0 | stable | code, review, quality, static-analysis, collaboration | — |
| [security-audit](skills/security-audit/SKILL.md) | 1.0.0 | stable | security, audit, vulnerabilities, secrets, static-analysis | — |

## Adapters

| Platform | Skill | Artifact |
|---|---|---|
| Windsurf | web-research | [adapters/windsurf/web-research/SKILL.md](adapters/windsurf/web-research/SKILL.md) |
| Devin CLI | web-research | [adapters/devin/web-research/SKILL.md](adapters/devin/web-research/SKILL.md) |
| OpenAI | web-research | [adapters/openai/web-research/tool.json](adapters/openai/web-research/tool.json) |
| Claude | web-research | [adapters/claude/web-research/SKILL.md](adapters/claude/web-research/SKILL.md) |
| Cursor | web-research | [adapters/cursor/web-research/SKILL.md](adapters/cursor/web-research/SKILL.md) |

## Using the Registry

- Human-readable: `REGISTRY.md`
- Machine-readable: `catalog.json`
- See `README.md` for quickstart and contribution guidelines.
