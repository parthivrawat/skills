# email-drafting

Drafts professional emails from a stated intent, recipient, and key points, producing a ready-to-review subject and body.

## Quickstart

1. Provide an `intent`, `recipient`, and optional `tone`, `key-points`, and `max-length`.
2. The skill returns a subject line and email body for review.
3. The draft is not sent; the user must review and send it manually.

## Example

```yaml
intent: Follow up after a project kickoff meeting
recipient: Sarah Chen
key-points:
  - Thank her for attending.
  - Share the link to the shared drive.
  - Ask her to review the timeline by Friday.
tone: professional
```

## Tests

See `tests/test-cases.md` for the current test plan.
