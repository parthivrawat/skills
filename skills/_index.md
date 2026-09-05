# Skill Index

Routing hub for the library. Load this file first to pick a skill, then load
only that skill's `SKILL.md`. Shared rules live in [_shared/CORE.md](_shared/CORE.md)
and are inherited by every skill — do not reload them per skill.

## Skills

| Skill | Category | Use when |
|---|---|---|
| [web-research](web-research/SKILL.md) | development-tools | Answer needs current or authoritative web sources. |
| [code-review](code-review/SKILL.md) | development-tools | A code change needs correctness/style/security review. |
| [security-audit](security-audit/SKILL.md) | security | A codebase or artifact needs vulnerability/secret scanning. |
| [document-summarization](document-summarization/SKILL.md) | content-processing | A document needs a faithful, condensed summary. |
| [requirements-analysis](requirements-analysis/SKILL.md) | requirements-engineering | An informal request needs structured requirements. |
| [meeting-notes](meeting-notes/SKILL.md) | productivity | A transcript/notes need decisions and action items. |
| [email-drafting](email-drafting/SKILL.md) | communication | A message needs drafting for review (not sending). |
| [csv-analysis](csv-analysis/SKILL.md) | data-analysis | A CSV/delimited file needs profiling or quality checks. |

## Composition Graph

Hand off between skills when a workflow spans multiple capabilities:

- `web-research` → `document-summarization`: condense long fetched pages.
- `document-summarization` → `meeting-notes`: summarize a transcript before
  extracting minutes.
- `meeting-notes` → `email-drafting`: draft follow-ups from action items.
- `meeting-notes` → `requirements-analysis`: turn recorded asks into
  requirements.
- `requirements-analysis` → `code-review`: supply acceptance criteria as the
  review baseline.
- `code-review` → `security-audit`: escalate suspicious code to a full audit.
- `security-audit` → `code-review`: fold audit findings into a review report.
- `document-summarization` → `email-drafting`: summarize prior threads or
  referenced documents before drafting.

Edges are also declared in each skill's `related:` frontmatter field and its
`## Related Skills` section.
