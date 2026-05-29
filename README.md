# ai-lorebook

Personal AI coding rules for Cursor and GitHub Copilot. Use `apply.sh` to copy them into a project.

## Usage

```bash
apply.sh [OPTIONS]
```

| Option                 | Description                                                               |
| ---------------------- | ------------------------------------------------------------------------- |
| `-d, --target-dir DIR` | Target project directory (default: current dir)                           |
| `--cursor`             | Copy only Cursor rules (`.cursor/rules/*.mdc`)                            |
| `--copilot`            | Copy only Copilot instructions (`.github/instructions/*.instructions.md`) |
| `--claude`             | Copy only Claude rules (`.claude/rules/*.md`)                             |
| `--all`                | Copy all (default)                                                        |
| `-n, --dry-run`        | Show what would be done without copying                                   |
| `-f, --force`          | Overwrite existing files without confirmation                             |
| `-h, --help`           | Show help message                                                         |

Examples:

```bash
/path/to/ai-lorebook/apply.sh                              # copy both to current dir
/path/to/ai-lorebook/apply.sh -d /path/to/project          # copy both to target
/path/to/ai-lorebook/apply.sh -d /path/to/project --cursor # cursor only
/path/to/ai-lorebook/apply.sh -d /path/to/project --copilot # copilot only
/path/to/ai-lorebook/apply.sh -d /path/to/project --claude  # claude only
/path/to/ai-lorebook/apply.sh -n                           # dry-run
```

Cursor rules go to `<target>/.cursor/rules/`, Copilot instructions to `<target>/.github/instructions/`, Claude rules to `<target>/.claude/rules/`. Existing files with the same name are overwritten; others are kept.

## Included rules

| Rule                              | Cursor (`.mdc`) | Copilot (`.instructions.md`) | Claude (`.md`) |
| --------------------------------- | :-------------: | :--------------------------: | :------------: |
| English code generation           |        ✓        |              ✓               |       ✓        |
| Python environment (uv/venv)      |        ✓        |              ✓               |       ✓        |
| Python quality checks (ruff + ty) |        ✓        |              ✓               |       ✓        |
| Typst math spacing                |        ✓        |              ✓               |       ✓        |
| Typst syntax                      |        ✓        |              ✓               |       ✓        |
