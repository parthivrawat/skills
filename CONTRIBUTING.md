# Contributing

## Skill Creation Workflow

When adding a new skill, follow the six-phase workflow:

1. **Understand** — Identify name, objective, target users, use cases, inputs, outputs, tools, constraints, risks, and dependencies.
2. **Design** — Create metadata, scope, triggers, input/output contracts, procedure, decision rules, error handling, security model, examples, and tests.
3. **Normalize** — Check the skill against the universal specification for terminology, naming, metadata, inputs/outputs, error semantics, versioning, security language, and formatting.
4. **Validate** — Run `.\scripts\validate.ps1` and then `.\scripts\quality-gate.ps1` to review the Quality Gate. If you also produce a machine-readable skill contract, verify it against `schemas/skill.schema.json` or `schemas/skill.schema.yaml`.
5. **Package** — Produce the final `SKILL.md` and optional `README.md`, `examples/`, `tests/`, and platform adapters.
6. **Explain** — Briefly summarize what the skill does, when to use it, its major inputs/outputs, dependencies, platform considerations, and validation status.

## Naming

- Use lowercase `kebab-case`.
- Prefer `<domain>-<capability>` or `<domain>-<object>-<action>`.
- Examples: `web-research`, `csv-analysis`, `github-issue-triage`.

## Required Skill Sections

A complete `SKILL.md` must contain:

- Purpose
- Scope (In Scope / Out of Scope)
- When to Use
- When Not to Use
- Preconditions
- Inputs
- Context
- Tools and Resources
- Procedure
- Decision Rules
- Output Contract
- Error Handling
- Safety and Security
- Quality Requirements
- Examples
- Validation
- Dependencies
- Versioning
- Change History

## Quality Gate

Before submitting a skill, verify:

- It has a unique name.
- It has a semantic version.
- Its purpose and scope are explicit.
- Its triggers and negative triggers are defined.
- Inputs and outputs are documented.
- Tools are abstracted where possible.
- The procedure is executable.
- Decision logic is explicit.
- Error handling is defined.
- Security constraints exist.
- Side effects and confirmation requirements are documented.
- Examples and edge cases exist.
- Tests exist.
- Dependencies are documented.
- No unsupported claims, secrets, or unnecessary vendor assumptions.
- The skill is composable and adaptable.
