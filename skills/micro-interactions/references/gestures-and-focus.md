# Gestures, focus and overlays

## The abandonment surface

A gesture that only ends on pointer up is a gesture that gets stuck. Every
pointer-driven component listens for the full set of ways a press can stop
being a press.

```
pointerup              the normal ending
pointercancel          the OS took the pointer (system gesture, incoming call)
lostpointercapture     capture was stolen. Treat as cancel, not as a drop
pointerleave           the finger left the target        (holds only)
window "blur"          the user switched apps mid-press
visibilitychange       the tab went to the background
keydown Escape         the deliberate abort
blur                   keyboard-initiated press, focus moved away
move tolerance         the finger drifted: ~8px for a long press, ~10px hold
```

**The rule: if a component can be mid-gesture, it registers a window blur
listener.** That one line is the difference between a component that recovers
and one that needs a page reload.

Two more that are easy to miss:

- **`setPointerCapture` on the element the gesture started on**, so a drag
  survives the pointer leaving the box. Pair it with treating
  `lostpointercapture` as a cancel.
- **`touch-action` chosen by the axis you own.** `manipulation` on a button
  (kills the 300ms delay, keeps scrolling), `pan-y` on a horizontal drag (the
  page still scrolls vertically), `none` on a two-dimensional gesture where you
  own both axes.

## Keyboard is a second implementation

Not a fallback. Every gesture gets a complete keyboard model, and every model
gets a permanent hint wired through `aria-describedby` that reads like an
instruction rather than a description.

```
resize      arrows step, Shift+arrow fine, Home/End limits, Escape cancels
slider      arrows step, PageUp/PageDown jump between detents
card deck   left/right decide, Backspace undoes
lightbox    +/- zoom, arrows pan, 0 returns home
carousel    left/right move, Home/End to the ends
```

Escape cancels a drag in progress and returns the value to where it started.
This is routinely missing and users routinely expect it.

## Focus: one color, three shapes

The shape is decided by geometry, not taste.

**Inset.** A row, cell or region inside a container, where the focus mark cannot
escape the clipping box. Draw it inward: a tinted background plus an inset ring.

**Border plus lift.** A standalone control with room around it. The border takes
the accent and the shadow gains an accent-tinted glow, which reads as the
element coming forward.

**Outside.** An element that fills its own frame, where an inset line would be
painted over by its own content. Draw the ring outside the box.

Two structural traps:

- **When something slides underneath, focus is drawn as a sibling above it.** A
  travelling marker at `inset-0` will paint straight over a shadow set on the
  parent. Use a pseudo-element or a sibling that sits above the marker.
- **Draw the focus edge after the fill.** With roving tabindex, focus lands on
  the selected item, and an edge painted underneath a filled thumb is invisible
  exactly when it is needed.

**No focus rings on top of a border plus a lift.** That is already two signals,
and the third is the "too much" everyone feels but few name. If a component
draws its own focus, it opts out of the global outline explicitly.

## Overlays: portal, lock, inert, stack

Four things happen when a surface covers the page. All four are required.

**Portal to the document body.** `position: fixed` works right up until an
ancestor grows a transform, a filter or a will-change, at which point the
overlay silently becomes a child of that box instead of the viewport. That
ancestor is rarely yours. Resolve the host in an effect and render nothing until
then, so server and first client render agree.

**Scroll lock, with the gutter paid back.** Hiding the scrollbar narrows the
viewport and shifts the whole page sideways.

```js
const gap = window.innerWidth - document.documentElement.clientWidth;
body.style.overflow = "hidden";
if (gap > 0) body.style.paddingRight = `${base + gap}px`;
```

Read the computed padding first and add to it rather than overwriting a padding
the app already had. **Refcount the lock**: a module-level counter and a single
release, so two stacked dialogs do not each restore a stale overflow value on
the way out.

**`inert` to mute everything else.** Applied to every body child that does not
contain the overlay, every sibling in the portal parent, every slide that is not
current, every card that is not on top. Record the previous value and restore it
on cleanup, because setting and clearing unconditionally breaks a page that was
already using it.

**A stack, so Escape means one thing.** Keep a module-level array; each open
overlay pushes a token and the key handler returns unless its own token is on
top. Without it, one Escape closes three dialogs.

**Focus goes in and comes back.** Record `document.activeElement` on open and
restore it on close, guarded by `isConnected` because the opener may have
unmounted. The trap itself is the same handful of lines everywhere: collect the
focusable set, wrap at both ends, and if the panel contains nothing focusable,
focus the panel. A `focusin` listener that pulls focus back is the belt to the
Tab handler's braces.

## Scroll containers

Six things every scroll box agrees on:

```
overflow-y-auto + overscroll-contain     never let a wheel escape to the page
scrollbar-gutter: stable                 reserve the track from the first paint
tabIndex={0} + role="region" + label     a scroller is keyboard reachable
scroll-padding-top: barHeight + 8        anchors land below a sticky bar
overflow-anchor: none                    where you manage scroll position yourself
a spacer element, not padding            content starting below an absolute bar
```

Reserve the scrollbar gutter in **both** states whenever content can be capped
and expanded, since expanding into a scrollbar moves every line sideways by its
width. Conversely, do not reserve it on a container that can never overflow, or
every short instance pays for a track it will never show.

Content that scrolls has to be reachable without a pointer. Lint rules will
object to a tabindex on a div; the suppression is correct, and it deserves a
comment saying why.

If you manage scroll position manually, turn off the browser's scroll anchoring
and do the job properly: when items arrive and the user is not pinned to an
edge, restore the distance from the edge they are near rather than the offset
from the top. On a programmatic jump, **focus first, then scroll**, because
moving focus into a container mid-flight cancels smooth scrolling in some
engines and the jump silently does nothing.
