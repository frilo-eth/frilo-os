# Specs

Every number in the rule set, collected. Defaults, not laws. Each one has a
reason attached, so it can be moved deliberately rather than guessed at.

## Timing

| Value | Rule | What it governs | Reason |
| --- | --- | --- | --- |
| 120 ms | 22 | Grace before a skeleton appears | Below this, the response usually arrives first and the skeleton reads as a flash |
| 380 ms | 22 | Minimum a skeleton stays once shown | Under this a skeleton reads as a glitch rather than as loading |
| 220 ms | 23 | Grace before an empty state | A list one frame from arriving should not say "nothing here" |
| 420 ms | 69 | Delay before announcing a settled change | Turns a burst of updates into one sentence |
| 400 ms | 58 | Settle window before committing an optimistic change | Collapses a flurry of interactions into one write |
| 1 frame | 50 | Maximum delay on a stop | Anything longer and the control is a request, not a command |
| 10 s | 19 | Point at which a run must be scoped | Beyond this, unbounded waiting drives abandonment |
| 150 to 300 ms | 67, 71 | Typical UI transition | Long enough to read, short enough not to gate the user |
| 1000 ms | 67 | Absolute ceiling on any transition | Past this the interface feels slow regardless of quality |

## Motion

| Value | Governs |
| --- | --- |
| 0.20 to 0.28 s | Entrance |
| 0.11 to 0.18 s | Exit. Always shorter than the matching entrance |
| `[0.23, 1, 0.32, 1]` | Arriving. Fast start, soft landing |
| `[0.4, 0, 1, 1]` | Leaving. Slow start, accelerates out |
| 0.9 to 0.97 | Scale floor. Nothing starts at 0 |
| 140 ms in, 200 ms out | The streaming dot (rule 25) |
| 45 ms | Stagger between arriving list items |
| ~1.6 s | Cap on total stagger span regardless of item count |

Spring selection by distance travelled: over 200px soft, 20 to 200px medium,
under 20px stiff. Reusing a soft spring on a small element reads as lag.

## Thresholds and counts

| Value | Rule | Governs |
| --- | --- | --- |
| 5 | 04 | Variables above which a prompt beats a form, below which a form beats a prompt |
| 1 | 07 | Clarifying questions before generating anyway |
| 2 | 12 | Uses after which a tuned setting must be savable |
| 3 | 52 | Outcomes offered after a stop: keep, discard, continue |
| 3 | 61 | Autonomy levels below full: propose, approve each, approve class |
| 44 x 44 pt | 70 | Minimum target for any control, regardless of visual size |

## Interruption and abandonment

Every gesture and every run listens for all of these, not only the happy ending:

```
normal completion
user stop
pointercancel and lostpointercapture
window blur
visibilitychange
Escape
timeout
tool or permission failure
partial completion
```

The last three are AI-specific and are the ones usually missing. Partial
completion at step 7 of 12 with no report is the worst available outcome,
because the user believes the work is done.

## Backoff

`min(8000, 700 * 2^(n-1))` milliseconds, drawn as a visible countdown, with the
retry control live during the wait. A backoff the user cannot see or interrupt
is indistinguishable from a hang.

## Where these came from

The interface timings are shipped values from the interior.dev design language.
The AI-specific thresholds are derived from the patterns in
`ai-interface-patterns` plus the HAX lifecycle. Neither set is empirical for
your product: treat them as good starting points and move them with evidence.
