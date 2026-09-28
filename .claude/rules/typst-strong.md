---
alwaysApply: false
globs:
  - '**/*.typ'
description: Typst strong (bold) emphasis syntax for .typ files
---

# Typst Strong (Bold) Emphasis

Use `strong` to increase font weight. Typst provides shorthand and function forms.

## Shorthand (word boundaries only)

Wrap whole words in asterisks `*...*`. This only works at word boundaries.

```typst
// ✅ GOOD — whole words
This is *strong.*
And this is *evermore.*

// ❌ BAD — partial word; asterisk shorthand does not apply
This is str*ong.*
```

## Function form (any span)

Use `#strong[...]` when emphasizing part of a word or when you need a custom weight delta.

```typst
// ✅ GOOD — partial word or arbitrary span
This is #strong[too.]
This is str#strong[ong] emphasis

// Optional delta (default: 300)
#strong(delta: 500)[heavier text]
```

## Styling

`strong` is a normal element and can be themed:

```typst
#show strong: set text(red)
And this is *evermore.*
```

## Quick reference

| Need | Syntax |
|------|--------|
| Bold whole words | `*word*` |
| Bold part of a word | `#strong[part]` |
| Custom weight | `#strong(delta: 500)[text]` |