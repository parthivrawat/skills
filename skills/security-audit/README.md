# security-audit

Reviews a codebase or artifact for security weaknesses, exposed secrets, and known vulnerabilities, producing a prioritized Markdown report.

## Quickstart

1. Provide a `target` and optional `scope` and `compliance-framework`.
2. The skill returns an executive summary, findings, and a remediation plan.
3. Use `max-findings` to limit the number of reported issues.

## Example

```yaml
target: |
  api_key = "sk-1234567890abcdef"
  response = requests.get(url, headers={"Authorization": api_key})
scope: secrets
```

## Tests

See `tests/test-cases.md` for the current test plan.
