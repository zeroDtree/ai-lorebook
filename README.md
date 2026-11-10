# ai-lorebook

Personal AI coding rules and skills for Cursor.

## Usage

```bash
./apply.sh [-d DIR] [-n] [-f]
```

Copies `.cursor/` (rules and skills) into the target project.

| Option                 | Description                                     |
| ---------------------- | ----------------------------------------------- |
| `-d, --target-dir DIR` | Target project directory (default: current dir) |
| `-n, --dry-run`        | Show what would be done without copying         |
| `-f, --force`          | Overwrite existing files without confirmation   |
| `-h, --help`           | Show help message                               |

Identical files are skipped; differing files require `-f` to overwrite.

## Skills

| Skill             | Invoke                    | Purpose                                                                                             |
| ----------------- | ------------------------- | --------------------------------------------------------------------------------------------------- |
| `python-ruff-ty`  | `/python-ruff-ty`         | Run Ruff lint/format and `ty` type checks via `uv` (bootstraps `ruff.toml` / `ty.toml` if missing). |
| `security-review` | `/security-review [path]` | Repo or path-scoped security audit (use Agent mode for CLI dependency audits).                      |


## Rules

| Rule                    | Applies                  | Purpose                                                          |
| ----------------------- | ------------------------ | ---------------------------------------------------------------- |
| `chat-math`             | always                   | Render chat math with `\(...\)` and `\[...\]`.                   |
| `english`               | always                   | Use English for new names, code, and documentation.              |
| `english-code-generate` | always                   | Write generated code, comments, and docstrings in English.       |
| `notation-conventions`  | `*.typ`, `*.tex`, `*.md` | Follow project math, logic, and computer notation.               |
| `python-env`            | `*.py`                   | Run Python with `uv run` or an activated `.venv`.                |
| `python-quality-checks` | `*.py`                   | Run `uv run ruff check` and `uv run ty check` before finishing.  |
| `shell-script-help`     | `*.sh`                   | Put help text in `@help-begin` and `@help-options-begin` blocks. |
| `typst-math-spacing`    | `*.typ`                  | Apply project spacing and notation in Typst math.                |
| `typst-strong`          | `*.typ`                  | Use Typst `*...*` or `#strong[...]` for bold emphasis.           |
| `typst-syntax`          | `*.typ`                  | Keep Typst inline code and math unnested.                        |
| `wo-AI-phrasing`        | always                   | Write expository and technical prose without stock AI phrasing.  |
