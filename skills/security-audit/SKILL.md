---
name: security-audit
version: 1.1.0
description: Reviews a codebase or artifact for security weaknesses, exposed secrets, and known vulnerabilities, then produces a prioritized audit report.
author: Parthiv Rawat (parthiv05022000@gmail.com)
license: MIT
status: stable
category: security
tags:
  - security
  - audit
  - vulnerabilities
  - secrets
  - static-analysis
related:
  - code-review
---

# security-audit

Inherits the shared baseline in [../_shared/CORE.md](../_shared/CORE.md)
(context integrity, baseline decision rule, error handling, safety, quality,
validation, and versioning). Only skill-specific rules appear below.

## Purpose

Inspect a codebase, configuration, or artifact for security issues and produce a
prioritized report of findings, including exposed secrets, injection risks, weak
controls, and known vulnerable dependencies.

## Scope

### In Scope

- Scan files, diffs, or package manifests for security issues.
- Identify exposed secrets, credentials, tokens, or private keys.
- Detect common injection and validation flaws.
- Check known vulnerable dependencies when a dependency list is provided.
- Report findings with severity, evidence, and remediation.

### Out of Scope

- Modifying or patching the code under audit.
- Running live penetration tests or attacks.
- Accessing external systems, networks, or cloud accounts.
- Providing legal or compliance certification.

## When to Use

- A user asks for a security review of a repository, file, or diff.
- A new dependency or configuration change needs a security check.
- There is a suspicion of leaked secrets or weak controls.
- The user wants a prioritized list of security findings.

## When Not to Use

- The user wants a full implementation of security controls.
- No source, diff, or manifest is available.
- The target is an external system without explicit authorization.
- The user explicitly asks for a different specialized skill.

## Preconditions

- The audit target is accessible as files, a diff, or a manifest.
- The agent has permission to read the target.
- The scope of the audit is clear or can be defaulted.
- A safe, read-only environment is used for the review.

## Inputs

| Input | Required | Type | Description | Default |
|---|---|---|---|---|
| target | Yes | string | The path, diff, or manifest to audit. | — |
| scope | No | string | Comma-separated focus areas. | secrets, injection, dependencies, configuration |
| compliance-framework | No | string | Optional framework to map findings against. | none |
| max-findings | No | integer | Maximum findings to report. | 15 |

## Context

- Known trusted and untrusted patterns in the project.
- Previously discovered security issues or hotspots.
- Dependency versions and package manager conventions.
- Organizational security policies if explicitly provided.

## Tools and Resources

| Tool / Resource | Required | Purpose | Constraints |
|---|---|---|---|
| file_read | Yes | Read the target files or manifest. | Only read files in the provided target scope. |
| code_search | Yes | Search the target for patterns and known weaknesses. | Do not search outside the target. |
| secret_scanner | No | Detect exposed secrets and credentials. | Treat findings as sensitive; do not echo raw secret values. |
| vulnerability_database | No | Look up known vulnerabilities for dependencies. | Use only authoritative, up-to-date sources. |

## Procedure

1. **Parse the target** — identify what is being audited (file, directory, diff,
   or manifest); validate it is not empty; infer `scope` and `max-findings` if
   not provided.
2. **Read the target** — load contents with `file_read`; record all file names
   and paths.
3. **Search for issues** — for each scope area, use the appropriate tool:
   - **Secrets** — search for API keys, tokens, passwords, and private keys.
   - **Injection** — search for SQL, command, XML, or LDAP injection patterns
     and missing validation.
   - **Dependencies** — use `vulnerability_database` to check listed packages
     and versions.
   - **Configuration** — search for unsafe defaults, disabled security features,
     or verbose error exposure.
4. **Classify findings** — assign `critical`, `high`, `medium`, or `low`; map to
   `compliance-framework` if provided; stop at `max-findings` with the most
   severe first.
