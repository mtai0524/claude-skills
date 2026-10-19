---
description: Keep code comments minimal; put design, decisions and plans in docs instead
---

# Comments and docs

Code comments:
- Default to no comment. Write one only for a "why" the code cannot show (a business rule, a non-obvious constraint, a workaround), in one line.
- Never comment what the code does, the history of a change ("used to…", "fixed…"), who asked for it, or a summary of the task. That belongs in the commit message.
- No multi-line comment blocks explaining a feature, no section banners, no XML doc on private members.
- When editing a file, do not add comments to code you did not change.

Design and plans go to docs, not code:
- Non-trivial work (a new feature, a flow that spans several files or layers, a behavior or data-format change) starts with a spec: `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md` (intent, goals, rules, edge cases, open questions).
- Then a plan: `docs/superpowers/plans/YYYY-MM-DD-<topic>.md` (tasks with file paths and checkboxes), executed with superpowers subagent-driven-development (one subagent per task, review between tasks).
- Small fixes and one-file changes skip spec and plan.
- When code changes a documented rule, update the spec in the same change instead of explaining it in a comment.
