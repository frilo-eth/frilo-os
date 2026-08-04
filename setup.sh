#!/usr/bin/env bash
# frilo-os full stack. Idempotent: rerun any time to update everything.
set -e

npx -y skills@latest add frilo-eth/frilo-os --all -y
npx -y skills@latest add emilkowalski/skills --all -y
npx -y skills@latest add jakubkrehel/skills --all -y
npx -y skills@latest add Jakubantalik/transitions.dev -y
npx -y skills@latest add index-how/vocabulary -y
npx -y skills@latest add shadcn/improve -y

echo "Stack installed. Run 'npx skills list' to verify."
