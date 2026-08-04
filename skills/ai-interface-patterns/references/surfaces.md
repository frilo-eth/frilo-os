# Surfaces

## Inline AI

The default. AI attached to an object already on screen: a selection, a row, a
document, a comment thread.

Advantages over every other surface: the object needs no description, the scope
is bounded, the result lands where the work already is, and discovery is free
because the affordance sits next to the thing.

Design rules:

- Trigger on selection or hover, not in a separate panel.
- Offer named actions, not an open prompt. Three good verbs beat a text field.
- Result appears in place, as a diff or a proposal, never as a silent overwrite.
- Accept, reject and edit are all one click from the result.
- Keep the original until the user accepts. Undo is not a substitute for that.

If a feature can be inline, it should be inline. Everything below is for cases
where it genuinely cannot.

## Chat

Chat is right when the space of intents is genuinely open and the user needs to
negotiate meaning across turns. It is wrong when the task has a knowable shape.

What chat actually costs: the user must know what to ask, phrase it well, and
hold the thread in their head. That is a real tax, and it is why chat adoption
outside of general assistants is usually poor.

Design rules:

- **Solve the blank input.** Suggestions, templates and an example gallery are
  not decoration; they are the onboarding.
- **Stream output.** Waiting for a complete response with no signal is the
  worst possible latency experience. Streaming converts wait into progress.
- **Streaming must be interruptible**, and the stop must land within a frame or
  two. See `micro-interactions` for the timing.
- **Messages are editable.** Editing the prompt and re-running beats appending
  a correction, which pollutes the context and confuses the model.
- **Turns are branchable.** Editing an earlier turn should fork rather than
  destroy, so exploration is not punished.
- **Long output needs structure**: headings, collapsible sections, code blocks
  with copy. A wall of prose is a failure of the interface, not the model.
- **Context is visible.** What files, memory and tools are in play should be
  inspectable and removable before sending.
- Copy, regenerate and feedback controls sit on the message, appearing on hover
  rather than permanently.

## Copilot

A persistent assistant alongside work the user owns. The user drives, the
copilot suggests.

Design rules:

- Suggest at natural pauses, not mid-keystroke. Timing is the difference
  between helpful and infuriating.
- Suggestions are dismissible with a single gesture, and dismissal is
  remembered.
- Never move the user's cursor, scroll position or selection.
- Make invocation cheap and dismissal cheaper. A copilot that is expensive to
  get rid of is a copilot that gets turned off permanently.
- Silence is a valid output. A copilot that always has something to say is
  noise.

## Agents

The user delegates a goal. The relationship becomes management, and management
needs four things the interface must supply.

**1. Status.** What is happening right now, in the user's terms. A named step
("reading the invoice PDF") not a raw trace. Steps accumulate into a visible
list so a returning user can catch up without re-reading everything.

**2. Reasoning.** Why this step, why this tool, why this decision. Summarized
for humans. Full detail available on expand, never on by default.

**3. Intervention.** Stop, pause, correct, redirect. All available at any time
and all immediate. An agent that cannot be interrupted mid-run is a liability
regardless of how good it is.

**4. Record.** What happened, what changed, what it cost. Reviewable afterward,
because the user was not watching and should not have had to.

### The permission gradient

Autonomy is earned, not granted at launch. Scale it:

| Level | Behavior | Right for |
| --- | --- | --- |
| Propose | Shows a plan, does nothing | First run, high stakes, new users |
| Approve each | Executes step by step with confirmation | Consequential or irreversible actions |
| Approve class | Confirms once for a category of action | Repeated, understood workflows |
| Notify | Acts and reports | Reversible, low stakes, established trust |
| Silent | Acts without reporting | Almost never. Only for the truly trivial |

Start conservative and let the user's own approval history move the level. This
is the mechanic that converts a scary feature into a trusted one, and it also
gives the user a mental model of what the agent is for.

### Irreversibility

The critical distinction. Before an agent acts, classify:

- **Reversible**: draft, local change, anything with undo. Act freely.
- **Reversible with effort**: published, shared, synced. Notify clearly.
- **Irreversible**: sent, paid, deleted, posted externally. Always confirm, and
  the confirmation names the specific action and its scope.

An agent that cannot tell these apart should not have tools that touch the
third category.

### Failure

Agents fail in ways traditional UI does not: partial completion, tool timeout,
permission denied, ambiguous intent, and looping. Each needs a designed
recovery: retry the step, ask for the missing input, hand off to the human, or
stop cleanly and report. Silent failure at step 7 of 12 is the worst outcome
available, because the user believes the work is done.

## Generative UI

The interface itself is assembled per request rather than authored in advance.
Early, genuinely useful in narrow cases, and easy to get wrong.

Rules if attempting it:

- **Compose from a fixed component set.** The model chooses and arranges
  known components; it does not invent visual language. This keeps the design
  system in charge and the output accessible.
- **Keep layout stable across regenerations.** An interface that rearranges
  itself between visits cannot be learned, and learnability is most of what
  makes software usable.
- **Anchor the changing parts.** Persistent chrome, generated content. Users
  need at least one fixed thing.
- Anything the user might want to keep needs to be pinnable, or it evaporates.

The test: would a returning user recognize this screen? If not, generation has
been applied to something that needed authorship.
