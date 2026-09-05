# Skill Registry

This file lists the skills and platform adapters in the library. See
[skills/_index.md](skills/_index.md) for routing guidance and the skill
composition graph, and [skills/_shared/CORE.md](skills/_shared/CORE.md) for the
shared baseline every skill inherits.

## Skills

| Skill | Version | Status | Tags | Related | Adapters |
|---|---|---|---|---|---|
| [web-research](skills/web-research/SKILL.md) | 1.1.0 | stable | web, research, search, summarization | document-summarization, csv-analysis | windsurf, devin, openai, claude, cursor |
| [code-review](skills/code-review/SKILL.md) | 1.1.0 | stable | code, review, quality, static-analysis, collaboration | security-audit, requirements-analysis | — |
| [security-audit](skills/security-audit/SKILL.md) | 1.1.0 | stable | security, audit, vulnerabilities, secrets, static-analysis | code-review | — |
| [document-summarization](skills/document-summarization/SKILL.md) | 1.1.0 | stable | documents, summarization, text-analysis, content-processing | meeting-notes, email-drafting, web-research | — |
| [requirements-analysis](skills/requirements-analysis/SKILL.md) | 1.1.0 | stable | requirements, analysis, specification, elicitation, planning | meeting-notes, code-review | — |
| [meeting-notes](skills/meeting-notes/SKILL.md) | 1.1.0 | stable | meetings, notes, summarization, action-items, collaboration | email-drafting, requirements-analysis, document-summarization | — |
| [email-drafting](skills/email-drafting/SKILL.md) | 1.1.0 | stable | email, writing, communication, drafting, productivity | meeting-notes, document-summarization | — |
| [csv-analysis](skills/csv-analysis/SKILL.md) | 1.1.0 | stable | csv, data, analysis, statistics, quality | document-summarization, web-research | — |

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
