# Review protocol

How to audit an AI feature against the rule set and report it usefully.

## Report format

One line per violation. Nothing else.

```
[rule] · [what is there] · [what the rule requires] · [the fix]
```

Example:

```
24 · Copy and Regenerate sit directly under the streaming text and move with it
   · Controls must not move during streaming
   · Reserve the response box height and pin the action row to its bottom

38 · Result header reads "92% match"
   · Confidence in language, not a fabricated percentage
   · "Matched on company name and invoice total" or drop the header
```

Rules to follow while reporting:

- **Only report what a rule covers.** An observation with no rule number is an
  opinion, and opinions are what this format exists to eliminate.
- **Do not soften.** "Might be worth considering" is noise. The rule either holds
  or it does not.
- **One violation per line**, even when one component breaks four rules.
- **Do not report a rule the team broke deliberately** if the reason is
  documented. Note it as a deliberate exception and move on.
- **Rank by section, not by severity.** Section order is causal: intent failures
  make everything downstream worse.

## What to walk, in order

**1. The blank state.** Open the feature having never used it. Rules 01, 02, 03,
08, 09. If you do not know what to type, stop and report that first, because
nothing further matters.

**2. A representative task, at real speed.** Not the demo prompt. Rules 15
through 32. Watch the controls, not the text.

**3. The same task on a slow connection.** Throttle it. Rules 19, 21, 22, 23,
30, 31, 32. Most latency rules only fail here.

**4. The output, read as a skeptic.** Rules 33 through 49. Try to verify one
claim. If you cannot, that is rule 34.

**5. Interruption.** Press stop mid-stream. Rules 50, 51, 52.

**6. Correction.** Fix one wrong word in the output without re-prompting. Rules
43, 54, 55. Most features fail here and nobody tests it.

**7. Failure.** Kill the network mid-request. Rules 53, 63, 72.

**8. Keyboard only.** Unplug the mouse and repeat step 2. Rules 66 through 71.

**9. The second session.** Return the next day. Rules 30, 62, 65.

Steps 5 through 9 are where nearly every violation lives, and they are the steps
skipped in every review that produces "looks good, ship it".

## Scoring, if a number is needed

Count violations of the twelve invariants separately from the rest.

```
invariant violations   0        ready
                       1 to 2   fix before release
                       3+       the feature is not finished

other violations       count them, rank by section, schedule
```

Resist a composite score. It compresses "confidently wrong with no provenance"
and "skeleton flashes" into one number, and those are not the same problem.

## Reviewing your own work

The same walk, with one addition: do steps 2 and 6 having not touched the
feature for a week. Familiarity hides intent failures completely, and intent
failures are the expensive ones.
