# Example: code-review

## Input

```yaml
diff: |
  def divide(a, b):
      return a / b
language: python
focus-areas: correctness
```

## Expected Output

```markdown
## Review Summary

- Files reviewed: 1
- Focus areas: correctness
- Verdict: needs changes

## Findings

### high: Missing zero-division guard

- File: module.py
- Location: line 2
- Description: `divide` does not handle `b` equal to zero.
- Recommendation: Add a guard clause or raise a `ValueError` for `b == 0`.

## Positive Observations

- The function signature is clear.

## Next Steps

- Add input validation and re-request a review.
```
