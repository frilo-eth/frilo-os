---
name: ai-interface-patterns
description: Design patterns and conventions for AI-powered product interfaces: prompt inputs, suggestions, chat, copilots, agents, generative UI, streaming output, citations, confidence, memory, permissions, undo and disclosure. Use whenever designing, reviewing or building any feature where a model generates, decides or acts, including chat surfaces, inline AI actions, assistants, agent runs and AI onboarding. Also use when the request is about whether a feature should be AI at all, why an AI feature feels untrustworthy or gimmicky, or how to communicate what a model can and cannot do. Trigger on casual phrasing too ("add AI to this", "make the assistant feel less creepy", "the agent needs a UI").
version: 1.0.0
source: Synthesized from The Shape of AI pattern library (Emily Campbell, CC-BY-NC-SA), Google PAIR People + AI Guidebook, Microsoft HAX Toolkit Guidelines for Human-AI Interaction (Amershi et al., CHI 2019), and framing from Sentient Design (Clark and Kindred, 2026), UX for AI (Nudelman, 2025) and Designing Assistant Technology (Noessel, 2026).
---

# AI interface patterns

Conventional UI promises determinism: the same input gives the same output, and
the button either worked or it did not. AI interfaces break that promise. The
output is probabilistic, sometimes wrong, sometimes slow, occasionally
confidently wrong. Every pattern here exists to keep the interface honest about
that without making it feel fragile.

The design problem is not "how do we add a chat box". It is: **how does the user
form intent, see what the system is doing, judge whether the result is any good,
and correct it when it is not.** Four questions. Any AI feature that cannot
answer all four is unfinished.

## Step zero: should this be AI

Ask before designing anything.

- **Would a deterministic feature do this better?** A filter, a sort, a saved
  view. If yes, build that. AI applied to a solved problem is a downgrade with
  a higher operating cost.
- **What is the cost of being wrong?** Low cost and easily reversed means the
  model can act. High cost or irreversible means the model proposes and the
  human commits. This single question determines most of the interface.
- **Is the user better off afterward, or just faster?** A system that produces
  the answer and teaches nothing creates dependence. Fine for expense reports,
  corrosive for anything the user is meant to get good at.
- **Can the user tell when it failed?** If failure is invisible to the person
  using it, the feature needs verification built in or it should not ship.

Automate the boring and the reversible. Augment the consequential.

## The four surfaces

Choosing the wrong surface is the most expensive mistake in AI design, and it
usually goes the same direction: chat when chat was not needed.

| Surface | Shape | Right when | Wrong when |
| --- | --- | --- | --- |
| **Inline** | AI action attached to existing content | The object and the intent are already on screen | Never really wrong. Start here |
| **Chat** | Open conversational input | Intent is open-ended and unpredictable; the user needs to negotiate | The task has a known shape. A form beats a conversation for anything with fields |
| **Copilot** | Persistent assistant beside the work | The user stays in control of a document or canvas and wants suggestions in context | It becomes a sidebar nobody opens |
| **Agent** | Delegated goal, multi-step execution | The task is long, mechanical, and the steps are auditable | Steps are invisible or the actions are irreversible without approval |

Chat is the highest-freedom, highest-effort surface. It puts the entire burden
of knowing what to ask on the user. It is the right answer far less often than
it is the chosen answer. If a task has three variables, three inputs beat a
prompt that has to be guessed.

Agents change the relationship from operator to manager. A manager needs a
status, a reason, an intervention point and a record. That is four interface
requirements, not one progress bar.

## Pattern families

Full pattern list in `references/pattern-families.md`. The six families, and
what each is for:

| Family | Job | Read when |
| --- | --- | --- |
| **Wayfinders** | Get the user from blank canvas to first useful prompt | Designing onboarding, empty states, first run |
| **Inputs** | The actions a user can direct the AI to perform | Deciding what the AI can be asked to do and how |
| **Tuners** | Constrain and steer before generation | The output is nearly right but uncontrollable |
| **Governors** | Human oversight, interruption, approval | The AI acts, spends, or does anything consequential |
| **Trust builders** | Show provenance, limits, and what happens to data | Always. Especially in regulated or high-stakes contexts |
| **Identifiers** | How AI is named, marked and personified | Establishing brand-level AI conventions |

