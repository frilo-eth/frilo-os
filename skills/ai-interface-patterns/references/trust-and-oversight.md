# Trust and oversight

## The HAX lifecycle

Microsoft's Guidelines for Human-AI Interaction (Amershi et al., CHI 2019, 18
guidelines) are organized around four moments in the relationship. Use them as
a review structure. Paraphrased below as design directives; the canonical
wording and examples live in the HAX Design Library.

### Initially

- Make clear what the system can do.
- Make clear how well it does it, including where it is unreliable.

Expectation setting happens once, at the start, and users rarely revise it
afterward. Overclaiming at first contact produces distrust that no amount of
later accuracy repairs. Underclaiming is cheap by comparison.

### During interaction

- Time services based on context. Interrupt at a pause, not mid-thought.
- Show contextually relevant information.
- Match relevant social norms, and mitigate social biases in output.
- Support efficient invocation, efficient dismissal, and efficient correction.
- Scope services when the system is uncertain, or degrade gracefully.

The three efficiencies are the ones teams skip. Invocation usually gets built,
dismissal gets a small x, and correction gets nothing at all, which forces the
user to start over.

### When wrong

- Support efficient correction.
- Make clear why the system did what it did.
- Scope down rather than guessing confidently.

Design the wrong state as carefully as the right one. Users judge an AI feature
on how it behaves when it fails, because it will fail in front of them and they
will remember that instance more than the ten successes.

### Over time

- Remember recent interactions.
- Learn from user behavior.
- Update and adapt cautiously; disruptive changes erode learned models.
- Encourage granular feedback.
- Convey the consequences of user actions.
- Provide global controls.
- Notify users about changes.

Global controls and change notifications are what separate a product from a
demo. A model swap that silently changes behavior is a broken promise even when
the new model is better.

## Communicating confidence

Never fabricate precision. A number implies a measurement.

| Situation | Do |
| --- | --- |
| The system has a real calibrated score | Show it, and explain what it means |
| The system has a rough sense | Use language: likely, uncertain, could not verify |
| The system has no idea | Say so and offer a next step |
| The result is partial | Show what is covered and what is not |

Uncertainty in language is more honest and more actionable than a percentage
nobody can interpret. "I found this in two of your three connected sources"
tells the user what to do next. "84% confident" does not.

Degradation beats guessing. When confidence is low, narrow the claim, ask a
question, or return fewer results with higher precision.

## Citations and provenance

- Citations resolve to the specific claim, not to a document that mentions the
  topic somewhere.
- Inline placement beats a footnote block. Users check while reading, not after.
- Show what was searched and what was not. Absence of a source is information.
- For internal or connected data, show which system the answer came from.
- Where nothing can be cited, say the answer is generated rather than retrieved.

An uncheckable citation is worse than no citation, because it manufactures
confidence the system did not earn.

## Permissions and data

- Scope permissions to the task, and show the scope in the language of the
  user's world ("read your calendar for the next 7 days"), not in API terms.
- Permissions are inspectable and revocable after granting, in a place the user
  can find without support.
- Memory is visible, editable and clearable. Show what was remembered and when.
- Offer an off switch: incognito, or a session that does not persist.
- Consent covers third parties. If a user uploads a thread, the other people in
  it did not agree to anything, and design should acknowledge that.

## Error recovery

Every AI error state needs three things: what happened in plain language, why
if it is knowable, and what the user can do next.

| Failure | Recovery |
| --- | --- |
| Model unavailable or overloaded | Retry with backoff, show the wait, keep the input |
| Timeout | Offer partial results if any exist, then retry or narrow |
| Refusal or policy block | Explain the category, not the internals. Offer a reformulation where legitimate |
| Wrong output | Correct in place, regenerate, or branch. Never force a restart |
| Partial completion (agents) | Report what completed, what did not, and what state things are in |
| Hallucination detected by the user | One-click report plus an easy correction path |

The input is never lost. Losing a user's prompt to an error is the fastest way
to lose the user.

## Feedback

- Granular beats binary. Thumbs down tells you nothing; thumbs down plus a
  reason tells you something.
- Feedback should be visibly consequential, or it will be given once and never
  again.
- Implicit signals (edits, regenerations, abandonment) are richer than explicit
  ratings and cost the user nothing. Instrument them.

## Evaluating an AI interface

Beyond usability testing, three things worth measuring:

- **Correction rate.** How often users edit the output. High rates mean the
  tuners are missing, not that the model is bad.
- **Abandonment point.** Where in the flow people stop. Usually the blank input.
- **Trust calibration.** Do users accept wrong answers, or reject right ones?
  Both are failures, and both are interface problems, not model problems.
