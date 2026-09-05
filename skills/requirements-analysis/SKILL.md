---
name: requirements-analysis
version: 1.1.0
description: Transforms informal requests into clear, structured requirements with acceptance criteria, assumptions, and open questions.
author: Universal Agent Skills Library
license: MIT
status: stable
category: requirements-engineering
tags:
  - requirements
  - analysis
  - specification
  - elicitation
  - planning
related:
  - meeting-notes
  - code-review
---

# requirements-analysis

Inherits the shared baseline in [../_shared/CORE.md](../_shared/CORE.md)
(context integrity, baseline decision rule, error handling, safety, quality,
validation, and versioning). Only skill-specific rules appear below.

## Purpose

Transform an informal feature request, problem statement, or goal into a
structured, testable set of requirements ready for design or implementation
planning.

## Scope

### In Scope

- Parse informal user requests and goals.
- Identify functional, non-functional, and constraint requirements.
- Surface assumptions, dependencies, and open questions.
- Detect conflicts or ambiguities.
- Produce a structured Markdown or JSON requirements document.

### Out of Scope

- Writing detailed implementation code or architecture designs.
- Estimating effort, cost, or schedules (unless explicitly requested).
- Authorizing, approving, or committing to a project scope.
- Performing market or competitive research.

## When to Use

- A user asks for help scoping a feature, product, or change.
- The request is vague, incomplete, or needs clarification before work begins.
- The user wants to capture acceptance criteria for a feature or user story.
- The output will feed into design, implementation, or testing activities.

## When Not to Use

- The user already provided a detailed, finalized specification and only wants
  review (use code-review or document-summarization instead).
- The request is purely about implementation details or code changes.
- The request is too broad to produce actionable requirements without more context.

## Preconditions

- The request or problem statement is available as text, a document, or a
  conversation transcript.
- The target audience for the requirements is clear or can be defaulted.
- The user is available to answer clarifying questions if the request is ambiguous.

## Inputs

| Input | Required | Type | Description | Default |
|---|---|---|---|---|
| request | Yes | string | The informal request, goal, or problem statement to analyze. | — |
| domain-context | No | string | Domain, product, or business context that affects interpretation. | none |
| detail-level | No | string | Depth of analysis: `shallow`, `standard`, or `detailed`. | standard |
| output-format | No | string | Preferred output structure: `markdown` or `json`. | markdown |

## Context

- Existing project documentation or domain terminology.
- Previously stated user priorities or constraints.
- Known personas or roles affected by the requirement.

## Tools and Resources

| Tool / Resource | Required | Purpose | Constraints |
|---|---|---|---|
| text_input | Yes | Accept the request and any context. | Do not modify the user's wording unless necessary for clarity. |
| knowledge_base | No | Provide domain conventions and terminology. | Treat guidance as advisory; confirm with the user when uncertain. |

## Procedure

1. **Capture the request** — record the exact request, source, and provided
   context; do not add, remove, or reinterpret at this stage.
2. **Identify stakeholders and goals** — determine who is asking, who will use
   the result, and what success looks like; list assumptions rather than
   inventing facts.
3. **Extract requirements** — break the request into functional, non-functional,
   and constraint requirements; tag each with an identifier such as `REQ-001`.
4. **Define acceptance criteria** — for each functional requirement, write
   concrete, testable criteria using `Given {context} When {action} Then
   {expected result}`.
5. **Surface assumptions and open questions** — list assumptions that must hold
   and ask focused questions about ambiguous or missing information.
6. **Detect conflicts** — compare requirements to each other and to the context;
   flag contradictions, overlaps, or scope creep.
7. **Produce the requirements document** — format output per `output-format`
   and `detail-level`; include summary, requirements table, acceptance criteria,
   assumptions, open questions, and conflicts.

## Decision Rules

1. IF the request is missing or empty, THEN ask the user for the request before proceeding.
2. IF the request is ambiguous, THEN ask one to three focused clarifying questions.
3. IF `detail-level` is `shallow`, THEN produce only high-level goals, constraints, and key open questions.
4. IF `detail-level` is `detailed`, THEN produce acceptance criteria, edge cases, and error scenarios for each requirement.
5. IF a conflict is detected, THEN flag it explicitly and ask the user how to resolve it.

## Output Contract

### Primary Output

A structured requirements document containing goals, requirements, acceptance
criteria, assumptions, open questions, and detected conflicts.

### Output Format

```markdown
## Requirements Analysis

### Summary

{short summary of the request and intended outcome}

### Goals

1. {goal}
2. {goal}

### Requirements

| ID | Type | Requirement | Acceptance Criteria | Priority |
|---|---|---|---|---|
| REQ-001 | functional | {requirement text} | {criteria} | must |
| REQ-002 | non-functional | {requirement text} | {criteria} | should |

### Assumptions

- {assumption}

### Open Questions

1. {question}

### Conflicts

- {conflict or "None identified."}

### Next Steps

- {action}
```

