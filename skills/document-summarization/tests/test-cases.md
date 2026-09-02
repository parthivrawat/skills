# Test Cases for document-summarization

## TC-01: Basic article summary

- Input: a three-sentence business article with `output-format: bullets`.
- Expected: a bulleted summary of the main points, with high confidence and no limitations.

## TC-02: Conflicting or uncertain source

- Input: a short text with two opposing views and no clear resolution.
- Expected: the summary states the disagreement and assigns low confidence.

## TC-03: Missing document

- Input: an empty or missing `document` value.
- Expected: the skill asks the user to provide the document and does not proceed.

## TC-04: Unsupported output format

- Input: a valid document with `output-format: diagram`.
- Expected: the skill defaults to `paragraph` and notes the unsupported format.
