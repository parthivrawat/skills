# meeting-notes

Converts a meeting transcript or raw notes into a structured summary with decisions, action items, and open questions.

## Quickstart

1. Provide a `transcript` and optional `attendees` and `output-format`.
2. The skill returns meeting minutes with metadata, topics, decisions, action items, and open questions.
3. Use `output-format` to choose `minutes`, `summary`, or `action-list`.

## Example

```yaml
transcript: |
  Alice: Let's start with the rollout plan. Bob, can you own the deployment?
  Bob: Yes, I'll deploy to staging by Friday.
  Alice: Great. Carol, please write the release notes by Thursday.
attendees: Alice, Bob, Carol
output-format: minutes
```

## Tests

See `tests/test-cases.md` for the current test plan.
