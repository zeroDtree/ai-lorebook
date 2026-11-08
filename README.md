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
