---
name: commit-message
description: Write git commit messages in Conventional Commits format. Use whenever creating a commit or when the user asks for a commit message.
---

# Commit message

Format: `<type>(<optional scope>): <summary>`

- Types: `feat`, `fix`, `refactor`, `perf`, `test`, `docs`, `style`, `chore`, `build`, `ci`.
- Summary: English, imperative mood ("add", not "added"), lowercase, no trailing period, max 72 chars.
- Body (optional): blank line after the summary, explain *why*, wrap at 72 chars.
- Breaking change: add `!` after the type and a `BREAKING CHANGE:` footer.
- One logical change per commit. Stage only the files that belong to it; never `git add -A` blindly.

Rules:
- Never add `Co-Authored-By` or "Generated with" lines.
- Commit only. Never `git push`.
