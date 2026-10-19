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
- Non-trivial work (a new feature, a flow that spans several files or layers, a behavior or data-format change) starts with a spec `YYYY-MM-DD-<topic>-design.md` (intent, goals, rules, edge cases, open questions), then a plan `YYYY-MM-DD-<topic>.md` (tasks with file paths and checkboxes), executed with superpowers subagent-driven-development (one subagent per task, review between tasks).
- Every new spec and plan belongs to exactly one module, and it must be obvious which:
  - Path: `docs/<module>/specs/` and `docs/<module>/plans/`, where `<module>` is the business module's doc folder (for example `docs/qc-pro/module4-do-luong-san-pham-moi/`, `docs/daocu/`, `docs/production/`). Create the module folder if it does not exist yet, named after the module, lowercase kebab-case.
  - First lines of the file: the title, then `**Module:** <module name>` (e.g. `**Module:** QC Pro · Module 4 — Đo lường sản phẩm mới`) and links to the module's requirements/mock if there are any.
  - If it is unclear which module the work belongs to, ask before writing the spec.
- Never put new specs or plans in a shared catch-all folder (such as `docs/superpowers/`). Existing docs stay where they are: do not move or rename them unless asked. This overrides the superpowers default location.
- A module folder has a `README.md` that lists its files (requirements, mock, specs, plans); add new specs and plans to it. If the solution file lists doc files (e.g. `.slnx` solution items), add them under that module's solution folder (e.g. `docs/<Module>/specs/`), creating it if needed. Only add entries: do not regroup, move or reorder existing solution items.
- Small fixes and one-file changes skip spec and plan.
- When code changes a documented rule, update the spec in the same change instead of explaining it in a comment.
