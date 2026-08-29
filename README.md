# Universal Agent Skills Library

A portable, versioned, and platform-agnostic library of reusable agent skills. Each skill is a well-specified capability that can be consumed by humans, AI agents, and agent platforms.

## Structure

```text
skills/
├── README.md
├── CONTRIBUTING.md
├── LICENSE
├── .gitignore
├── schemas/
│   ├── skill.schema.json
│   └── skill.schema.yaml
├── templates/
│   ├── SKILL.md
│   └── platform-adapter.md
├── skills/
│   └── .gitkeep
├── adapters/
│   └── .gitkeep
└── scripts/
    └── validate.ps1
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

## Validation

`scripts/validate.ps1` performs a lightweight check on every `skills/<name>/SKILL.md`:

- Required YAML frontmatter (`name`, `version`, `description`, `author`, `license`, `status`, `tags`)
- Required Markdown sections
- Unique skill names
- Basic naming convention

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).
