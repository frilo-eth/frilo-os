# State, async and announcements

## Reserving space: the invisible twin

Invariant 1 says every reachable state reserves its space up front. In practice
that is one technique.

```html
<span class="grid">
  <span aria-hidden class="invisible col-start-1 row-start-1">{widest}</span>
  <span class="col-start-1 row-start-1">{current}</span>
</span>
```

An invisible copy of the **widest state the box can ever hold**, in the same
grid cell, sizing the column once. What it reserves against varies:

- **Longest label**: a button whose text changes between states.
- **Longest number**: counters, "3 of 12", remaining characters.
- **Longest string**: "N minutes left" at its maximum.
- **Font weight**: an invisible medium twin under a regular label, so a row
  going bold on selection cannot reflow the column. This is the subtle one, and
  in a vertical rail it is the difference between a stable column and one that
  reflows as you scroll.

Where a twin is overkill, a fixed box does the same job: a permanent height for
an error row, a reserved hint line, a fixed status row, a fixed button row.

The general form: **find the tallest and widest state the component can reach,
give the box those dimensions permanently, and animate opacity inside it.**

## State without disabling

`disabled` is a last resort. A disabled control is a dead thing you can see and
cannot ask about: it leaves a hole in the tab order, drops out of the
accessibility tree, and gets repainted in the user agent's grey, which is the
one color you do not control.

Four replacements, in order of preference:

**Let it leave.** If a control genuinely has nothing left to do, remove it. No
Back button on the first step, no Finish once the flow is complete. A
permanently dead control is worse than an empty slot, and a Finish that stays
pressable is a Finish that never finished anything.

**Let it go invisible but keep its cell.** Opacity 0 plus `inert`. Gone to the
eye, gone to the keyboard, still occupying its grid column, so the row never
moves. The right answer when layout must not shift.

**Make it not a control.** A step you have not reached is not a broken button,
it is not a button. Render a span with a screen reader label.

**`aria-disabled`, and refuse the click yourself.** The control stays reachable
and announced, the handler returns early, and you keep your own colors.

The one legitimate use of the real attribute is a control whose entire component
is switched off from outside, where reduced opacity is the whole story.

## Async: grace, minimum, settle, rollback

Four timing patterns, each solving a different flavor of flicker.

**Grace before claiming nothing is there.** Wait about 220ms after a count hits
zero before showing an empty state, because a list one frame from arriving
should not flash "nothing here". Until then the status is waiting, which draws
nothing at all.

**A minimum, so a fast response does not strobe.** Wait ~120ms before showing a
skeleton, and keep it up for at least ~380ms once shown. A 200ms request never
sees a skeleton; a 400ms one sees a complete one, not a flash.

**A settle window, so a flurry becomes one commit.** The complete optimistic
contract, worth copying rather than approximating:

1. Every interaction updates the UI immediately.
2. A ~400ms timer restarts on each one.
3. When it fires: if the intent now matches the server truth, snap back and
   send nothing.
4. Otherwise abort the in-flight request, bump a sequence number, send one.
5. A response whose sequence is stale is discarded.
6. A failure rolls the whole state back to the last known truth.

Any component that writes to a server should implement this, not a simplified
version of it. The stale-sequence discard is the step people skip, and it is the
one that causes state to flip back seconds later.

**Backoff you can watch and interrupt.** Run the wait on animation frames rather
than a timer, so the drain can be drawn in discrete steps beside a readout. A
reasonable default is `min(8000, 700 * 2^(n-1))`, and the retry control stays
live during the wait.

Two more that belong here:

- **An automatic loader must be interruptible by inaction.** Cap consecutive
  automatic loads (three is reasonable), then pause and wait for a real click.
  Scrolling the sentinel out of view resets the count. An error blocks automatic
  loading entirely until a manual retry.
- **Per-item progress, never one global bar.** A queue with bounded concurrency
  where each row owns its abort controller and its own progress. Removing a row
  aborts it; unmounting aborts everything.

## Announcements

A live region that fires on every state change is worse than none: it turns a
drag into a hundred interruptions. Three rules.

**Announce late.** Anything driven by a stream of small events waits for the
stream to stop. Use a timeout whose cleanup cancels the previous one, so only
the final value is ever spoken.

```
settled scroll section    ~420ms
result count              ~500ms
items arrived             ~700ms
verdict or status         ~700ms
several people at once    ~900ms
```

The last one has the best justification: four people joining at once is one
sentence, not four.

**Announce once.** Key a set on `${id}:${status}`, so one announcement per
message and one more when it resolves. Clear the set past a bound so a long
session cannot leak.

**Announce the outcome, not the mechanism.** The screen reader text is a
sentence, not a value.

```
"Sorted by Revenue, descending. 24 rows."
"design removed, 4 left."
```

The counterpart is the **hint**: a permanent screen-reader element wired through
`aria-describedby`, read once when the control is focused, that teaches the
keyboard model.

> Drag to resize, or move the divider with the arrow keys. Home and End go to
> the limits, and Escape cancels a drag in progress.

`role="status"` with no `aria-live` is the same thing at lower volume, and is
correct where the value is polled rather than pushed. Report the settled value,
not the live one.
