# Universal Agent Skills Library

A portable, versioned, and platform-agnostic library of reusable agent skills. Each skill is a well-specified capability that can be consumed by humans, AI agents, and agent platforms.

## Structure

```text
skills/
├── README.md
├── CONTRIBUTING.md
├── LICENSE
├── CHANGELOG.md
├── REGISTRY.md
├── catalog.json
├── .gitignore
├── .github/
│   └── workflows/
│       └── quality-gate.yml
├── schemas/
│   ├── skill.schema.json
│   ├── skill.schema.yaml
│   ├── skill-frontmatter.schema.json
│   └── skill-frontmatter.schema.yaml
├── templates/
│   ├── SKILL.md
│   └── platform-adapter.md
├── skills/
│   ├── _index.md            # routing hub: pick a skill, see composition graph
│   ├── _shared/
│   │   └── CORE.md          # shared baseline inherited by every skill
│   └── <skill-name>/
│       ├── SKILL.md
│       ├── README.md
│       ├── examples/
│       └── tests/
├── adapters/
│   └── .gitkeep
├── examples/
│   ├── .gitkeep
│   ├── example-skill.json
│   └── example-skill.yaml
└── scripts/
    ├── validate.ps1
    └── quality-gate.ps1
```

## Quickstart

1. Copy `templates/SKILL.md` to `skills/<skill-name>/SKILL.md`.
2. Follow the six-phase workflow in `CONTRIBUTING.md`.
3. Fill in the template with the skill's metadata, contracts, procedure, and examples.
4. Run the validation script:

```powershell
.\scripts\validate.ps1
```

## Design Principles

- Portable and platform-agnostic core specification
- Explicit inputs and outputs
- Deterministic procedures where possible
- Security by default
- Composability and testability
- Token-efficient: shared rules live once in `skills/_shared/CORE.md` and are
  inherited by reference; `skills/_index.md` routes to the right skill and maps
  cross-skill composition via each skill's `related` frontmatter field

## Schemas

- `schemas/skill.schema.json` and `.yaml` define the full, platform-agnostic, machine-readable skill contract.
- `schemas/skill-frontmatter.schema.json` and `.yaml` define the YAML frontmatter used by every `SKILL.md`.
- `examples/example-skill.json` and `.yaml` show a minimal valid machine-readable skill.

## Validation

`scripts/validate.ps1` performs a lightweight check on every `skills/<name>/SKILL.md`:

- Required and non-empty YAML frontmatter, sourced from `skill-frontmatter.schema.json`
- `name` matches the kebab-case pattern
- `version` is in `MAJOR.MINOR.PATCH` format
- `status` is a valid value from the frontmatter schema
- `tags` is a non-empty list
- All required Markdown sections are present
- Skill names are unique within the library

## Quality Gate

`scripts/quality-gate.ps1` runs the full quality gate:

- Calls `validate.ps1`
- Verifies every skill has `README.md`, `tests/`, and `examples/`
- Checks for at least two examples
- Rejects unresolved `TBD` or angle-bracket placeholders
- Verifies Change History is populated
- Checks every platform adapter has `ADAPTER.md` and a skill artifact

## Continuous Integration

A GitHub Actions workflow in `.github/workflows/quality-gate.yml` runs the quality gate on every push and pull request to `main`.

## Registry and Changelog

- `REGISTRY.md` is the human-readable skill catalog.
- `catalog.json` is the machine-readable skill catalog.
- `CHANGELOG.md` tracks library-level releases.
- Per-skill change history lives in each `skills/<name>/SKILL.md`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