5. **Formulate remediation** — for each finding, provide evidence, the affected
   file or package, and a concrete remediation step without echoing full secret
   values.
6. **Produce the report** — combine findings, risk summary, and remediation
   guidance; include an executive summary and next steps.

## Decision Rules

1. IF the target is missing or empty, THEN ask the user for the target before auditing.
2. IF an exposed secret is found, THEN mark the finding as `critical` and warn the user immediately.
3. IF a dependency has a known critical vulnerability, THEN report it before lower-severity code findings.
4. IF the number of findings exceeds `max-findings`, THEN keep the most severe and note that additional issues were omitted.
5. IF `compliance-framework` is specified, THEN map each finding to the relevant control or category.

## Output Contract

### Primary Output

A Markdown security audit report with an executive summary, findings, and
remediation guidance.

### Output Format

```markdown
## Executive Summary

- Target: {description}
- Scope: {areas}
- Findings: {count} ({critical}, {high}, {medium}, {low})
- Overall risk: {critical | high | medium | low}

## Findings

### {severity}: {title}

- File: {file}
- Evidence: {short, safe description}
- Remediation: {concrete step}

## Remediation Plan

- {action}

## Next Steps

- {action}
```

### Output Requirements

- Every finding must be traceable to a specific file, package, or configuration.
- Severity must be one of `critical`, `high`, `medium`, or `low`.
- Never print raw secret values or credentials in the report.
- Remediation steps must be concrete and actionable.
- The overall risk must reflect the highest severity finding.

## Error Handling

Follow CORE.md § Error Handling Protocol. Skill-specific failures:

- Missing target: ask the user to provide it.
- Unreadable file: report the path and stop.
- Tool error: retry once if safe, then stop and report.

## Safety and Security

Apply CORE.md § Safety and Security Baseline. Additionally:

- Never execute or compile the target code unless explicitly authorized.
- Do not write to or modify the target; validate paths before reading.
- Request confirmation before sharing findings externally.

## Quality Requirements

CORE.md baseline, plus: findings must be traceable to the target and
prioritized by risk.

## Examples

### Example 1 — Basic

**Input**

```yaml
target: |
  api_key = "sk-1234567890abcdef"
  response = requests.get(url, headers={"Authorization": api_key})
scope: secrets
```

**Expected Behavior**

The agent identifies the hardcoded API key, marks it as `critical`, and provides
remediation without printing the key.

**Expected Output**

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

### Example 2 — Edge Case

**Input**

```yaml
target: |
  name: my-app
  dependencies:
    vulnerable-lib: 1.2.3
scope: dependencies
compliance-framework: OWASP Top 10
```

**Expected Behavior**

The agent checks the dependency against a vulnerability database, reports the
known issue, and maps it to the relevant OWASP control.

**Expected Output**

```markdown
## Executive Summary

- Target: dependency manifest
- Scope: dependencies
- Findings: 1 (1 high, 0 critical, 0 medium, 0 low)
- Overall risk: high

## Findings

### high: Known vulnerable dependency

- File: dependency manifest
- Evidence: `vulnerable-lib` version `1.2.3` has a known security issue.
- Remediation: Upgrade to a patched version and run regression tests.

## Remediation Plan

- Upgrade `vulnerable-lib` to the latest patched version.
- Run the test suite to verify compatibility.

## Next Steps

- Monitor the dependency for future advisories.
```

## Related Skills

- [code-review](../code-review/SKILL.md) — fold audit findings into a review report.

## Validation

Run the CORE.md § Validation Checklist.

## Dependencies

- `file_read` capability.
- `code_search` capability.
- Optional: `secret_scanner` and `vulnerability_database` capabilities.

## Versioning

SemVer per CORE.md § Versioning.

## Change History

### 1.1.0 — 2026-09-05

- Restructured to inherit the shared core contract; added `related` links.

### 1.0.0 — 2026-08-30

- Initial release of the security-audit skill.
