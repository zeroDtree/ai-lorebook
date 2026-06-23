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

## Included skills

Cursor skills live under `.cursor/skills/`. Invoke with `/skill-name` (e.g. `/python-ruff-ty`, `/security-review`); skills with `disable-model-invocation: true` load only when explicitly selected.

| Skill | Purpose | Notes |
| ----- | ------- | ----- |
| `python-ruff-ty` | Run Ruff lint/format and ty type checks via `uv`; bootstrap `ruff.toml` / `ty.toml` from skill defaults when missing | Use when finalizing Python changes or fixing lint/type errors |
| `security-review` | Full-repo or path-scoped security audit (dependencies, secrets, vuln categories, data-flow analysis) | Use **Agent mode** for dependency CLI audits (`npm audit`, `pip-audit`, etc.); invoke with `/security-review` or `/security-review src/auth/` |

Brief usage examples:

- **python-ruff-ty:** `/python-ruff-ty`
- **security-review:** `/security-review` or `/security-review src/auth/`

## Included rules

| Rule                              | Cursor (`.mdc`) | Copilot (`.instructions.md`) | Claude (`.md`) |
| --------------------------------- | :-------------: | :--------------------------: | :------------: |
| English code generation           |        ✓        |              ✓               |       ✓        |
| Python environment (uv/venv)      |        ✓        |              ✓               |       ✓        |
| Python quality checks (ruff + ty) |        ✓        |              ✓               |       ✓        |
| Typst math spacing                |        ✓        |              ✓               |       ✓        |
| Typst syntax                      |        ✓        |              ✓               |       ✓        |
