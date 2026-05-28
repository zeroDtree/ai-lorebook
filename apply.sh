#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") [target-dir] [cursor|copilot|all]"
  echo
  echo "  target-dir   Target project directory (default: current directory)"
  echo "  cursor       Copy only Cursor rules (.cursor/rules/*.mdc)"
  echo "  copilot      Copy only Copilot instructions (.github/instructions/*.instructions.md)"
  echo "  all          Copy both (default)"
  exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-$PWD}"
MODE="${2:-all}"

if [[ ! "$MODE" =~ ^(cursor|copilot|all)$ ]]; then
  echo "error: invalid mode '$MODE'. Expected: cursor, copilot, or all" >&2
  usage
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "error: target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

# ── Cursor rules (.cursor/rules/*.mdc) ──────────────────────────────────────

apply_cursor() {
  local src="$SCRIPT_DIR/.cursor/rules"
  local dest="$TARGET_DIR/.cursor/rules"

  if [[ ! -d "$src" ]]; then
    echo "warning: cursor rules directory not found at $src" >&2
    return
  fi

  shopt -s nullglob
  local files=("$src"/*.mdc)
  shopt -u nullglob

  if (( ${#files[@]} == 0 )); then
    echo "warning: no .mdc rule files found in $src" >&2
    return
  fi

  mkdir -p "$dest"
  for f in "${files[@]}"; do
    cp "$f" "$dest/"
    echo "copied $(basename "$f") -> $dest/"
  done
  echo "Applied ${#files[@]} cursor rule(s) to $dest"
}

# ── Copilot instructions (.github/instructions/*.instructions.md) ──────────

apply_copilot() {
  local src="$SCRIPT_DIR/.github/instructions"
  local dest="$TARGET_DIR/.github/instructions"

  if [[ ! -d "$src" ]]; then
    echo "warning: copilot instructions directory not found at $src" >&2
    return
  fi

  shopt -s nullglob
  local files=("$src"/*.instructions.md)
  shopt -u nullglob

  if (( ${#files[@]} == 0 )); then
    echo "warning: no .instructions.md files found in $src" >&2
    return
  fi

  mkdir -p "$dest"
  for f in "${files[@]}"; do
    cp "$f" "$dest/"
    echo "copied $(basename "$f") -> $dest/"
  done
  echo "Applied ${#files[@]} copilot instruction(s) to $dest"
}

case "$MODE" in
  cursor)  apply_cursor ;;
  copilot) apply_copilot ;;
  all)     apply_cursor; apply_copilot ;;
esac
