# csv-analysis

Loads a CSV dataset, profiles its structure, detects quality issues, calculates descriptive statistics, and produces a concise findings report.

## Quickstart

1. Provide a `dataset` and optional `delimiter`, `header`, `analysis-type`, `max-rows`, and `output-format`.
2. The skill returns a report with dataset overview, column profiles, quality issues, key findings, and recommendations.
3. Use `analysis-type` to focus on `profile`, `quality`, `correlation`, or `summary`.

## Example

```yaml
dataset: |
  name,age,score
  Alice,30,85
  Bob,25,92
  Carol,30,
analysis-type: profile
```

## Tests

See `tests/test-cases.md` for the current test plan.
