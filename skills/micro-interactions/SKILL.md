---
name: micro-interactions
description: Rules for the half-second after a click: motion curves, spring tuning, gesture abandonment, focus shapes, loading and skeleton timing, optimistic updates with rollback, layout-shift prevention, live-region announcements, reduced motion and animation performance. Use whenever building or reviewing any interactive component (button, input, toggle, drawer, modal, toast, carousel, slider, drag interaction, streaming output) or when something feels janky, cheap, laggy, unfinished, or "almost right". Also use before writing React or frontend animation code, so state coverage and interruption are designed in rather than retrofitted. Trigger on casual phrasing too ("make this feel snappier", "the modal is weird", "why does this jump").
version: 1.0.0
source: Distilled from the interior.dev design language (github.com/ddoemonn/interior, DESIGN.md, MIT), plus WAI-ARIA authoring practices. Specific numbers are that project's shipped values and are good defaults, not laws.
---

# Micro-interactions

Trust is won in the half-second after a click, and lost in exactly the same
place. Everything here protects that half-second.

The premise worth internalizing: these components are not hard, which is the
problem. Every team writes them, no team is given a week to write them, so they
ship at eighty percent and stay there for the life of the product. The missing
twenty percent is nearly always the same three things: **something jumps, an
animation restarts, or the motion ignores the person watching it.**

None of these get filed as bugs. Every one of them teaches the user to stop
believing the interface.

## Seven invariants

Every interactive component satisfies all seven. These are the review gate.

1. **Zero layout shift.** Every state the component can reach reserves its
   space before it arrives.
2. **Interruptible.** An animation resumes from where the element currently is,
   never from the start. Restarting on interruption is the single most common
   cheap-feeling bug.
3. **Reduced motion respected.** Under `prefers-reduced-motion` the information
   still arrives; only the trip is skipped. Never hide the element.
4. **Keyboard is a second complete implementation**, not a fallback. Every
   gesture has a keyboard equivalent, and every outcome is announced once.
5. **Nothing moves unless something happened.** No idle loops, no ambient
   pulsing. Motion is a response.
6. **Every gesture knows all the ways it can be abandoned.** Pointer up is one
   of eight endings, and the other seven are what cause stuck states.
7. **The DOM is written directly when a value changes every frame.** React does
   not re-render at 60fps to move a number.

## The two curves

Two easing curves cover almost everything. More than two is usually indecision.

```
EASE  = [0.23, 1, 0.32, 1]   arriving.  Fast start, soft landing
LEAVE = [0.4,  0, 1,    1]   leaving.   Slow start, accelerates out
```

**A departure is always shorter than an arrival.** Entrances run roughly 0.20
to 0.28s, exits 0.11 to 0.18s. The reason is mechanical, not aesthetic: an exit
as long as an entrance means the replacing element either waits, which reads as
lag, or crossfades through it, which reads as a smear.

```
enter     0.22s   opacity 0, scale 0.97, y 10, blur 6px
exit      0.18s   opacity 0, scale 0.98, y 6,  blur 3px
list      0.34s   y and scale, transform origin pinned to the entry edge
disclose  0.28s   height 0 to auto, opacity trailing at 0.18s
select    0.20s   content slides 3px
press     0.12s   translateY(1px)
```

Scale never starts at 0. Nothing in the physical world begins as a point, so
start at 0.9 or 0.97. Blur more on the way in than on the way out; that
asymmetry is what makes a panel feel like it settles rather than appears.

## Springs: distance chooses the spring

Five springs cover most work. Reusing a surface spring on a small element reads
as lag, because a soft spring reaches the target fast and then crawls the last
few pixels. Nobody thinks "underdamped"; they think slow.

| Name | stiffness / damping / mass | For |
| --- | --- | --- |
| CELL | 520 / 34 / 0.45 | The default. A cell lighting, a row taking its slot. ~180ms |
| CROSSFADE | 260 / 34 / 0.8 | Opacity between two faces, replaced content |
| SMALL | 700 / 46 / 0.5 | A label lifting, a caret rotating, a chip settling. ~170ms |
| DISCLOSE | 150 / 27 / 1 | A surface travelling a real distance: drawer, sheet |
| SURFACE | 420 / 36 / 0.9 | A modal panel. Alive without bouncing |

Measure the travel in pixels and pick:

```
over 200px    DISCLOSE
20 to 200px   CELL
under 20px    SMALL
```

Stiffness rises as distance falls; mass falls the same way. Underdamped springs
(overshoot) are almost always wrong: the exception is a hard boundary, where a
wall giving and coming back is the correct physical story.

Full catalogue and tuning notes in `references/motion-system.md`.

## Reference files

| File | Covers |
| --- | --- |
| `references/motion-system.md` | Curves, springs, physics vs taste, quantisation, stagger |
| `references/gestures-and-focus.md` | Abandonment surface, pointer capture, touch-action, keyboard parity, three focus shapes |
| `references/state-and-async.md` | Reserving space, alternatives to disabled, grace and settle timing, optimistic rollback, announcements |
| `references/performance.md` | Causes of jank, direct DOM writes, measurement, scroll containers, reduced motion |
| `references/surface-craft.md` | Materials and elevation, nested radii, the banned list, the field standard |

## Checklist

**Layout**
- Every reachable state has its space reserved. Nothing below the component
  moves when its state changes.
- A button keeps its width when its label changes.
- Lists close gaps with layout position, not by animating height to zero.

**Motion**
- Entrances and exits use different curves, and exits are shorter.
- The spring matches the distance travelled.
- No infinite loops except a spinner for unknown duration, a marquee, and a
  terminal caret (which is a square wave, never a fade).
- Anything modelling a physical process is linear, not eased.
- Gesture velocity is handed to the spring that takes over, never dropped.

**Interaction**
- Every press registers cancel, capture loss, window blur and Escape.
- Drags use pointer capture, and lost capture is treated as cancel.
- `touch-action` matches the axis the component owns.
- Every gesture has a keyboard implementation with arrows, Home and End.

**Focus**
- One focus color, and the shape is chosen by geometry, not taste.
- Never a ring on top of a border plus a lift. That is two signals already.
- The focus edge is drawn after the fill, or it is invisible when it matters.

**State**
- `disabled` is the last resort. Prefer removing, hiding while keeping the
  cell, making it not a control, or `aria-disabled` with the handler refusing.
- Loading has a grace period before appearing and a minimum once shown.
- Optimistic updates roll back on failure, with a settle window and sequence
  numbers.

**Announcements**
- Streams announce late, once the stream stops.
- Announce the outcome as a sentence, not the mechanism as a value.
- Screen readers get the final value once, not sixty updates a second.

## Failure modes

- **The jump.** A state change resizes a box and everything below it moves.
- **The restart.** An interrupted animation begins again from zero instead of
  resuming from where the element is.
- **The dropped flick.** A drag ends and the animation starts from zero
  velocity, so a fast gesture feels dead.
- **The stuck gesture.** The user alt-tabbed mid-press and the component is
  still holding.
- **The strobe.** A skeleton that appears and vanishes on a fast response.
- **The premature empty state.** "Nothing here" flashed one frame before the
  data arrived.
- **The chatty live region.** A drag announced a hundred times.
- **Idle decoration.** A pulse that means nothing, a gradient added because the
  surface looked empty.

## Interaction with other skills

`ui-design-principles` sets the spacing, type and color underneath. This skill
governs what happens over time and under the pointer. Where both have an
opinion on shadows or radii, this one is more specific and wins for component
work; the other one wins for page layout.
