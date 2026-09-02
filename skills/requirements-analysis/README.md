# requirements-analysis

Transforms informal requests into clear, structured requirements with acceptance criteria, assumptions, and open questions.

## Quickstart

1. Provide a `request` and optional `domain-context`, `detail-level`, and `output-format`.
2. The skill returns goals, requirements, acceptance criteria, assumptions, open questions, and conflicts.
3. Use `detail-level` to control the depth of the analysis.

## Example

```yaml
request: |
  I need a login page where users can sign in with their email and
  password. It should also show an error if the credentials are wrong.
domain-context: consumer web application
detail-level: standard
```

## Tests

See `tests/test-cases.md` for the current test plan.
