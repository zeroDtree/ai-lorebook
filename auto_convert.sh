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

# ai-rules-converter sends every always-apply rule to
# .github/copilot-instructions.md. The second rule is written to
# copilot-instructions_converted.md, and each later rule overwrites
# that file, so only the first and last rules survive. Rebuild the
# global file from the Cursor sources instead.
copilot_main=".github/copilot-instructions.md"
rm -f "$copilot_main" .github/copilot-instructions_converted.md
copilot_started=0
for rule in .cursor/rules/*.mdc; do
  grep -Eq '^alwaysApply:[[:space:]]*true[[:space:]]*$' "$rule" || continue
  if [[ "$copilot_started" -eq 1 ]]; then
    printf '\n' >>"$copilot_main"
  fi
  copilot_started=1
  awk '
    BEGIN { state = 0 }
    state == 0 && /^---[[:space:]]*$/ { state = 1; next }
    state == 1 && /^---[[:space:]]*$/ { state = 2; next }
    state == 2 { lines[++n] = $0 }
    END {
      start = 1
      end = n + 0
      while (start <= end && lines[start] ~ /^[[:space:]]*$/) start++
      while (end >= start && lines[end] ~ /^[[:space:]]*$/) end--
      for (i = start; i <= end; i++) print lines[i]
    }
  ' "$rule" >>"$copilot_main"
done
