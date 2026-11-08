#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Usage ──────────────────────────────────────────────────────────────────────

usage() {
  cat >&2 <<EOF
Usage: $(basename "$0") [OPTIONS]

Copy .cursor/ rules and skills into a target project.

Options:
  -h, --help        Show this help message and exit
  -n, --dry-run     Show what would be done without actually copying
  -f, --force       Skip confirmation when overwriting existing files
  -d, --target-dir DIR
                    Target project directory (default: current directory)

Examples:
  $(basename "$0")                     # copy to current dir
  $(basename "$0") -d /path/to/project # copy to target
  $(basename "$0") -n                  # dry-run to current dir
EOF
  exit 1
}

# ── Parse arguments ────────────────────────────────────────────────────────────

DRY_RUN=false
FORCE=false
TARGET_DIR="$PWD"

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      ;;
    -n|--dry-run)
      DRY_RUN=true
      shift
      ;;
    -f|--force)
      FORCE=true
      shift
      ;;
    -d|--target-dir)
      if [[ -z "${2:-}" ]]; then
        echo "error: --target-dir requires a directory argument" >&2
        exit 1
      fi
      TARGET_DIR="$2"
      shift 2
      ;;
    -*)
      echo "error: unknown option '$1'" >&2
      usage
      ;;
    *)
      echo "error: unexpected argument '$1'" >&2
      usage
      ;;
  esac
done

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "error: target directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

# Resolve TARGET_DIR to absolute path
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

# ── Helper functions ───────────────────────────────────────────────────────────

# Print a styled header
header() {
  echo "==> $*"
}

# Recursively copy a source directory tree to a target directory
apply_dir() {
  local src_rel="$1"
  local dest_rel="$2"
  local label="$3"
  local src="$SCRIPT_DIR/$src_rel"
  local dest="$TARGET_DIR/$dest_rel"

  if [[ ! -d "$src" ]]; then
    echo "warning: ${label} source directory not found: $src" >&2
    return 1
  fi

  local files=()
  while IFS= read -r -d '' file; do
    files+=("$file")
  done < <(find "$src" -type f -print0)

  if (( ${#files[@]} == 0 )); then
    echo "warning: no files found in $src" >&2
    return 1
  fi

  header "${label}"

  if $DRY_RUN; then
    echo "  (dry-run) would create: $dest"
    local f rel
    for f in "${files[@]}"; do
      rel="${f#"$src"/}"
      echo "  (dry-run) would copy: $rel -> $dest/$rel"
    done
    return 0
  fi

  local copied=0 skipped=0
  local f rel target_file target_dir
  for f in "${files[@]}"; do
    rel="${f#"$src"/}"
    target_file="$dest/$rel"
    target_dir="$(dirname "$target_file")"
    mkdir -p "$target_dir"

    if [[ -f "$target_file" && "$FORCE" != true ]]; then
      if cmp -s "$f" "$target_file"; then
        echo "  skip (identical): $rel"
        ((skipped++)) || true
        continue
      fi
      echo "  skip (differs, use -f to overwrite): $rel"
      ((skipped++)) || true
      continue
    fi

    cp "$f" "$target_file"
    echo "  copied: $rel -> $dest/$rel"
    ((copied++)) || true
  done

  local total=$((copied + skipped))
  echo "  summary: $copied copied, $skipped skipped ($total total)"
}

# ── Main ───────────────────────────────────────────────────────────────────────

header "ai-lorebook → $TARGET_DIR"
if $DRY_RUN; then
  echo "(dry-run mode — no files will be modified)"
fi
echo ""

apply_dir ".cursor" ".cursor" "Cursor"

echo ""
header "Done"
