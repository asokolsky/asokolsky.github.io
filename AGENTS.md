# Agent Notes

These instructions apply to the whole repository.

## Project Shape

This is a GitHub Pages/Jekyll site made mostly of Markdown notes and posts.
Markdown files may include Jekyll frontmatter, Liquid includes, raw HTML, pasted
command output, and pipe tables.

## Formatting And Hooks

- Run `mise format` after Markdown edits.
- Run `mise pre-commit-run` before finishing changes that affect Markdown,
  formatter config, hook config, or generated formatting.
- The formatter is `mdformat` with `gfm` and `frontmatter` enabled through
  `.mdformat.toml`.
- Keep YAML frontmatter fenced with `---`. If frontmatter becomes a horizontal
  rule plus a heading, fix the formatter config or the file syntax before
  continuing.
- Avoid adding mdformat excludes unless a file truly cannot be made stable.

## Markdown Conventions

- Do not use `&nbsp;` as a table placeholder. Use `.` for section-marker cells
  in tables.
- Escape literal pipe characters inside table cells as `\|`, or rewrite the
  cell text so it does not contain raw pipes.
- Avoid empty headings such as `##`; they can create loops between `mdformat`
  and trailing-whitespace cleanup.
- Let mdformat normalize list markers and table alignment.

## Git Hygiene

- The worktree may already contain user edits. Do not revert unrelated changes.
- Keep changes focused on the requested files and the supporting formatter or
  hook configuration needed to make checks pass.