Most shipped AI features are heavy on Inputs and empty on Governors and Trust
builders. That imbalance is what makes a feature feel like a demo.

## Non-negotiables

| Rule | Why |
| --- | --- |
| State capability before first use | Users calibrate expectations once, at the start, and rarely revise |
| Never present generated output as fact without provenance | Citations, sources, or an explicit uncertainty marker |
| Every generation is regenerable and reversible | A one-shot irreversible generation is a trap |
| Show the work for anything multi-step | Steps, tool calls, decisions. Silence reads as either broken or untrustworthy |
| Interrupt must exist and must be instant | A stop button that takes three seconds is not a stop button |
| Anything irreversible gets explicit confirmation naming the action | "Send 47 emails", not "Continue" |
| Disclose AI-generated content | Legally required in a growing number of places, ethically required everywhere |
| Memory is visible and editable | A system that silently remembers is a system users stop trusting |
| Errors offer a next action | "Try again", "narrow the scope", "switch models". Never a dead end |
| Latency is filled with real information | Show the actual step, not a spinner and a rotating quip |

## The interaction lifecycle

Microsoft's HAX Toolkit organizes its 18 guidelines around four moments. Use it
as the review structure, since most failures cluster in the last two.

1. **Initially**: make clear what the system can do and how well it does it.
   Set expectations before the first prompt, not in a tooltip afterward.
2. **During**: show contextually relevant information, time the intervention to
   the task, and make invocation and dismissal cheap.
3. **When wrong**: support efficient correction, explain why the system did
   what it did, and scope the service down when confidence is low.
4. **Over time**: remember recent interactions, learn from behavior, update
   cautiously, invite granular feedback, and provide global controls.

Details and the corresponding patterns in `references/trust-and-oversight.md`.

## Reference files

| File | Covers |
| --- | --- |
| `references/pattern-families.md` | Full Shape of AI pattern taxonomy with application notes |
| `references/surfaces.md` | Chat, copilot, agent and generative UI in depth, including the manager experience |
| `references/trust-and-oversight.md` | HAX lifecycle, confidence, citations, permissions, error recovery, evaluation |
| `references/copy-and-disclosure.md` | AI microcopy, naming, personality, disclosure, consent, refusals |

## Audit checklist

**Intent**
- The user can tell what the feature is for before using it.
- Blank canvas is solved: suggestions, templates, examples or a sample gallery.
- Effort matches stakes. No prompt required for a task with three variables.

**Execution**
- Work is visible for anything over a couple of seconds.
- The user can stop, and stopping is immediate.
- Long runs are scoped and estimated, not open ended.

**Output**
- Provenance is attached: sources, references, or an explicit limit statement.
- Confidence is communicated in language, not a fake percentage.
- Output is editable in place. The user is not forced to re-prompt to fix a word.
- Regenerate, variations and branching exist where iteration is expected.

**Oversight**
- Consequential actions require confirmation naming the specific action.
- Everything the AI did is reversible, or clearly flagged as not.
- Permissions are scoped and inspectable.
- Memory is visible, editable and clearable.

**Honesty**
- AI content is marked as AI content.
- Limits are stated somewhere the user will actually read them.
- The failure state is designed, not just the happy path.
- The system does not claim certainty it does not have.

## Failure modes

- **Chat as a shrug.** Conversation used because the interaction was not
  designed. The blank input transfers the design problem to the user.
- **The confidence theater.** A precise-looking percentage attached to an
  estimate the system cannot actually make.
- **Anthropomorphic overreach.** A persona implying understanding, memory or
  feeling the system does not have. It buys warmth and spends trust.
- **The invisible agent.** Long autonomous run with a spinner. The user cannot
  tell working from hung.
- **Irreversibility by omission.** The AI acted, and nobody designed undo.
- **Sycophancy as UX.** An assistant that agrees with everything is not
  helpful, it is a mirror with a latency cost.
- **Permanent beta shield.** A blanket "AI can make mistakes" line used in
  place of designing for the mistakes.
- **Sparkle-washing.** The AI icon applied to a feature that is a database
  query, spending the brand's AI signal on nothing.

## Interaction with other skills

`ui-design-principles` governs the visual grammar underneath all of this: an
agent console still needs a spacing scale and real focus states.
`micro-interactions` governs streaming, loading, interruption and state
transitions, which is where most AI interfaces actually fail in the build.
