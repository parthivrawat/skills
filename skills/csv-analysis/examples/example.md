# Example: csv-analysis

## Input

```yaml
dataset: |
  product,price,quantity
  Widget,$10,5
  Gadget,$20,abc
  Widget,$10,5
analysis-type: quality
```

## Expected Output

A Markdown report with dataset overview, column profiles, data-quality issues (non-numeric value, duplicate row, currency symbol), key findings, and recommendations.
