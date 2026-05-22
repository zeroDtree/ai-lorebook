# cursor-rule

Personal Cursor rules. Use `apply.sh` to copy them into a project's `.cursor/rules/` directory.

## Usage

In the target project directory:

```bash
/path/to/cursor-rule/apply.sh
```

Or specify a target directory:

```bash
/path/to/cursor-rule/apply.sh /path/to/your-project
```

Rules are copied to `<target>/.cursor/rules/`. Existing files with the same name are overwritten; other rules in the target are kept.

## Included rules

- `english-code-generate.mdc` — generate code and comments in English
- `python-env.mdc` — run Python via `uv run` or `.venv`
- `python-quality-checks.mdc` — run `ruff check` and `ty check` before finishing Python changes
