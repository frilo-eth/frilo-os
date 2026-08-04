# Surface craft

Component-level surface rules. Where these conflict with `ui-design-principles`,
these are more specific and win for component work.

## Three materials

Everything on screen is one of three layers, and depth is real: a well is cut
into the surface, a panel is lifted out of it, a cap has a bottom lip you could
press with a finger.

| Layer | What it is |
| --- | --- |
| **bezel** | The frame everything sits in. The page background |
| **panel** | The lifted card, where content lives |
| **well** | The recessed slot: inputs, code, previews, chips |

Five elevations, and they are the only ones:

```
panel   lifted card              small offset shadow plus a hairline ring
float   floating over everything large soft shadow, heavily negative spread
well    cut into the panel       inset shadow, top edge only
cap     a pressable key          bottom lip plus a hairline all round
row     picked out of a list     inset ring plus a small shadow
```

In dark mode, panel and cap also carry an inset white highlight on the top edge.
That top light is what makes a dark surface read as lifted rather than as a
hole.

**A plain border never carries elevation.** Use a hairline when dividing one
compartment from another, and material when one thing is above or below another.

**The shadow color is ink, not black.** A neutral black shadow on a warm surface
reads as dirt. Dark mode is the exception and does use plain black, because
there the shadow is an absence of light rather than a tint.

## Dark surfaces rise by getting lighter

A field or panel that recedes on a dark background does so through an inset
shadow, never through a lighter fill. A lighter tint inside a field makes it
glow against its neighbours. Conversely, a focused surface rises by getting
lighter, because a focus painted in the panel's own color is a field that
vanishes into the card.

## Radii nest

**Outer radius equals inner radius plus the padding between them.** The numbers
are derived, never guessed.

```
14 panel  with 5px padding  ->  9 row      (14 = 9 + 5)
11 panel  with 5px padding  ->  6 row      (11 = 6 + 5)
12 shell  with 4px padding  ->  8 plateau  (12 = 8 + 4)
```

A working ladder:

```
20  page panel
16  preview frame, code block
14  card, table, overlay panel
12  tabs shell
11  well inside a 16 frame, popover, dropdown
10  field, drop target
 9  list row, button, search field
 8  nested row, tab plateau
 7  icon button inside a panel
 6  cap, chip, small action
 5  cell, small chip, keycap, checkbox
 4  progress track
 2  fill, tick, rail
```

When a number is not derivable, derive it from the nearest one that is.

## The field standard

Every field in a set should be the same object. The idea: **an empty field is a
slot, and entering it brings it to the surface.** A field that only changes its
border color on focus has no depth.

```
rest      2px hairline-strength border, tinted fill, inset shadow
focus     2px accent border, plain surface fill, no inset shadow
invalid   2px error border, plain fill
success   2px success border, plain fill
```

Two things the rest state gets right: the border sits below hairline strength on
purpose, because a 2px border at full strength reads as a focus ring at rest.
The well does the recessing; the border whispers until focus makes it shout.

**Focus is always the accent color**, because it is the most repeated moment in
any interface and therefore where the identity lives.

Two structural rules:

- **The field owns the border, the input owns nothing.** Put the border on a
  wrapper and make the input transparent with no outline. That is what lets the
  shell animate its width, or a label float out of it, without the input's own
  box fighting.
- **Fields are the one place a CSS transition beats a spring**, because nothing
  is being dragged. The state changes discretely on focus, and 150ms of color
  is the whole move.

## The banned list

These bans exist to stop one thing: output that looks like every other generated
interface. They are a defence against genericness, not a formula. The moment a
ban becomes a formula it has failed in a new costume.

**A ban yields when the banned thing is genuinely the right answer, and you can
say why in one sentence.**

| Banned | Instead |
| --- | --- |
| Fully rounded pills and circular avatars by default | A radius from the ladder |
| Idle pulse animations, any ambient loop | Discrete cells, event-driven motion |
| Grid and dot-grid backgrounds | Material difference |
| Decorative gradients, glow, aurora | One accent, where it means something |
| Uppercase mono as a default voice | Mono for metadata and numbers only |
| Borders standing in for depth | Material |
| Drop shadows added to "add polish" | The material already has the shadow |

The standing exemptions, each with its one-sentence defence:

```
ripple        a wave leaving a point is a circle; a scaled rounded rect grows
              its own radius and turns into a blob
typing dots   three dots in a bubble is a published, learned idiom
spinner       unknown duration, constant speed, one arc
marquee       the loop is the component
caret blink   a hard square wave, the terminal's own shape, never a fade
streaming dot a dot is a circle, and the round mark trailing generated text
              is now a learned idiom across every major assistant
```

**A streaming dot is not a caret, and the difference decides the motion.** A
caret marks an insertion point waiting for input, so it blinks: the blink is
what says "your turn". A streaming dot marks output in progress, so it must not
blink, because the token arriving is already the signal. Give it a fast scale-up
on the first token, let it ride the end of the text, and scale and fade it out
in about 200ms when the stream ends. A pulsing streaming dot is the same mistake
as an idle pulse anywhere else: motion with nothing behind it.

The caret is the instructive one. Opacity stepping between 1 and 0 with linear
easing and equal times is a square wave. A sine-fading cursor is the tell of a
component that reached for a generic pulse.

What is never allowed is what the bans were written against: decoration with
nothing behind it. A pulse that means nothing. A gradient because the surface
looked empty. A pill because everything else was a pill.

## Details that carry the whole thing

- **A button keeps its width when its state changes.** Both labels live in the
  same grid cell; only opacity moves.
- **A row picked out of a list is marked by its surface, not by moving.** A
  small content nudge belongs to transient selection, like a cursor travelling a
  command palette. On a persistent state such as the current route, it is one
  row permanently out of line with every other row, which is the ragged left
  edge you feel before you can name it. The same applies to hover: the highlight
  already says which option is yours, so sliding the label as it arrives reads
  as the list shifting under the pointer.
- **A ghost of the thing you are dragging is one statement too many.** The gap
  the siblings open is the drop target.
- **Separators belong to the slots, not to the rows.** Position them absolutely
  at fixed intervals rather than as children of rows, or they blink off
  mid-travel when a row sorts. Paint them last so a marked row's tint cannot
  swallow one.
- **Scroll containers fade at both ends**, never hard-cut.
- **Sub-text wakes up on selection** by one step in the ink ramp. Never a color
  change large enough to notice as a color change.
- **When in doubt between subtle and legible, legible wins.** A divider at 7%
  and metadata at near-background grey read as refined in a mockup and as broken
  on a real screen. Restraint belongs in the type sizes and the motion, not in
  whether people can see the line.
- **Demos are replayable.** A micro-interaction you can only watch once is a
  screenshot with extra steps.
