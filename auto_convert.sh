#!/usr/bin/env bash
# Regenerate Claude Code and GitHub Copilot rules from .cursor/rules.
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

shopt -s nullglob

rm -f .claude/rules/*.md .claude/rules/*_converted.md
rm -f CLAUDE.md .claude/CLAUDE.md
rm -f .github/instructions/*.instructions.md .github/instructions/*_converted.md
rm -f .github/copilot-instructions.md .github/copilot-instructions_converted.md

npx --yes ai-rules-converter migrate --from cursor --to claude-code
if [[ -f CLAUDE.md ]]; then
  mv CLAUDE.md .claude/CLAUDE.md
fi
npx --yes ai-rules-converter migrate --from cursor --to copilot

copilot_main=".github/copilot-instructions.md"
copilot_extra=".github/copilot-instructions_converted.md"
if [[ -f "$copilot_extra" ]]; then
  if [[ -f "$copilot_main" ]]; then
    printf '\n' >>"$copilot_main"
    cat "$copilot_extra" >>"$copilot_main"
    rm -f "$copilot_extra"
  else
    mv "$copilot_extra" "$copilot_main"
  fi
fi
