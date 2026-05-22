#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/.cursor/rules"
TARGET_DIR="${1:-$PWD}"
DEST_DIR="$TARGET_DIR/.cursor/rules"

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "error: rules directory not found at $SOURCE_DIR" >&2
  exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "error: target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

shopt -s nullglob
rule_files=("$SOURCE_DIR"/*.mdc)
shopt -u nullglob

if (( ${#rule_files[@]} == 0 )); then
  echo "error: no .mdc rule files found in $SOURCE_DIR" >&2
  exit 1
fi

for rule_file in "${rule_files[@]}"; do
  cp "$rule_file" "$DEST_DIR/"
  echo "copied $(basename "$rule_file") -> $DEST_DIR/"
done

echo "Applied ${#rule_files[@]} cursor rule(s) to $DEST_DIR"
