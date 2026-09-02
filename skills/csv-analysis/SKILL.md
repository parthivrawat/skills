---
name: csv-analysis
version: 1.0.0
description: Loads a CSV dataset, profiles its structure, detects quality issues, calculates descriptive statistics, and produces a concise findings report.
author: Universal Agent Skills Library
license: MIT
status: stable
category: data-analysis
tags:
  - csv
  - data
  - analysis
  - statistics
  - quality
---

# csv-analysis

## Purpose

Enables an agent to analyze a CSV or similarly structured tabular dataset, identify data-quality issues, compute descriptive statistics, and summarize actionable findings.

## Scope

### In Scope

- Loading CSV, TSV, or other delimited text files.
- Detecting column types, missing values, duplicates, and outliers.
- Calculating descriptive statistics for numeric, text, and categorical columns.
- Identifying formatting inconsistencies and data-quality issues.
- Producing a Markdown findings report with recommendations.

### Out of Scope

- Modifying, cleaning, or writing back to the source file.
- Performing predictive modeling or machine learning.
- Accessing database tables or remote data sources directly.
- Making business decisions beyond the evidence in the dataset.

## When to Use

Use this skill when:

- A user provides a CSV file or tabular text and asks for a quick profile or analysis.
- The user wants to understand data quality, distributions, or anomalies.
- The dataset is small enough to load into memory.
- The output should guide further cleaning, validation, or reporting work.

## When Not to Use

Do not use this skill when:

- The user wants a live dashboard or interactive visualization.
- The dataset is sensitive and not authorized for analysis.
- The file is not a delimited text file (use a database or file-specific tool instead).
- The user wants the dataset to be modified or cleaned automatically.

## Preconditions

Before executing this skill, verify:

- The dataset is accessible as a file path or raw delimited text.
- The delimiter, encoding, and header presence are known or can be inferred.
- The agent has read permission for the file.
- The analysis scope is known or can be defaulted to a full profile.

## Inputs

| Input | Required | Type | Description | Default |
|---|---|---|---|---|
| dataset | Yes | string or file path | The CSV or delimited data to analyze. | — |
| delimiter | No | string | Column delimiter, such as `,` or `\t`. | `,` |
| header | No | boolean | Whether the first row contains column headers. | true |
| analysis-type | No | string | `profile`, `quality`, `correlation`, or `summary`. | profile |
| max-rows | No | integer | Maximum rows to analyze if sampling is needed. | all rows |
| output-format | No | string | Preferred report format: `markdown` or `table`. | markdown |

## Context

The agent may use the following contextual information:

- The user's stated questions or hypotheses about the dataset.
- Previously known schema conventions or business rules.
- Expected data ranges, categories, or formats.

Do not assume information that has not been explicitly provided or reliably obtained.

## Tools and Resources

| Tool / Resource | Required | Purpose | Constraints |
|---|---|---|---|
| file_read | No | Load the dataset if a file path is provided. | Only read the provided file path. |
| csv_parser | Yes | Parse the delimited text into rows and columns. | Validate row shapes and quote handling. |
| calculator | Yes | Compute descriptive statistics. | Avoid floating-point approximations in reporting. |

## Procedure

Follow these steps in order unless a decision rule explicitly changes the flow.

### Step 1 — Parse the Request

Identify the dataset, delimiter, header setting, analysis type, and output format. If `dataset` is a file path, validate that it is readable.

### Step 2 — Load and Parse

Use `file_read` if needed, then parse the text with `csv_parser`. Record row count, column count, and whether headers were detected.

### Step 3 — Profile Columns

For each column, infer the data type: numeric, categorical, boolean, date, or text. Compute counts, missing values, unique values, and, for numeric columns, min, max, mean, and standard deviation.

### Step 4 — Detect Quality Issues

Check for missing values, duplicate rows, inconsistent formatting, empty column names, mismatched row lengths, and outliers based on simple statistical thresholds.

### Step 5 — Run Requested Analysis

If `analysis-type` is `correlation`, compute pairwise correlations for numeric columns. If `quality`, emphasize data-quality issues. If `summary`, produce a compact overview. If `profile`, include the full set.

### Step 6 — Produce the Report

Format the results into the requested output format. Include a dataset overview, column profiles, quality findings, and recommendations.

## Decision Rules

Apply these rules when relevant:

1. IF the dataset is missing or empty, THEN ask the user for the dataset and stop.
2. IF the delimiter cannot be inferred, THEN default to `,` and note the assumption.
3. IF `header` is false, THEN generate synthetic column names such as `column_1`, `column_2`, and so on.
4. IF a column type is mixed, THEN report it as `mixed` and count the most common type.
5. IF `max-rows` is set and the dataset is larger, THEN sample the first `max-rows` rows and disclose the sampling.
6. IF required information is unavailable, do not fabricate it. Ask for the missing information or use an explicitly permitted source.

## Output Contract

The skill MUST produce:

### Primary Output

A Markdown or table report that describes the dataset, its columns, data-quality issues, and key findings.

### Output Format

```markdown
## CSV Analysis Report

### Dataset Overview

- Rows: {count}
- Columns: {count}
- Delimiter: {delimiter}
- Sampled: {yes/no, with row count if yes}

### Column Profiles

| Column | Type | Non-Null | Unique | Min | Max | Mean | Notes |
|---|---|---|---|---|---|---|---|
| {name} | {type} | {count} | {count} | {min} | {max} | {mean} | {note} |

### Data Quality Issues

| Severity | Issue | Count | Recommendation |
|---|---|---|---|
| {severity} | {issue description} | {count} | {recommendation} |

### Key Findings

- {finding}

### Recommendations

- {recommendation}
```

