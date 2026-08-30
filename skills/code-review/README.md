# code-review

Reviews a code change for correctness, style, security, and maintainability, producing a structured Markdown report.

## Quickstart

1. Provide a `diff` and optional `language` and `focus-areas`.
2. The skill returns a review report with findings, positive observations, and a verdict.
3. Use `max-findings` to limit the number of reported issues.

## Example

```yaml
diff: |
  def divide(a, b):
      return a / b
language: python
focus-areas: correctness
```

## Tests

See `tests/test-cases.md` for the current test plan.
