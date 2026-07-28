# frilo-os

Design system skills for agents. Encodes how I design so any agent, in any editor, ships work that looks like mine on the first pass instead of the fifth.

Based on 10+ years of brand and product work for crypto, AI, and fintech clients. One source of truth, zero hardcoded values, every project starts with a brief.

## Install

```bash
# everything
npx skills add frilo-eth/frilo-os --all

# or pick
npx skills add frilo-eth/frilo-os --skill frilo-design-system --skill ui-components
```

Works with Claude Code, Cursor, Codex, and everything else the skills CLI supports.

## Skills

- **frilo-design-system** — The source of truth. Tokens, brand files, component inventory, layout and motion patterns. Everything else depends on it.
- **adopt** — Retrofit an existing project: audit design values in the wild, reverse-engineer a brand file, drift report, migration plans. Run once on any codebase that predates the system.
- **project-brief** — Entry point. Generates the BRIEF.md that tells every other skill which brand, platform, and constraints apply. No brief, no build.
- **design-foundations** — Wires tokens into code: CSS variables, Tailwind themes, RN theme files. Semantic names only.
- **ui-components** — Builds components from the inventory spec: variants, sizes, all six interaction states, spacing law.
- **animation** — Motion from tokens. Two profiles (restrained, expressive), transform+opacity only, reduced-motion always.
- **mobile-experience** — Thumb zones, bottom sheets, safe areas, 44px targets, no hover-dependent anything.
- **desktop-webapp** — App shells, data tables, command palettes, keyboard-first, five content states per view.


## The stack (external skills, not reinvented)

frilo-os composes with skills by people who already solved their domain. `setup.sh` installs everything in one shot:

- **emilkowalski/skills** — animation craft: emil-design-eng, review-animations, improve-animations, find-animation-opportunities, animation-vocabulary, apple-design. The frilo `animation` skill is a bridge: his rules, my token values.
- **jakubkrehel/skills** — better-ui, better-typography, better-colors (OKLCH), better-accessibility, better-layout, better-writing, better-interface (coordinator). Hierarchy rule: his skills generate and judge (build a palette in OKLCH, audit type, review a11y); once values land in a brand file or TOKENS.json, frilo tokens are authoritative and his skills polish around them, never override them.
- **transitions.dev** (Jakub Antalik) — nine proven CSS transition patterns. Not a skills repo, so it's wrapped by the local `transition-patterns` skill: fetch snippet, remap variables to frilo tokens, keep the reduced-motion guard.
- **shadcn/improve** — audit a codebase with your most capable model, hand execution plans to cheaper ones.

They stay in their authors' repos so updates flow automatically. Don't vendor them.

## How it fits together

```
BRIEF.md ──selects──> brands/{client}.json
                            │
frilo-design-system ──────┤  TOKENS.json / COMPONENTS.md / PATTERNS.md
                            │
   every other skill ───────┘  reads, never redefines
```

New client = one new JSON file in `frilo-design-system/brands/`. That's the whole onboarding.

## Rules the system enforces

1. No raw values downstream. A hex code in a component is a bug.
2. Undocumented components don't exist. Spec in COMPONENTS.md first, build second.
3. The brief is law. Skills refuse to run without one and will generate it first.