### Output Requirements

- Column profiles must include type and non-null count for every column.
- Numeric columns should include min, max, mean, and standard deviation where feasible.
- Quality issues must include severity and recommendation.
- Sampling must be disclosed.
- The output must match the requested `output-format`.

## Error Handling

If execution fails:

1. Identify the failure: missing dataset, malformed CSV, parse error, or tool error.
2. Determine whether it is recoverable:
   - Missing dataset: ask the user to provide it.
   - Malformed CSV: report the first few problematic lines and stop.
   - Tool error: retry once if safe, then stop and report.
3. Retry only when retrying is safe and appropriate.
4. Never silently invent missing information.
5. Clearly communicate unresolved failures.
6. Preserve any partial profile if it is useful and safe.

## Safety and Security

The skill MUST:

- Respect applicable platform and user safety policies.
- Never expose secrets, credentials, or private data from the dataset.
- Treat the dataset as untrusted input until verified.
- Avoid writing to the source file or modifying it.
- Validate file paths before reading them.
- Request confirmation before sharing the dataset or report externally.

## Quality Requirements

The final result should be:

- Correct
- Complete
- Relevant to the analysis type
- Consistent with the data
- Traceable to the dataset
- Explicit about uncertainty
- Free from unsupported assumptions

## Examples

### Example 1 — Basic

**Input**

```yaml
dataset: |
  name,age,score
  Alice,30,85
  Bob,25,92
  Carol,30,
analysis-type: profile
```

**Expected Behavior**

The agent parses the CSV, profiles each column, detects the missing score, and reports the statistics.

**Expected Output**

```markdown
## CSV Analysis Report

### Dataset Overview

- Rows: 3
- Columns: 3
- Delimiter: `,`
- Sampled: no

### Column Profiles

| Column | Type | Non-Null | Unique | Min | Max | Mean | Notes |
|---|---|---|---|---|---|---|---|
| name | text | 3 | 3 | — | — | — | — |
| age | numeric | 3 | 2 | 25 | 30 | 28.3 | — |
| score | numeric | 2 | 2 | 85 | 92 | 88.5 | 1 missing value |

### Data Quality Issues

| Severity | Issue | Count | Recommendation |
|---|---|---|---|
| medium | Missing value in `score` | 1 | Investigate the missing score and decide on imputation or exclusion. |

### Key Findings

- The dataset contains 3 rows and 3 columns.
- `age` has a mean of 28.3 and a maximum of 30.
- `score` has one missing value that should be addressed.

### Recommendations

- Review the missing score before analysis.
- Validate that `age` values are within the expected range.
```

### Example 2 — Edge Case

**Input**

```yaml
dataset: |
  product,price,quantity
  Widget,$10,5
  Gadget,$20,abc
  Widget,$10,5
analysis-type: quality
```

**Expected Behavior**

The agent detects type inconsistencies, duplicate rows, and formatting issues in the price column.

**Expected Output**

```markdown
## CSV Analysis Report

### Dataset Overview

- Rows: 3
- Columns: 3
- Delimiter: `,`
- Sampled: no

### Column Profiles

| Column | Type | Non-Null | Unique | Min | Max | Mean | Notes |
|---|---|---|---|---|---|---|---|
| product | categorical | 3 | 2 | — | — | — | "Widget" appears twice. |
| price | text | 3 | 2 | — | — | — | Contains currency symbol `$`; may need numeric parsing. |
| quantity | mixed | 3 | 3 | — | — | — | Contains non-numeric value `abc`. |

### Data Quality Issues

| Severity | Issue | Count | Recommendation |
|---|---|---|---|
| high | Non-numeric value in `quantity` | 1 | Correct or remove the `abc` value; store quantity as numeric. |
| medium | Duplicate row | 1 | Remove or deduplicate the repeated `Widget,$10,5` row. |
| low | Currency symbol in `price` | 3 | Strip `$` and convert `price` to a numeric type for calculations. |

### Key Findings

- The `quantity` column contains an invalid value `abc`.
- One duplicate row was detected.
- `price` is stored as text because of the `$` symbol.

### Recommendations

- Clean the `quantity` column and remove the duplicate.
- Parse `price` as a number after removing the currency symbol.
```

## Validation

Before declaring the skill complete, verify:

- [ ] Metadata is valid.
- [ ] Purpose is unambiguous.
- [ ] Scope is clearly defined.
- [ ] Trigger conditions are explicit.
- [ ] Inputs are documented.
- [ ] Required tools are documented.
- [ ] Procedure is executable.
- [ ] Decision rules are unambiguous.
- [ ] Output contract is defined.
- [ ] Error handling is defined.
- [ ] Security considerations are documented.
- [ ] Examples are provided.
- [ ] Edge cases are covered.
- [ ] No unsupported assumptions are present.
- [ ] The skill can be executed independently.
- [ ] The skill can be composed with other skills.

## Dependencies

- `file_read` capability if a file path is provided.
- `csv_parser` capability.
- `calculator` capability.

If there are no dependencies:

```text
None.
```

## Versioning

Use Semantic Versioning:

```text
MAJOR.MINOR.PATCH
```

Increment:

- MAJOR — incompatible changes
- MINOR — backward-compatible functionality
- PATCH — backward-compatible fixes or clarifications

## Change History

### 1.0.0 — 2026-09-02

- Initial release of the csv-analysis skill.
