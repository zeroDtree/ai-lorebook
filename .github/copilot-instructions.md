# English Code Generation

## Scope
- Write all generated source code, identifiers, comments, docstrings, commit messages, and user-facing developer text in English.

## Requirements
- Prefer clear, simple English wording over idioms or slang.
- Keep naming consistent and meaningful in English.
- If non-English input is provided, preserve semantic intent but generate code output in English.

## Examples
```python
# ❌ BAD
def jisuan_zonghe(chengji):
    # 计算平均分
    return sum(chengji) / len(chengji)

# ✅ GOOD
def calculate_average(scores):
    # Calculate the average score.
    return sum(scores) / len(scores)
```

# English Documentation and Naming Policy

## Core Rule
- Use English names for code identifiers, file names, folders, and new documents.
- Write new code, comments, docstrings, and developer-facing text in English.
- Write new documentation content in English.

## Existing Chinese Documentation
- Do not translate existing Chinese documents unless the user explicitly requests translation.
- When editing an existing document that contains Chinese, any newly added sections or lines must be in English.
