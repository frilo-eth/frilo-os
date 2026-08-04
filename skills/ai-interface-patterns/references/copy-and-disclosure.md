# Copy and disclosure

## Voice

The assistant's voice is a product decision with trust consequences. Two
failure directions: cold enough to feel hostile, or warm enough that users
attribute understanding the system does not have.

Working defaults:

- **Plain, direct, unhedged.** Say the thing. Endless qualification reads as
  evasion, not care.
- **First person for actions, not for feelings.** "I searched three documents"
  is fine. "I am excited to help" is a lie about an internal state.
- **No performed enthusiasm.** Exclamation marks and "Great question" are
  filler that costs credibility.
- **Admit limits in specifics.** "I cannot see files in that folder" beats "I'm
  sorry, I'm not able to help with that."
- **Never apologize twice.** Fix it or explain it. Repeated apology is a tell of
  a system with nothing useful to say.

## Personality

Personality is a range, not a character. Set a floor and a ceiling:

- Floor: pleasant enough that the interaction is not grim.
- Ceiling: flat enough that nobody forms a relationship with it.

The ceiling is the part that gets skipped. An assistant that flatters, agrees
reflexively, or performs affection is optimizing for session length at the
user's expense. For consumer products aimed at vulnerable users this is a
safety issue, not a taste issue.

Personality should also stay stable. An assistant whose tone drifts between
sessions reads as unreliable in a way users feel before they can name.

## Microcopy patterns

### Naming actions

The label states the output, not the mechanism.

| Weak | Better |
| --- | --- |
| Generate | Write the summary |
| Run AI | Find matching invoices |
| Submit | Ask about this page |
| Continue | Send all 47 emails |

### Loading and streaming

Say what is happening. Real steps, in the user's vocabulary.

- Good: "Reading 12 pages", "Checking your calendar", "Drafting the reply".
- Bad: "Thinking...", "Working on it", rotating jokes, a bare spinner.

For long runs, name the current step and keep the completed ones visible. The
user should be able to leave and come back and understand the state without
reading everything again.

### Empty states

The AI empty state has one job: teach what a good prompt looks like here. Three
specific, contextual examples beat any amount of explanation. Generic examples
teach nothing except that the feature is generic.

### Errors

Structure: what happened, why if knowable, what to do next.

- "Could not reach the model. Your prompt is saved. Retry."
- "That folder is not connected. Connect it, or paste the text directly."

Never: "Something went wrong." It is a non-statement, and it usually appears
where the system actually knew exactly what went wrong.

### Confirmations for consequential actions

Name the action, the scope, and the irreversibility.

```
Send this reply to 47 recipients?
This cannot be undone.
[ Review the list ]   [ Send 47 replies ]
```

Never "Are you sure?" with Yes and No. See `ui-design-principles`,
`references/voice-and-motion.md`, on double negatives in dialogs.

## Disclosure

Mark AI-generated and AI-assisted content. This is converging into law in
several jurisdictions and it is the right default regardless.

- Mark at the point of consumption, not only in settings.
- Distinguish generated from assisted where the difference matters. Fully
  synthetic output is a different claim from an edited draft.
- Do not bury disclosure in a tooltip.
- For media, machine-readable provenance (watermark, content credentials) in
  addition to the visible mark.
- When AI is speaking to a person on behalf of a business, say so at the start
  of the interaction, not when asked.

## Caveats vs disclaimers

A disclaimer protects the company. A caveat helps the user calibrate. Ship
caveats.

- Disclaimer: "AI can make mistakes. Check important info."
- Caveat: "This summary covers the 40 most recent comments. Older ones were not
  read."

A blanket disclaimer at the bottom of every screen becomes invisible within a
week and does not substitute for designing the failure states.

## Refusals

When the system will not do something, the copy should:

- Name the category of the limit without exposing internal policy plumbing.
- Distinguish "cannot" (capability) from "will not" (policy). Conflating them
  makes the system feel arbitrary.
- Offer the nearest legitimate alternative where one exists.
- Not moralize. A refusal plus a lecture is what makes people resent a tool.

## Words to avoid in AI interfaces

| Avoid | Because |
| --- | --- |
| "Magic", "magical" | Sets up the system as unaccountable |
| "Thinking" | Implies cognition, and it is usually just latency |
| "Understands you" | It does not, and the claim collapses on the first failure |
| "Perfect", "flawless" | One counterexample destroys the whole claim |
| "Just" ("just describe what you want") | Minimizes real effort the user is about to spend |
| "Powered by AI" as a feature | Says nothing about what the user gets |
