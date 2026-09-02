# Test Cases for requirements-analysis

## TC-01: Login page request

- Input: a clear request for a login page with `domain-context: consumer web application`.
- Expected: functional requirements, acceptance criteria, assumptions, and open questions about password recovery and password length.

## TC-02: Vague or over-scoped request

- Input: a request that is extremely broad, such as supporting every language and file format.
- Expected: the analysis flags the request as ambiguous, asks clarifying questions, and documents scope conflicts.

## TC-03: Missing request

- Input: an empty or missing `request` value.
- Expected: the skill asks the user for the request and does not proceed.

## TC-04: Conflicting requirements

- Input: a request that contains contradictory goals, such as "extremely fast" and "support every file format".
- Expected: the skill flags the conflict and asks the user to prioritize.
