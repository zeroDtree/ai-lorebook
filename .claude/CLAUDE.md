## chat-math

# Chat Math Output

This rule governs math in replies to the user. It does not govern source files whose language uses dollar math, such as Typst, which keeps `$...$` syntax.

In chat, use LaTeX delimiters the chat renderer supports:

- Inline: `\(...\)`
- Display: `\[...\]`

Do not use `$...$` or `$$...$$` in chat. Single-dollar math is shown as raw source.

Write LaTeX, not Typst, inside those delimiters: `\mathbf{z}`, `\mathcal{L}`, `\frac{a}{b}`. Do not wrap math in backticks.

```markdown
<!-- ❌ BAD — dollar delimiters render as source -->
下一词元是 $z_i^{t+\Delta t}$。

$$
\mathcal{L} = -\sum_i \log q_i
$$

<!-- ✅ GOOD -->
下一词元是 \(z_i^{t+\Delta t}\)。

\[
\mathcal{L} = -\sum_i \log q_i
\]
```

Put each formula in its own delimiter pair. Keep a display formula on its own lines, with a blank line before and after the block.

## english-code-generate

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

## english

# English Documentation and Naming Policy

## Core Rule
- Use English names for code identifiers, file names, folders, and new documents.
- Write new code, comments, docstrings, and developer-facing text in English.
- Write new documentation content in English.

## Existing Chinese Documentation
- Do not translate existing Chinese documents unless the user explicitly requests translation.
- When editing an existing document that contains Chinese, any newly added sections or lines must be in English.

