# ai-lorebook

Personal AI coding rules for Cursor and GitHub Copilot. Use `apply.sh` to copy them into a project.

## Usage

```bash
apply.sh [OPTIONS]
```

| Option                 | Description                                     |
| ---------------------- | ----------------------------------------------- |
| `-d, --target-dir DIR` | Target project directory (default: current dir) |
| `--cursor`             | Copy only `.cursor/` (rules, skills, etc.)      |
| `--copilot`            | Copy only `.github/instructions/`               |
| `--claude`             | Copy only `.claude/rules/`                      |
| `--all`                | Copy all (default)                              |
| `-n, --dry-run`        | Show what would be done without copying         |
| `-f, --force`          | Overwrite existing files without confirmation   |
| `-h, --help`           | Show help message                               |

Examples:

```bash
/path/to/ai-lorebook/apply.sh                              # copy all to current dir
/path/to/ai-lorebook/apply.sh -d /path/to/project          # copy all to target
/path/to/ai-lorebook/apply.sh -d /path/to/project --cursor # cursor only
/path/to/ai-lorebook/apply.sh -d /path/to/project --copilot # copilot only
/path/to/ai-lorebook/apply.sh -d /path/to/project --claude  # claude only
/path/to/ai-lorebook/apply.sh -n                           # dry-run
```

`--cursor` copies the full `.cursor/` tree (including `.cursor/rules/` and `.cursor/skills/`). Copilot instructions go to `<target>/.github/instructions/`, Claude rules to `<target>/.claude/rules/`. Identical files are skipped; differing files require `-f` to overwrite.

Python Ruff + ty defaults live under `.cursor/skills/python-ruff-ty/` (`ruff.toml`, `ty.toml`); the skill copies them to the project root at lint time when missing.

## Included rules

| Rule                              | Cursor (`.mdc`) | Copilot (`.instructions.md`) | Claude (`.md`) |
| --------------------------------- | :-------------: | :--------------------------: | :------------: |
| English code generation           |        ✓        |              ✓               |       ✓        |
| Python environment (uv/venv)      |        ✓        |              ✓               |       ✓        |
| Python quality checks (ruff + ty) |        ✓        |              ✓               |       ✓        |
| Typst math spacing                |        ✓        |              ✓               |       ✓        |
| Typst syntax                      |        ✓        |              ✓               |       ✓        |
