# ai-lorebook

Personal AI coding rules for Cursor and GitHub Copilot. Use `apply.sh` to copy them into a project.

## Usage

```bash
apply.sh [target-dir] [cursor|copilot|all]
```

| Argument     | Default | Description                  |
| ------------ | ------- | ---------------------------- |
| `target-dir` | `$PWD`  | Target project directory     |
| mode         | `all`   | `cursor` / `copilot` / `all` |

Examples:

```bash
/path/to/ai-lorebook/apply.sh                      # copy both to current dir
/path/to/ai-lorebook/apply.sh /path/to/project      # copy both
/path/to/ai-lorebook/apply.sh /path/to/project cursor  # cursor only
/path/to/ai-lorebook/apply.sh /path/to/project copilot # copilot only
```

Cursor rules go to `<target>/.cursor/rules/`, Copilot instructions to `<target>/.github/instructions/`. Existing files with the same name are overwritten; others are kept.

## Included rules

| Rule                              | Cursor (`.mdc`) | Copilot (`.instructions.md`) |
| --------------------------------- | :-------------: | :--------------------------: |
| English code generation           |        ✓        |              ✓               |
| Python environment (uv/venv)      |        ✓        |              ✓               |
| Python quality checks (ruff + ty) |        ✓        |              ✓               |
| Typst math spacing                |        ✓        |              ✓               |
| Typst syntax                      |        ✓        |              ✓               |
