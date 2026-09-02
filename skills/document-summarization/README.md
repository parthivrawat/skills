# document-summarization

Reads a document and produces a concise, accurate summary that preserves key facts, tone, and intent.

## Quickstart

1. Provide a `document` and optional `output-format`, `max-length`, `focus`, and `include-quotes`.
2. The skill returns a summary, key points, source metadata, confidence, and limitations.
3. Use `focus` to center the summary around a specific theme or question.

## Example

```yaml
document: |
  The company reported record revenue this quarter, driven primarily by
  strong growth in the cloud division. Operating costs remained flat,
  which led to a significant improvement in margins.
output-format: bullets
max-length: 3
```

## Tests

See `tests/test-cases.md` for the current test plan.
