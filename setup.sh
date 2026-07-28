#!/usr/bin/env bash
# frilo-os full stack. Run once per machine (or per project without -g).
set -e

# Own skills
npx skills@latest add frilo-eth/frilo-os --all -y

# External: Emil Kowalski's design engineering skills (animations.dev)
npx skills@latest add emilkowalski/skills --all -y

# External: Jakub Krehel's interface skills (interfaces.dev)
npx skills@latest add jakubkrehel/skills --all -y

# External: shadcn/improve (audit with a capable model, execute with cheap ones)
npx skills@latest add shadcn/improve -y

# Note: transitions.dev (Jakub Antalik) is a snippet site, not a skills repo.
# It's wrapped by the local transition-patterns skill instead of installed.

echo "Stack installed. Run 'npx skills list' to verify."
