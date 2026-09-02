# Test Cases for csv-analysis

## TC-01: Basic profile

- Input: a clean three-row CSV with numeric and text columns.
- Expected: column profiles, statistics, and a note about the missing value.

## TC-02: Quality issues

- Input: a CSV with a non-numeric value, duplicate row, and currency symbols.
- Expected: data-quality findings with severity levels and concrete recommendations.

## TC-03: Missing dataset

- Input: an empty or missing `dataset` value.
- Expected: the skill asks the user for the dataset and does not proceed.

## TC-04: Large file sampling

- Input: a CSV with more rows than `max-rows`.
- Expected: the skill analyzes the first `max-rows` rows and discloses the sampling in the report.
