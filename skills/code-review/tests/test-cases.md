# Test Cases for code-review

## TC-01: Missing null or zero guard

- Input: a single function that divides two numbers without validation.
- Expected: at least one `high` finding with a concrete recommendation.

## TC-02: SQL injection via string interpolation

- Input: a JavaScript snippet that interpolates user input into a SQL query.
- Expected: one `critical` security finding.

## TC-03: Excessive findings

- Input: a large diff with more issues than `max-findings`.
- Expected: the most severe findings are reported, and the output notes that additional minor issues were omitted.

## TC-04: No diff provided

- Input: an empty `diff` value.
- Expected: the skill asks the user to provide the diff and does not proceed.
