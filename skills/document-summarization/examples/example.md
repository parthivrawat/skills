# Example: document-summarization

## Input

```yaml
document: |
  The company reported record revenue this quarter, driven primarily by
  strong growth in the cloud division. Operating costs remained flat,
  which led to a significant improvement in margins. The CEO also
  announced a new product line launching next year.
output-format: bullets
max-length: 3
```

## Expected Output

```markdown
## Summary

- Record revenue driven by cloud division growth.
- Operating costs stayed flat, improving margins.
- The CEO announced a new product line for next year.

## Key Points

- Cloud division growth is the main revenue driver.
- Margins improved because costs remained flat.
- A new product line is planned for next year.

## Source

- Source: inline text
- Length: 3 sentences

## Confidence

high

## Limitations

None identified.
```
