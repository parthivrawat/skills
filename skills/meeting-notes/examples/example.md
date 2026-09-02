# Example: meeting-notes

## Input

```yaml
transcript: |
  Alice: Let's start with the rollout plan. Bob, can you own the deployment?
  Bob: Yes, I'll deploy to staging by Friday.
  Alice: Great. Carol, please write the release notes by Thursday.
  Carol: Will do.
  Alice: We also need to decide on the rollback strategy. Let's defer that to next week.
attendees: Alice, Bob, Carol
output-format: minutes
```

## Expected Output

A Markdown meeting minutes document with topic, attendees, summary, decisions, action items with owners and due dates, and open questions.
