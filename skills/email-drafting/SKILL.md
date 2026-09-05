---
name: email-drafting
version: 1.1.0
description: Drafts professional emails from a stated intent, recipient, and key points, producing a ready-to-review subject and body.
author: Universal Agent Skills Library
license: MIT
status: stable
category: communication
tags:
  - email
  - writing
  - communication
  - drafting
  - productivity
related:
  - meeting-notes
  - document-summarization
---

# email-drafting

Inherits the shared baseline in [../_shared/CORE.md](../_shared/CORE.md)
(context integrity, baseline decision rule, error handling, safety, quality,
validation, and versioning). Only skill-specific rules appear below.

## Purpose

Compose clear, professional emails from the user's intent, recipient, and key points, producing a subject and body for review before sending.

## Scope

### In Scope

- Drafting professional and neutral emails.
- Adapting tone to the requested style and relationship with the recipient.
- Structuring the body with a greeting, purpose, key points, and a closing.
- Producing a subject line and optional call to action.
- Summarizing context from provided documents or prior messages.

### Out of Scope

- Sending the email on behalf of the user.
- Accessing an email client, mailbox, or contact list.
- Generating marketing or mass-email campaigns.
- Drafting legally binding, confidential, or highly sensitive communications without user review.

## When to Use

- A user needs a draft email for a specific purpose.
- The recipient and key points are known.
- The user wants a different tone or phrasing for an existing message.
- The output is intended for review, not immediate sending.

## When Not to Use

- The user wants the email sent immediately (use an actual email sending capability).
- The request contains threats, harassment, or other harmful content.
- The user asks to impersonate someone else.
- The content includes sensitive personal information about third parties without consent.

## Preconditions

- The intent or purpose of the email is clear.
- The recipient is identified.
- The tone and key points are known or can be defaulted.
- The user is available to review the draft before it is sent.

## Inputs

| Input | Required | Type | Description | Default |
|---|---|---|---|---|
| intent | Yes | string | The purpose of the email. | — |
| recipient | Yes | string | Who the email is addressed to. | — |
| tone | No | string | Desired tone: `formal`, `professional`, `friendly`, `urgent`, or `apologetic`. | professional |
| key-points | No | list of strings | Specific points or questions to include. | none |
| max-length | No | integer | Approximate maximum length in sentences. | 8 |

## Context

- Previous emails or messages in the same thread.
- The user's role and relationship with the recipient.
- Relevant documents or meeting notes referenced by the user.

## Tools and Resources

| Tool / Resource | Required | Purpose | Constraints |
|---|---|---|---|
| text_input | Yes | Accept the intent, recipient, and key points. | Do not send or transmit the email. |
| document_summarizer | No | Summarize referenced documents or prior messages. | Treat summarized content as the user's context, not authoritative fact. |

## Procedure

1. **Capture inputs** — record intent, recipient, tone, key points, and length. Default tone to `professional` and length to `8` if not provided.
2. **Determine the relationship** — choose an appropriate salutation and formality from the recipient and context. Err on the side of professionalism.
3. **Structure the message** — draft a greeting, opening purpose, body covering the key points, closing with a call to action, and a sign-off.
4. **Apply tone and length** — adjust wording to `tone`. Keep the body within `max-length` unless the user explicitly requested a longer message.
5. **Produce the draft** — return the subject and body as separate fields. Include a note that the draft is for review and has not been sent.

## Decision Rules

1. IF `intent` or `recipient` is missing, THEN ask the user for the missing information before drafting.
2. IF `tone` is not in the supported list, THEN default to `professional` and note the change.
3. IF the email requests a decision, THEN include a clear call to action and a deadline if appropriate.
4. IF the request includes harmful, harassing, or deceptive content, THEN refuse and explain why.
5. IF `key-points` is empty, THEN infer the main point from `intent` and keep the email concise.

## Output Contract

### Primary Output

A subject line and an email body ready for user review.

### Output Format

```markdown
## Email Draft

**To:** {recipient}
**Subject:** {subject}

{greeting},

{body paragraphs}

{closing},
{signature}

---

*This is a draft for review. It has not been sent.*
```

### Output Requirements

- The subject must be concise and descriptive.
- The greeting and sign-off must match the tone and relationship.
- The body must cover the provided key points in order.
- The draft must not exceed `max-length` unless the user explicitly requested a longer message.
- The output must clearly state that it is a draft and has not been sent.

## Error Handling

Follow CORE.md § Error Handling Protocol. Skill-specific failures:

- Missing required input: ask the user to provide it.
- Unsupported tone: default to `professional` and continue.
- Harmful content: refuse and explain the policy.
- Tool error: retry once if safe, then stop and report.

## Safety and Security

Apply CORE.md § Safety and Security Baseline. Additionally:

- Never expose secrets, credentials, or private information in the draft.
- Avoid drafting harmful, deceptive, or unauthorized content.
- Never send the email or access external mail systems.
- Request confirmation before including sensitive personal or business information.

## Quality Requirements

CORE.md baseline, plus: clear, concise, consistent in tone, polite and professional, and explicitly marked as a draft.

## Examples

### Example 1 — Basic

**Input**

```yaml
intent: Follow up after a project kickoff meeting
recipient: Sarah Chen
key-points:
  - Thank her for attending.
  - Share the link to the shared drive.
  - Ask her to review the timeline by Friday.
tone: professional
```

**Expected Output** (condensed)

```markdown
## Email Draft

**To:** Sarah Chen
**Subject:** Follow-up from project kickoff

Hi Sarah,

Thank you for attending the project kickoff meeting. I have added the project materials to the shared drive for your review.

Could you please review the proposed timeline and share your feedback by Friday? Let me know if you have any questions.

Best regards,
{signature}

---

*This is a draft for review. It has not been sent.*
```

### Example 2 — Edge Case

**Input**

```yaml
intent: Escalate a missed deadline
recipient: Engineering Manager
tone: urgent
key-points:
  - The API integration deadline was missed.
  - We need a revised delivery estimate.
  - Request a call today if possible.
max-length: 6
```

**Expected Output** (condensed)

```markdown
## Email Draft

**To:** Engineering Manager
**Subject:** Urgent: revised estimate needed for API integration

Hi Engineering Manager,

The API integration deadline has been missed. To keep the project on track, I need a revised delivery estimate as soon as possible.

Could we schedule a call today to align on the next steps?

Thanks,
{signature}

---

*This is a draft for review. It has not been sent.*
```

## Related Skills

- [meeting-notes](../meeting-notes/SKILL.md) — draft follow-ups from action items.
- [document-summarization](../document-summarization/SKILL.md) — summarize prior threads or referenced documents before drafting.

## Validation

Run the CORE.md § Validation Checklist.

## Dependencies

- `text_input` capability.
- Optional: `document_summarizer` capability for referenced context.

## Versioning

SemVer per CORE.md § Versioning.

## Change History

### 1.1.0 — 2026-09-05

- Restructured to inherit the shared core contract; added `related` links.

### 1.0.0 — 2026-09-02

- Initial release of the email-drafting skill.
