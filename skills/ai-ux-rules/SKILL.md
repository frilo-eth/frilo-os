---
name: ai-ux-rules
description: 72 numbered, checkable rules for AI interface craft, each with a threshold or a concrete behavior attached. Covers forming intent, showing the work, judging output, and correcting it: blank inputs, suggestions, streaming, latency, step display, skeleton and empty-state timing, provenance, confidence, interruption, editing, branching, permission gradients, error and refusal copy. Use as a build spec before writing any AI feature or the frontend code for one, and as a review protocol when auditing an existing one. Also use when an AI feature feels untrustworthy, sluggish, gimmicky or unfinished and the reason is not obvious. Trigger on casual phrasing ("the assistant feels off", "make the agent less annoying", "review our chat UI").
version: 1.0.0
source: frilo. Distilled from the ai-interface-patterns and micro-interactions skills, which draw on The Shape of AI (Emily Campbell, CC-BY-NC-SA), Google PAIR, the Microsoft HAX Toolkit, and the interior.dev design language (MIT).
---

# AI UX rules

72 rules. Each one is applicable in under a minute and checkable by looking.
Where a rule has a number attached, the number is the rule.

Conventional UI is judged on what it looks like. An AI interface is judged on
what happens over the next four seconds, which is why most of these are about
time. The four questions underneath every rule:

**Can the user form intent? Can they see the work? Can they judge the output?
Can they correct it?**

Two modes:

- **Build**: read the section matching what you are making, apply every rule in
  it, then run the checklist at the end.
- **Review**: walk all 72 and report violations as `rule number, observed,
  expected, fix`. Never report vague impressions.

A rule can be broken deliberately. The reason has to fit in one sentence.

---

## I. Forming intent

**01 · Never ship a bare input.** A blank prompt field with no suggestions,
templates or examples transfers the entire design problem to the user.

**02 · Suggestions are contextual or they are noise.** "Summarize the 12
comments on this PR" teaches scope and phrasing at once. "Write a blog post"
teaches nothing.

**03 · Show the prompt next to the result.** An example gallery with visible
prompts is the fastest prompt tutorial available, and almost nobody builds one.

**04 · Under five known variables, use fields, not a prompt.** A form beats a
conversation for any task with a knowable shape.

**05 · If the object is on screen, go inline.** Inline AI needs no description
of the target, bounds the scope automatically, and is discovered for free.

**06 · Repeated tasks get named actions.** Nobody wants to retype an
instruction they issue daily.

**07 · Ask one clarifying question, never two.** A clarifying interrogation is
worse than a mediocre first draft the user can correct.

**08 · State capability before first use.** Users calibrate once, at the start,
and rarely revise. A tooltip discovered afterward is too late.

**09 · Ship caveats, not disclaimers.** "Trained on data through March, will not
know recent filings" is a caveat. "AI can make mistakes" is legal cover that
goes invisible within a week.

**10 · Attached context is visible and removable before sending.** Files,
memory, tools and connected sources, all inspectable at the moment of the ask.

**11 · Anything users fix by rerolling needs a tuner.** Repeated regeneration is
the symptom; a missing constraint is the disease.

**12 · Anything tuned twice is savable.** Saved styles, presets and reusable
prompts are where a professional user's investment accumulates.

**13 · Never require a prompt for a consequential action.** Prompting is for
open intent. Spending, sending and deleting want an explicit control.

**14 · The AI marker means actual model involvement.** Applying it to a database
query teaches users to ignore it everywhere.

---

## II. Seeing the work

**15 · Stream. Never withhold a complete response.** Waiting with no signal is
the worst latency experience available; streaming converts wait into progress.

**16 · Fill latency with the step, in the user's vocabulary.** "Reading 14
invoices" not "Thinking". The duration is not the problem, the unaccounted
duration is.

**17 · Completed steps stay on screen.** A returning user reconstructs state by
looking, not by re-reading.

