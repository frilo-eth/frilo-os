# Motion system

## Springs, not CSS transitions

If a real animation layer is available, use it. A CSS `transition` on something
being driven by a gesture will always look flatter, because it has one speed and
no memory of where it was going.

Fixed-duration tweens stay only where the timing itself is the information: a
count-up has to land when it says it will, a page entrance should not vary, and
a hold-to-confirm sweep is a contract with the finger.

Three jobs remain for a CSS transition, all of them discrete color changes on
things nobody is dragging:

```
transition-colors 150ms                      hover and focus tint
transition-[border-color,box-shadow] 150ms   a field or button changing state
transition-[background-color] 200ms          a tone crossing a threshold
```

## The full spring catalogue

Damping ratio is `c / 2 sqrt(km)`. Under 1 overshoots, at 1 is critical, over 1
crawls in. Almost everything here is slightly overdamped, which is what
"arrived and stopped" feels like.

| Use | k / c / m | ratio | Note |
| --- | --- | --- | --- |
| Default cell | 520 / 34 / 0.45 | 1.11 | ~180ms, no tail |
| Crossfade | 260 / 34 / 0.8 | 1.18 | Content being replaced |
| Small move | 700 / 46 / 0.5 | 1.23 | ~170ms |
| Disclose | 150 / 27 / 1 | 1.10 | Real distance travelled |
| Modal surface | 420 / 36 / 0.9 | 0.93 | Alive, does not bounce |
| Tab indicator | 620 / 42 / 0.35 | 1.42 | Wide element; overshoot reads as a correction |
| Progress fill | 210 / 34 / 0.9 | 1.24 | A meter must not spring past the number it reports |
| Smoothed upload | 240 / 44 / 0.6 | 1.16 | Spring over reported progress so a lumpy transport reads smooth |
| Carousel wall | 700 / 30 / 0.5 | 0.80 | The one underdamped case: a wall gives and comes back |

Read it as a shape rather than a list. Stiffness rises as distance falls: 150
for a drawer crossing the screen, 520 for a row taking its slot, 700 for a caret
rotating, 900 for a tooltip already on screen.

## Physics beats taste

Springs are for things that move because a person intended them to. Something
that models a physical process obeys that process instead.

A ripple is a wave leaving the point of contact, and a wave travels at constant
speed, so it expands **linearly**. Easing it makes it read as a growing shape
rather than a spreading wave.

The ripple, fully specified, because it is worth getting right once:

```
radius     distance from the contact point to the furthest corner of the box
shape      a real circle. A scaled rounded rect grows its own radius and
           turns into a blob
expansion  0.5s linear from scale 0 at the contact point
opacity    in over 0.07s linear while it grows, out on release with EASE
tint       ink at 15% on light, white at 20% on dark
held       stays at full reach while held, fades on release
minimum    visible at least ~220ms, so a fast tap still produces a wave
```

The same reasoning produces every other linear timing: a spinner turns at one
rate because it is reporting an unknown, a marquee moves at one rate because it
is a belt, a countdown drains at one rate because seconds are one rate, and a
hold sweep fills at one rate because that is the promise the button made.

**Research before inventing.** A ripple, a spinner, a slider detent are solved,
published and measured. Invent the parts nobody has solved; look up the parts
everyone has.

## Small moves, learned the hard way

- **Scaling type blurs it.** Transform-scaled text loses hinting and is visibly
  soft below about 0.9. If a label must shrink as it moves, 0.92 is the floor.
  Better: move it and leave the size alone.
- **When something leaves its container it must land on a line that already
  exists.** A label floating out of a field aligns to the field's outer edge,
  not its inner text padding, or the page grows a third vertical axis that
  agrees with nothing.
- **Reserve the destination up front.** The space a floated label will occupy is
  padding on the wrapper from the start, so nothing below ever moves.

## Quantisation is a render budget

Every gesture that reports progress reports it in discrete steps, chosen so the
steps are big enough to see and few enough to be cheap.

```
long press        12 steps over 550ms
hold to confirm   20 steps over 1800ms
reading progress  24 steps
pinch zoom         8 steps
swipe commitment   6 steps
```

The identity check is the whole saving:

```js
setStep(prev => (prev === s ? prev : s));
```

The animation frame loop runs at 60fps; the component renders `steps` times.
Leaving this out is how a hold-to-confirm costs 108 renders.

Where a component runs both at once (discrete cells over a continuous sweep),
the cells carry the information and the sweep is the material. Quantising the
sweep makes the fill stutter; not quantising the cells costs thirty renders to
say the same thing.

## Discrete cells beat continuous bars

If a quantity can be split into units, draw the units. A hold you can abandon, a
countdown you can watch run out, a set of items. Cells are honest about
countability in a way a bar is not.

The exception is important: **a wait whose duration is unknown gets a spinner.**
It is circular, it loops, and it is honest. A meter filling against a guessed
duration claims progress it cannot know, which is worse than looking generic.

If a cell needs variation, use a deterministic hash of its index, never a random
value, or server and client markup will disagree.

```js
const h = (((i + 1) * 2654435761) % 997) / 997;   // Knuth
```

## Stagger

Stagger reveals structure, but a stagger that scales with the data eventually
becomes a wait. Cap it.

```
page blocks     header 0, preview 0.07, body 0.14, each 0.34s
small sets      i * 0.03, no cap needed under about six items
long sets       min(stagger, span / (n - 1)) so the total never exceeds a
                maximum duration (~1.6s)
```

A hundred-item reveal should take the same time as a ten-item one.

## Velocity is handed over, never dropped

A gesture that ends and then starts an animation from zero velocity is the most
common way to make a drag feel cheap. Pass the release velocity into the spring
that takes over.

Thresholds are the other half: a flick should commit even when the finger never
travelled far. Two conditions, distance or speed.

```
drawer      offset > width * 0.38   or   speed > 520
carousel    projected = at - (v * 0.14) / step, capped at one slide
swipe card  |dx| >= 92              or   |v| >= 520 and |dx| >= 32
toast       |dx| > 72               or   |v| > 460 and |dx| > 20
```

Cap the projection at one unit. Momentum decides **whether** you move, not how
far. A hard flick that skips four slides is a bug the user reads as loss of
control.
