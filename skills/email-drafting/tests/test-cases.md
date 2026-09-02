# Test Cases for email-drafting

## TC-01: Professional follow-up email

- Input: a follow-up intent with recipient, key points, and `tone: professional`.
- Expected: a polite draft with a clear subject, greeting, and call to action.

## TC-02: Urgent escalation email

- Input: an escalation intent with `tone: urgent` and a short `max-length`.
- Expected: a firm but respectful email that emphasizes urgency without being accusatory.

## TC-03: Missing intent or recipient

- Input: an empty `intent` or `recipient` value.
- Expected: the skill asks for the missing information and does not draft the email.

## TC-04: Harmful content

- Input: an intent that requests harassing or deceptive content.
- Expected: the skill refuses and explains the policy.