### Output Requirements

- Each functional requirement must have acceptance criteria.
- Priorities must be one of `must`, `should`, or `could`.
- Assumptions and open questions must be explicit.
- The output must match the requested `output-format`.
- Do not invent requirements not supported by the request or context.

## Error Handling

Follow CORE.md § Error Handling Protocol. Skill-specific failures:

- Missing request: ask the user to provide it.
- Ambiguous request: ask clarifying questions and stop.
- Format error: default to `markdown` and report the issue.

## Safety and Security

Apply CORE.md § Safety and Security Baseline. Additionally:

- Never expose secrets, credentials, or private business information from the request.
- Request confirmation before sharing sensitive requirements externally.

## Quality Requirements

CORE.md baseline, plus: requirements must be testable, traceable to the
original request, and free of unsupported assumptions.

## Examples

### Example 1 — Basic

**Input**

```yaml
request: |
  I need a login page where users can sign in with their email and
  password. It should also show an error if the credentials are wrong.
domain-context: consumer web application
detail-level: standard
```

**Expected Behavior**

The agent produces functional and non-functional requirements, acceptance
criteria, assumptions, and open questions for a login page.

**Expected Output** (condensed)

```markdown
## Requirements Analysis

### Summary

Add a login page for a consumer web application that authenticates users by email and password and displays errors for invalid credentials.

### Goals

1. Allow users to access their accounts securely.
2. Provide clear feedback when authentication fails.

### Requirements

| ID | Type | Requirement | Acceptance Criteria | Priority |
|---|---|---|---|---|
| REQ-001 | functional | Users can enter an email and password. | Given the login page, when the user enters valid credentials, then the form accepts the input. | must |
| REQ-002 | functional | Invalid credentials display an error. | Given invalid credentials, when the form is submitted, then an error message is shown without revealing which field is wrong. | must |
| REQ-003 | non-functional | Password entry must be masked. | The password field uses a masked input. | should |

### Assumptions

- User accounts and authentication backend already exist.
- The application is a consumer web app.

### Open Questions

1. Should the page support password recovery or social login?
2. What is the maximum allowed password length?

### Conflicts

None identified.

### Next Steps

- Confirm open questions with the product owner.
- Prepare wireframes and validation rules.
```

### Example 2 — Edge Case

**Input**

```yaml
request: |
  Build a search feature that is extremely fast and supports every
  possible language and file format.
domain-context: internal document repository
detail-level: standard
```

**Expected Behavior**

The agent flags the request as vague and potentially conflicting, asks for
prioritization, and documents the unrealistic scope as assumptions.

**Expected Output** (condensed)

```markdown
## Requirements Analysis

### Summary

Add a fast search feature for an internal document repository with broad language and file-format support.

### Goals

1. Provide fast search across documents.
2. Support a wide range of languages and formats.

### Requirements

| ID | Type | Requirement | Acceptance Criteria | Priority |
|---|---|---|---|---|
| REQ-001 | functional | Users can search the document repository. | A query returns matching documents within a defined latency target. | must |
| REQ-002 | non-functional | Search must be fast. | Query latency is defined and measured. | should |
| REQ-003 | non-functional | Support multiple languages. | Documents in supported languages are searchable. | could |
| REQ-004 | non-functional | Support every file format. | The list of supported formats is explicit and feasible. | could |

### Assumptions

- "Fast" will be defined with a measurable latency target.
- "Every" language and file format will be prioritized and phased.

### Open Questions

1. What latency target defines "extremely fast"?
2. Which languages and file formats are highest priority?
3. Is there an existing search backend to leverage?

### Conflicts

- REQ-002 and REQ-004 may conflict unless scope is phased, because supporting every format immediately can delay delivery.

### Next Steps

- Ask the user to prioritize speed vs. format/language breadth.
- Define a phased rollout plan and acceptance metrics.
```

## Related Skills

- [meeting-notes](../meeting-notes/SKILL.md) — turn recorded asks into requirements.
- [code-review](../code-review/SKILL.md) — supply acceptance criteria as the review baseline.

## Validation

Run the CORE.md § Validation Checklist.

## Dependencies

- `text_input` capability.
- Optional: `knowledge_base` capability for domain conventions.

## Versioning

SemVer per CORE.md § Versioning.

## Change History

### 1.1.0 — 2026-09-05

- Restructured to inherit the shared core contract; added `related` links.

### 1.0.0 — 2026-09-02

- Initial release of the requirements-analysis skill.
