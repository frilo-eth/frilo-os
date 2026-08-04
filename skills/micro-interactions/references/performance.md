# Performance and measurement

## Three ways to make it laggy

In order of how long each takes to find:

**1. Setting state during an animation.** An animation-start callback that flips
a flag re-renders the subtree mid-flight and drops frames. Set the hint
statically or not at all.

**2. Animating `mask-image`.** A mask is repainted every frame and cannot be
composited. To fade an edge in and out, animate the opacity of a gradient
overlay instead, which runs entirely on the compositor.

The corollary, not an exception: **a mask is fine where it never animates; a
gradient overlay is required where it does.** A static faded sidebar can use a
mask. A veil that appears and disappears cannot.

**3. Animating layout properties when a transform would do.** A row leaving a
list should exit on opacity and translate, and let its siblings close the gap
with a position-only layout animation. Animating its height to zero relayouts
the whole list every frame.

## Write the DOM directly at 60fps

React should not re-render sixty times a second to move a number. Components
that update every frame bypass it, and each names the channel it writes through.

```
transform             element.style.transform, off one shared rAF
a CSS custom property container.style.setProperty("--split", "42%")
text                  node.textContent = "42%"
motion values only    no React state at all until a threshold is crossed
```

The pattern worth copying: the live value is a CSS custom property that the
layout reads, the reported value is an aria attribute set imperatively, and
React state is written only when the gesture **commits**. Three channels, three
cadences, one render.

A scroll-driven component built entirely on transforms of the scroll position
needs no reduced-motion branch at all, because each value resolves on the frame
it is scrolled to. Say so in a comment, or the next reader will file it as an
oversight.

## Measurement

Never read a layout value more often than necessary, and never re-render because
a number changed by half a pixel.

```js
// Always a ResizeObserver, never a resize listener.
const observer = new ResizeObserver(read);
observer.observe(el);
return () => observer.disconnect();

// Always an epsilon, so subpixel jitter cannot loop.
setBox(prev => Math.abs(prev.width - w) < 0.5 ? prev : { width: w });

// Always a layout effect on the client, so the first paint is correct.
const useIsoLayoutEffect =
  typeof window === "undefined" ? useEffect : useLayoutEffect;
```

Without the epsilon, a fractional layout width feeds back into a state update
that changes the layout width, and the observer never settles.

**Prefer not measuring.** Most measurement is avoidable arithmetic:

- A constant row height means a highlight needs no measurement at all.
- Evenly spaced steps mean a marker travels on a percentage.
- `repeat(n, 1fr)` means a thumb sits at `i * 100%`.
- One slide width, read once, and everything else is arithmetic.

The trick worth stealing: to invert a label under a moving thumb, do not
position a second copy per item. Draw the whole row of labels once inside the
thumb and counter-translate it by the exact negation of the thumb's offset. Two
transforms, one source of truth, and the label inverts through the thumb rather
than crossfading with a duplicate.

Where a measurement is unavoidable and expensive, take it **once per gesture,
not per frame**: read every rect you need at pointer down, cache it, then let
the move handler do pure arithmetic and write one transform.

## Reduced motion

The pattern is one constant and one ternary.

```js
const INSTANT = { duration: 0 };
const move = reduced ? INSTANT : CELL;
```

Duration zero rather than removing the animation, because the element must still
end up in the right place. The information arrives; the trip is skipped.

Three refinements:

- **`initial={false}`** where a mount would otherwise animate. Under reduced
  motion the entrance is skipped, not deleted.
- **Shared-layout animations must be switched off, not zeroed.** They cannot be
  given a zero duration, so pass no shared id at all when reduced.
- **Behavior, not just timing.** Pass `behavior: "auto"` instead of `"smooth"`
  to scroll calls. A streaming text effect jumps straight to done and shows the
  whole string. A marquee stops looping entirely and becomes a real scroll
  container, which means its viewport now needs a tab stop it did not need
  before.

That last one is the general lesson: reduced motion sometimes changes what the
component **is**, not just how fast it moves, and the accessibility surface
changes with it.
