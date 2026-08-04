# Pattern families

Taxonomy from The Shape of AI (Emily Campbell, shapeof.ai, CC-BY-NC-SA), with
application notes. Six families. Names are worth using verbatim, because a
shared vocabulary is most of what this field is short of.

## Wayfinders

Get the user from blank canvas to a first useful prompt. The blank input is the
single biggest drop-off point in any AI product.

| Pattern | What it does |
| --- | --- |
| Initial CTA | Large open input inviting the first interaction |
| Suggestions | Prompt clues that solve the blank canvas problem |
| Templates | Structured prompt scaffolds, user-filled or pre-filled |
| Example gallery | Sample generations with their prompts and parameters, so users learn by reading |
| Follow up | The system asks for more when the prompt is underspecified |
| Nudges | Surface AI actions the user has not discovered |
| Prompt details | Show what is actually being sent behind the scenes |
| Randomize | Low-effort entry point that produces something fun |

Notes:

- Suggestions must be **specific to the user's context**, not generic. "Write a
  blog post" teaches nothing. "Summarize the 12 comments on this PR" teaches
  the shape of a good prompt and the scope of the tool at once.
- The example gallery is the most underused pattern in the set. Showing the
  prompt next to the result is the fastest prompt tutorial ever built.
- Follow up beats a bad generation. If confidence is low, ask one question.
  One. A clarifying interrogation is worse than a mediocre first draft.

## Inputs (prompt actions)

The verbs. What a user can direct the AI to do.

| Pattern | What it does |
| --- | --- |
| Open input | Free-form natural language prompting |
| Inline action | Invoke AI contextually on something already on the page |
| Auto-fill | One prompt populates multiple fields |
| Chained action | Output of one action feeds the next |
| Summary | Distill a topic or resource |
| Synthesis | Reorganize complex information into structure |
| Expand | Lengthen or add depth |
| Restructure | Use existing content as the starting point |
| Restyle | Change style while preserving structure |
| Transform | Change the modality of content |
| Describe | Decompose something into its tokens and a suggested prompt |
| Inpainting | Regenerate a targeted region of a result |
| Madlibs | Repeat a generative task with format held constant |
| Regenerate | Reproduce the response without new input |

Notes:

- **Inline action is the highest-value pattern in the family.** It removes the
  need to describe the object, since the object is already selected. Most
  features that reach for chat should have reached for this.
- Named actions beat an open prompt for anything repeated. Users do not want to
  retype an instruction they issue daily.
- Madlibs exists because format consistency matters more than eloquence in
  production. Use it wherever output feeds another system.

## Tuners

Constrain and steer before generation, so the user is not reduced to rerolling.

| Pattern | What it does |
| --- | --- |
| Parameters | Explicit constraints alongside the prompt |
| Filters | Constrain input or output by source, type or modality |
| Attachments | Anchor the response to a specific reference |
| Connectors | Let the AI reference external systems and data |
| Modes | Swap training, constraints or persona per context |
| Model management | Let the user choose the model |
| Preset styles | Default aesthetic and tone options |
| Saved styles | User-defined presets for reuse |
| Voice and tone | Keep outputs consistent with a defined voice |
| Prompt enhancer | System-assisted improvement of the user's prompt |

Notes:

- Tuners are the difference between a toy and a tool. Rerolling until something
  lands is not control, it is a slot machine.
- Expose the tuners that matter and hide the rest. Model pickers are a power
  user affordance and confusing as a default.
- Saved styles are where a professional user's investment accumulates. Anything
  a user tunes repeatedly should be savable.

## Governors

Human-in-the-loop oversight. The family most often skipped, and the reason
serious buyers reject AI features.

| Pattern | What it does |
| --- | --- |
| Action plan | The AI states its intended steps before executing |
| Verification | User confirms decisions or actions before they proceed |
| Sample response | Confirm intent on complex prompts before full generation |
| Controls | Pause, stop or adjust mid-stream |
| Stream of thought | Reveal reasoning, tool use and decisions for auditability |
| Footprints | Trace the path from prompt to result |
| Shared vision | Live visibility of AI action in a shared canvas |
| Branches | Iterate while retaining a path back to the original |
| Variations | Multiple results to choose between |
| References | See and manage what sources are being used |
| Memory | Control what the AI knows about the user |
| Draft mode | Explore cheaply before committing to a final render |
| Cost estimates | Show compute or spend before the user commits |

Notes:

- **Action plan plus verification is the standard agent contract.** State the
  plan, get approval, execute, report. Skipping the plan is what makes agents
  feel like a gamble.
- Branches matter more than undo for creative work. Users want to go back
  without losing the thing they went back from.
- Cost estimates are becoming table stakes as agent runs get expensive. Users
  tolerate cost; they do not tolerate surprise.
- Stream of thought is a design decision, not a debug view. Summarize the
  reasoning into steps a human wants to read. Raw traces are for engineers.

## Trust builders

Confidence that results are accurate, ethical, and that data is handled
properly.

| Pattern | What it does |
| --- | --- |
| Citations | Inline annotation of sources |
| Disclosure | Clearly mark AI-guided or AI-delivered content |
| Caveat | State model shortcomings and risks |
| Consent | Capture others' data only with knowledge and permission |
| Data ownership | Control how the model remembers and uses your data |
| Incognito mode | Interact outside of memory |
| Watermark | Machine-readable identifiers on generated content |

Notes:

- A caveat is not a disclaimer. A disclaimer protects the company, a caveat
  helps the user calibrate. "May be inaccurate" is a disclaimer. "Trained on
  data through March; will not know about recent filings" is a caveat.
- Citations must be checkable. A citation that does not resolve to the claim is
  worse than none, because it manufactures unearned confidence.
- Incognito and memory controls are increasingly expected defaults rather than
  privacy features for the paranoid.

## Identifiers

How the AI is recognized as AI, at brand level.

| Pattern | What it does |
| --- | --- |
| Name | What the AI is called across the product |
| Avatar | Visual identity of the assistant |
| Iconography | Marks for AI-powered actions |
| Color | Visual cue distinguishing AI features and content |
| Personality | Traits and vibe of the AI's voice |

Notes:

- Pick one AI signal and hold it. The sparkle icon is now generic enough to be
  meaningless, so if the brand has an accent to spend, spend it here instead.
- Reserve the signal for actual model involvement. Applying it to a sort
  function is how a product teaches users to ignore it.
- Personality should be a floor and a ceiling: warm enough to be pleasant, flat
  enough that nobody mistakes it for a person. See
  `references/copy-and-disclosure.md`.
