# Example: security-audit

## Input

```yaml
target: |
  api_key = "sk-1234567890abcdef"
  response = requests.get(url, headers={"Authorization": api_key})
scope: secrets
```

## Expected Output

```markdown
## Executive Summary

- Target: inline Python snippet
- Scope: secrets
- Findings: 1 (1 critical, 0 high, 0 medium, 0 low)
- Overall risk: critical

## Findings

### critical: Hardcoded API key

- File: inline snippet
- Evidence: A string matching an API key pattern is assigned directly to a variable.
- Remediation: Move the API key to a secrets manager or environment variable and rotate the exposed value.

## Remediation Plan

- Rotate the exposed API key.
- Store the replacement key in a secrets manager.

## Next Steps

- Verify no other hardcoded secrets exist and re-run the audit.
```