**18 · Show elapsed time per step.** It converts a wait into a measurement, and
it exposes the slow step to whoever can fix it.

**19 · Past ten seconds, scope the run.** A step count, an estimate, or a
bounded list. Open-ended waiting is where abandonment happens.

**20 · No rotating quips.** Charming filler is a decision to say nothing.

**21 · Spinner for unknown duration, progress for known.** A bar filling against
a guessed duration claims progress it cannot know.

**22 · Skeleton: 120 ms grace, 380 ms minimum.** A fast response then never
shows one, a slow response never flashes one.

**23 · Empty states get a 220 ms grace.** A list one frame from arriving should
not flash "nothing here".

**24 · Reserve the response box before the first token.** Streaming output must
not move the controls beneath it. Pin actions to a reserved row.

**25 · A streaming dot, not a blinking caret.** A caret blinks because the blink
says "your turn". A streaming mark rides the output and never pulses, because
the arriving token is already the signal.

**26 · Follow the stream only if the user is at the bottom.** Yanking a scrolled
reader back down is worse than letting output run off screen.

**27 · Structure arrives with the output.** Headings, code blocks, collapsible
sections, as it streams. A wall of prose is an interface failure, not a model
failure.

**28 · Summarize reasoning for humans; raw traces on expand only.** Stream of
thought is a design surface, not a debug view.

**29 · Tool calls appear as named actions.** "Searching your calendar", not a
function signature.

**30 · A run the user left is reconstructable on return.** They were not
watching. Assume it.

**31 · Per-item progress for batches, never one global bar.** Each row owns its
own state and its own abort.

**32 · Show cost before an expensive run.** Users tolerate cost. They do not
tolerate surprise.

---

## III. Judging the output

**33 · No bare assertion.** Every factual claim carries provenance or an
explicit uncertainty marker.

**34 · A citation resolves to the claim, not the document.** An uncheckable
citation is worse than none, because it manufactures confidence.

**35 · Citations inline, not in a footnote block.** People check while reading.

**36 · Say what was searched and what was not.** The absence of a source is
information.

**37 · Distinguish retrieved from generated.** These are different epistemic
claims and users cannot tell them apart by looking.

**38 · Confidence in language, never a fabricated percentage.** A number implies
a measurement. "Found in two of your three sources" is actionable; "84%
confident" is theater.

**39 · Degrade the claim rather than guessing.** Narrow the scope, return fewer
results, or ask. Confident wrongness is the most expensive failure mode.

**40 · Mark AI content at the point of consumption.** Not only in settings, not
buried in a tooltip.

**41 · Distinguish generated from assisted.** Fully synthetic output is a
different claim from an edited draft.

**42 · Media carries machine-readable provenance.** Visible mark plus content
credentials.

**43 · Output is editable in place.** Forcing a re-prompt to fix one word is the
most common reason users abandon a good feature.

**44 · Long output is navigable.** If the user has to scroll to find the answer,
the answer was not delivered.

**45 · Numbers carry their source and their as-of date.** A figure with neither
is a guess wearing a suit.

**46 · Do not collapse several answers into one.** If the system found three
candidates, showing one is a decision the user should have made.

**47 · A regeneration shows what changed.** Silent wholesale replacement
destroys the user's ability to evaluate the change.

**48 · Never claim certainty the system lacks.** Banned in output and in UI
copy: magic, thinking, understands you, perfect, flawless, "just".

**49 · Sycophancy is a defect.** Reflexive agreement optimizes session length at
the user's expense, and it is a safety issue in consumer contexts.

---

## IV. Correcting it

**50 · Stop lands on the next frame.** A stop that takes a second is not a stop
button, it is a request.

**51 · A stop keeps what was already generated.** Discarding partial output
punishes the user for exercising control.

**52 · After a stop, offer keep, discard and continue.** Three outcomes, because
the user stopped for one of three reasons.

**53 · The prompt survives every error.** Losing a user's input to a failure is
the fastest way to lose the user.

