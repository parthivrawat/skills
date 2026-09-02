# Test Cases for meeting-notes

## TC-01: Standard meeting with action items

- Input: a transcript with clear speakers, decisions, and assigned tasks.
- Expected: a structured minutes document with attendees, decisions, and an action-item table.

## TC-02: Meeting with no decisions or action items

- Input: a short status update with no explicit decisions or tasks.
- Expected: the skill still produces a summary and explicitly states that no decisions or action items were identified.

## TC-03: Missing transcript

- Input: an empty or missing `transcript` value.
- Expected: the skill asks the user for the transcript and does not proceed.

## TC-04: Unassigned action item

- Input: a transcript where a task is mentioned but no owner is stated.
- Expected: the action item is marked as `unassigned` and the user is prompted to assign an owner.
