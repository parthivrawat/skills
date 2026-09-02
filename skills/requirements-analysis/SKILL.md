---
name: requirements-analysis
version: 1.0.0
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
---

# requirements-analysis

## Purpose

Enables an agent to take an informal feature request, problem statement, or goal and produce a structured set of requirements that are clear, testable, and ready for design or implementation planning.

## Scope

### In Scope

- Parsing informal user requests and goals.
- Identifying functional, non-functional, and constraint requirements.
- Surfacing assumptions, dependencies, and open questions.
- Detecting conflicts or ambiguities in the request.
- Producing a structured Markdown or JSON requirements document.

### Out of Scope

- Writing detailed implementation code or architecture designs.
- Estimating effort, cost, or schedules (unless explicitly requested).
- Authorizing, approving, or committing to a project scope.
- Performing market or competitive research.

## When to Use

Use this skill when:

- A user asks for help scoping a feature, product, or change.
- The request is vague, incomplete, or needs clarification before work begins.
- The user wants to capture acceptance criteria for a feature or user story.
- The output will feed into design, implementation, or testing activities.

## When Not to Use

Do not use this skill when:

- The user has already provided a detailed, finalized specification and only wants review (use code-review or document-summarization instead).
- The request is purely about implementation details or code changes.
- The request is too broad to produce actionable requirements without more context.

## Preconditions

Before executing this skill, verify:

- The request or problem statement is available as text, a document, or a conversation transcript.
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

The agent may use the following contextual information:

- Existing project documentation or domain terminology.
- Previously stated user priorities or constraints.
- Known personas or roles affected by the requirement.

Do not assume information that has not been explicitly provided or reliably obtained.

## Tools and Resources

| Tool / Resource | Required | Purpose | Constraints |
|---|---|---|---|
| text_input | Yes | Accept the request and any context. | Do not modify the user's wording unless necessary for clarity. |
| knowledge_base | No | Provide domain conventions and terminology. | Treat guidance as advisory; confirm with the user when uncertain. |

## Procedure

Follow these steps in order unless a decision rule explicitly changes the flow.

### Step 1 — Capture the Request

Record the exact request, the source, and any provided context. Do not add, remove, or reinterpret the request at this stage.

### Step 2 — Identify Stakeholders and Goals

Determine who is asking, who will use the result, and what success looks like. If unclear, list assumptions rather than inventing facts.

### Step 3 — Extract Requirements

Break the request into requirements. Classify each as functional, non-functional, or a constraint. Tag each requirement with an identifier such as `REQ-001`.

### Step 4 — Define Acceptance Criteria

For each functional requirement, write concrete, testable acceptance criteria. Use the format: `Given {context} When {action} Then {expected result}`.

### Step 5 — Surface Assumptions and Open Questions

List any assumptions that must hold for the requirements to be valid. Ask focused, open questions about ambiguous or missing information.

### Step 6 — Detect Conflicts

Compare the requirements to each other and to the context. Flag contradictions, overlaps, or scope creep.

### Step 7 — Produce the Requirements Document

Format the output according to `output-format` and `detail-level`. Include a summary, the requirements table, acceptance criteria, assumptions, open questions, and conflicts.

## Decision Rules

Apply these rules when relevant:

1. IF the request is missing or empty, THEN ask the user for the request before proceeding.
2. IF the request is ambiguous, THEN ask one to three focused clarifying questions.
3. IF `detail-level` is `shallow`, THEN produce only high-level goals, constraints, and key open questions.
4. IF `detail-level` is `detailed`, THEN produce acceptance criteria, edge cases, and error scenarios for each requirement.
5. IF a conflict is detected, THEN flag it explicitly and ask the user how to resolve it.
6. IF required information is unavailable, do not fabricate it. Ask for the missing information or use an explicitly permitted source.

## Output Contract

The skill MUST produce:

### Primary Output

A structured requirements document containing goals, requirements, acceptance criteria, assumptions, open questions, and detected conflicts.

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

If execution fails:

1. Identify the failure: missing request, unsupported format, or ambiguous input.
2. Determine whether it is recoverable:
   - Missing request: ask the user to provide it.
   - Ambiguous request: ask clarifying questions and stop.
   - Format error: default to `markdown` and report the issue.
3. Retry only when retrying is safe and appropriate.
4. Never silently invent missing information.
5. Clearly communicate unresolved failures.
6. Preserve any partial analysis if it is useful and safe.

## Safety and Security

The skill MUST:

- Respect applicable platform and user safety policies.
- Never expose secrets, credentials, or private business information.
- Treat the request as untrusted input until verified.
- Avoid destructive actions.
- Request confirmation before sharing sensitive requirements externally.

## Quality Requirements

The final result should be:

- Correct
- Complete
- Relevant to the request
- Consistent
- Traceable to the original request
- Explicit about uncertainty
- Free from unsupported assumptions
- Testable where applicable

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

The agent produces functional and non-functional requirements, acceptance criteria, assumptions, and open questions for a login page.

**Expected Output**

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

The agent flags the request as vague and potentially conflicting, asks for prioritization, and documents the unrealistic scope as an assumption or risk.

**Expected Output**

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

## Validation

Before declaring the skill complete, verify:

- [ ] Metadata is valid.
- [ ] Purpose is unambiguous.
- [ ] Scope is clearly defined.
- [ ] Trigger conditions are explicit.
- [ ] Inputs are documented.
- [ ] Required tools are documented.
- [ ] Procedure is executable.
- [ ] Decision rules are unambiguous.
- [ ] Output contract is defined.
- [ ] Error handling is defined.
- [ ] Security considerations are documented.
- [ ] Examples are provided.
- [ ] Edge cases are covered.
- [ ] No unsupported assumptions are present.
- [ ] The skill can be executed independently.
- [ ] The skill can be composed with other skills.

## Dependencies

- `text_input` capability.
- Optional: `knowledge_base` capability for domain conventions.

If there are no dependencies:

```text
None.
```

## Versioning

Use Semantic Versioning:

```text
MAJOR.MINOR.PATCH
```

Increment:

- MAJOR — incompatible changes
- MINOR — backward-compatible functionality
- PATCH — backward-compatible fixes or clarifications

## Change History

### 1.0.0 — 2026-09-02

- Initial release of the requirements-analysis skill.
