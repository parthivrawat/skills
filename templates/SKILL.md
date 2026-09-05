---
name: <unique-skill-name>
version: <semantic-version>
description: <short capability description>
author: <author-or-organization>
license: <license>
status: <stable|beta|alpha|experimental|deprecated>
category: <category-slug>
tags:
  - <tag>
  - <tag>
  - <tag>
related:
  - <related-skill-name>
---

# <Skill Name>

Inherits the shared baseline in [../_shared/CORE.md](../_shared/CORE.md)
(context integrity, baseline decision rule, error handling, safety, quality,
validation, and versioning). Only skill-specific rules appear below.

## Purpose

<What this skill enables an agent to accomplish.>

## Scope

### In Scope

- <capability>

### Out of Scope

- <non-capability>

## When to Use

- <trigger condition>

## When Not to Use

- <condition>

## Preconditions

- <precondition>

## Inputs

| Input | Required | Type | Description | Default |
|---|---|---|---|---|
| <input> | Yes/No | <type> | <description> | <default> |

## Context

<Skill-specific contextual information the agent may use. Omit the generic
"do not assume information" rule — it is inherited from CORE.md.>

## Tools and Resources

| Tool / Resource | Required | Purpose | Constraints |
|---|---|---|---|
| <tool> | Yes/No | <purpose> | <constraints> |

## Procedure

1. **<Name>** — <instruction>
2. **<Name>** — <instruction>

## Decision Rules

1. IF <condition>, THEN <action>.

<Only skill-specific rules; the baseline anti-fabrication rule is inherited.>

## Output Contract

### Primary Output

<description>

### Output Format

```text
<canonical output structure>
```

### Output Requirements

- <requirement>

## Error Handling

Follow CORE.md § Error Handling Protocol. Skill-specific failures:

- <failure>: <recovery>

## Safety and Security

Apply CORE.md § Safety and Security Baseline. Additionally:

- <skill-specific constraint>

## Quality Requirements

CORE.md baseline, plus: <skill-specific requirement>.

## Examples

### Example 1 — Basic

**Input**

<example>

**Expected Output**

<output>

### Example 2 — Edge Case

**Input**

<example>

**Expected Behavior**

<behavior>

## Related Skills

- [<skill-name>](../<skill-name>/SKILL.md) — <when to chain to it>

## Validation

Run the CORE.md § Validation Checklist.

## Dependencies

<list, or `None.`>

## Versioning

SemVer per CORE.md § Versioning.

## Change History

### <version> — <date>

- <change>