**54 · Edit and re-run beats appending a correction.** Appending pollutes
context and compounds the original mistake.

**55 · Editing an earlier turn branches, never destroys.** Exploration should
not be punished with loss.

**56 · Regenerate is always available.** A one-shot irreversible generation is a
trap.

**57 · Variations where iteration is expected.** One result forces sequential
rerolling to do a job parallel display does better.

**58 · Every generation is reversible, or flagged as not.** There is no third
option.

**59 · Consequential confirmations name the action and the scope.** "Send 47
replies", never "Continue".

**60 · Never "Are you sure?" with Yes and No.** Label the buttons with the
actions themselves, or a cancel dialog becomes a double negative.

**61 · Autonomy runs on a gradient.** Propose, approve each, approve class,
notify. Pick the level from the cost of being wrong.

**62 · Autonomy is earned from approval history, not granted at launch.** This
is the mechanic that turns a frightening feature into a trusted one.

**63 · Errors say what happened, why, and what next.** "Something went wrong" is
a non-statement, usually written where the system knew exactly what went wrong.

**64 · Refusals separate cannot from will not, and do not moralize.** Conflating
capability with policy makes a system feel arbitrary; a lecture makes it feel
hostile.

**65 · Memory is visible, editable and clearable.** A system that silently
remembers is a system users stop trusting the moment they notice.

---

## V. Foundations

Not AI-specific. Broken in almost every AI interface anyway.

**66 · Reserve space for every reachable state.** Find the widest and tallest
state the box can hold, give it those dimensions permanently, animate opacity
inside it.

**67 · Interrupted animations resume, never restart.** Restarting from zero is
the single most common cheap-feeling bug.

**68 · Under reduced motion the information still arrives.** Skip the trip, not
the element. Sometimes this changes what the component is, not just its speed.

**69 · Announce late, once, as an outcome sentence.** A stream announces when it
stops. "Sorted by revenue, 24 rows", not sixty updates a second.

**70 · Keyboard is a second complete implementation.** Every gesture, every
action, every dismissal. Focus is the keyboard user's cursor.

**71 · Nothing moves unless something happened.** No idle pulsing, no ambient
loops. Motion is a response.

**72 · The failure state is designed.** Users judge an AI feature on how it
behaves when it fails, because it will fail in front of them and they will
remember that instance over the ten successes.

---

## The twelve invariants

These will still be true when today's patterns have aged out. If a schedule
forces a cut, cut from elsewhere.

`15` stream · `16` account for latency · `24` reserve the box · `33` no bare
assertion · `38` no fabricated confidence · `43` editable in place · `50` stop
means stop · `53` the prompt survives · `58` reversible or flagged · `59` name
the action · `63` errors offer a next step · `72` design the failure

Everything else is a current best answer and should be dated. When a pattern
ages out, revise it in place rather than defending it.

## Reference files

| File | Covers |
| --- | --- |
| `references/specs.md` | Every numeric threshold in one table, with the reasoning |
| `references/review-protocol.md` | How to audit an existing AI feature against these rules and report it |

## Feeding this to a coding agent

Paste the rule numbers, not the prose, and let the agent read the section.
Effective prompt shapes:

```
Build the streaming response area. Apply rules 15, 24, 25, 26, 27, 50, 51, 52.
```

```
Review this component against section II and report violations as
rule / observed / expected / fix. Do not report anything not covered by a rule.
```

```
This agent run UI is done. Check 16, 17, 18, 19, 28, 29, 30, 32, 61, 62.
```

The numbering is the interface. Keep it stable across versions: retire a rule by
marking it retired, never by renumbering the ones after it.

## Interaction with other skills

`ai-interface-patterns` supplies the taxonomy and the surface choice, which is
the decision made before any of these rules apply. `micro-interactions` supplies
the implementation detail for section V and for anything in section II that
moves. `ui-design-principles` sets the visual grammar underneath all three.
