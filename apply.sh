#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Usage ──────────────────────────────────────────────────────────────────────

usage() {
  cat >&2 <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  -h, --help        Show this help message and exit
  -n, --dry-run     Show what would be done without actually copying
  -f, --force       Skip confirmation when overwriting existing files
  -d, --target-dir DIR
                    Target project directory (default: current directory)
  --cursor          Copy only Cursor rules (.cursor/rules/*.mdc)
  --copilot         Copy only Copilot instructions (.github/instructions/*.instructions.md)
  --claude          Copy only Claude rules (.claude/rules/*.md)
  --all             Copy all (default)

Examples:
  $(basename "$0")                              # copy both to current dir
  $(basename "$0") -d /path/to/project          # copy both to target
  $(basename "$0") -d /path/to/project --cursor # cursor rules only
  $(basename "$0") -d /path/to/project --copilot # copilot instructions only
  $(basename "$0") -d /path/to/project --claude  # claude rules only
  $(basename "$0") -n                           # dry-run to current dir
EOF
  exit 1
}

# ── Parse arguments ────────────────────────────────────────────────────────────

DRY_RUN=false
FORCE=false
TARGET_DIR="$PWD"
MODE="all"

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
    --cursor)
      MODE="cursor"
      shift
      ;;
    --copilot)
      MODE="copilot"
      shift
      ;;
    --claude)
      MODE="claude"
      shift
      ;;
    --all)
      MODE="all"
      shift
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

# Apply rules from a source directory to a target directory
apply_rules() {
  local src="$SCRIPT_DIR/$1"
  local dest="$TARGET_DIR/$2"
  local pattern="$3"
  local label="$4"

  if [[ ! -d "$src" ]]; then
    echo "warning: ${label} source directory not found: $src" >&2
    return 1
  fi

  local files=("$src"/$pattern)

  if (( ${#files[@]} == 0 )); then
    echo "warning: no $pattern files found in $src" >&2
    return 1
  fi

  header "${label}"

  if $DRY_RUN; then
    echo "  (dry-run) would create: $dest"
    for f in "${files[@]}"; do
      echo "  (dry-run) would copy: $(basename "$f") -> $dest/"
    done
    return 0
  fi

  mkdir -p "$dest"

  local copied=0 skipped=0
  for f in "${files[@]}"; do
    local bname
    bname="$(basename "$f")"
    local target_file="$dest/$bname"

    # Check if target exists and we're not forcing
    if [[ -f "$target_file" && "$FORCE" != true ]]; then
      # Compare content — skip if identical
      if cmp -s "$f" "$target_file"; then
        echo "  skip (identical): $bname"
        ((skipped++)) || true
        continue
      fi
      echo "  skip (differs, use -f to overwrite): $bname"
      ((skipped++)) || true
      continue
    fi

    cp "$f" "$dest/"
    echo "  copied: $bname -> $dest/"
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

if [[ "$MODE" == "all" || "$MODE" == "cursor" ]]; then
  apply_rules ".cursor/rules" ".cursor/rules" "*.mdc" "Cursor rules"
fi

if [[ "$MODE" == "all" || "$MODE" == "copilot" ]]; then
  apply_rules ".github/instructions" ".github/instructions" "*.instructions.md" "Copilot instructions"
fi

if [[ "$MODE" == "all" || "$MODE" == "claude" ]]; then
  apply_rules ".claude/rules" ".claude/rules" "*.md" "Claude rules"
fi

echo ""
header "Done"
