# Test Cases for security-audit

## TC-01: Hardcoded secret

- Input: a Python snippet with an API key assigned to a variable.
- Expected: one `critical` secret finding and a remediation step that does not print the key.

## TC-02: Known vulnerable dependency

- Input: a dependency manifest listing a package version with a known vulnerability.
- Expected: one `high` finding with an upgrade recommendation.

## TC-03: Excessive findings

- Input: a large target with more issues than `max-findings`.
- Expected: the most severe findings are reported, and the output notes that additional issues were omitted.

## TC-04: No target provided

- Input: an empty `target` value.
- Expected: the skill asks the user to provide the target and does not proceed.
