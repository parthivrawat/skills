---
platform: <platform-name>
skill: <source-skill-name>
version: <version>
---

# Platform Adapter: <platform-name> — <Skill Name>

## Mapping Summary

| Universal Concept | Platform Equivalent |
|---|---|
| Skill invocation | `<how the platform calls it>` |
| Input `<input-name>` | `<platform input name>` |
| Tool `<generic-tool>` | `<platform tool name>` |

## Installation

<platform-specific install steps>

## Runtime Configuration

<authentication, environment variables, runtime settings>

## Security and Confirmation Notes

Do not remove any safety requirement from the source skill. Map confirmation prompts to the platform's confirmation mechanism. Preserve behavior, not just names.
