---
name: transition-patterns
description: Ready-made CSS transition patterns from transitions.dev for common UI moments - card resize, number pop-in, notification badges, text swaps, dropdowns, modals, panels, page transitions, icon swaps. Use whenever implementing one of these nine interactions instead of writing the transition from scratch, or when the user mentions transitions.dev or asks for a proven transition pattern.
---

# Transition Patterns (transitions.dev bridge)

Catalog of nine proven CSS transitions by Jakub Antalik. Don't reinvent these; adapt them.

## When to reach for which

| Pattern | Use for |
|---|---|
| Card resize | Cards/containers changing size on state change |
| Number pop-in | Counters, prices, stats updating (digit flip, blur, stagger) |
| Notification badge | Badge appearing on an icon (diagonal slide, spring) |
| Text states swap | Label/status text changing in place (blur crossfade) |
| Menu dropdown | Origin-aware dropdown open/close |
| Modal open/close | Centered modal with scale |
| Panel reveal | Side/inline panel open/close |
| Page side-by-side | Forward/back navigation between views |
| Icon swap | Icon morphing to another (scale + blur) |

## Workflow

1. Fetch the snippet from https://transitions.dev/ (each card has a self-contained copy-ready CSS block). If offline, reconstruct from the pattern description using frilo motion tokens.
2. Remap its `:root` custom properties to frilo tokens: durations → `TOKENS.json` motion.duration, easings → motion.easing, colors → the brand file. The snippets are semantic-variable based, so this is a find-replace, not a rewrite.
3. Keep the `t-*` class namespacing and the `prefers-reduced-motion` guard. Both survive the remap untouched.
4. Run the result through Emil's rules (review-animations if installed): frequency check, sub-300ms, origin correctness still apply. A pattern being proven doesn't exempt it from the frequency rule; a number pop-in on a value that updates every second gets deleted, not styled.

## Conflict rule

Same as the animation skill: transitions.dev supplies the mechanism, frilo tokens supply the values, Emil's craft rules supply the veto.
