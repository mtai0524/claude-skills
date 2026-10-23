---
name: commit-push
description: Commit the current changes and push the current branch. Use only when the user types /commit-push or explicitly asks to commit and push.
---

# Commit and push

1. Read `git status` and `git diff` (staged and unstaged) to see what changed.
2. On the default branch (`main`/`master`), stop and ask before committing.
3. Leave out files that do not belong to the work (temp files, secrets such as `.env` or credentials); if it is unclear which change a file belongs to, ask.
4. Write the message with the `commit-message` skill. Independent changes get separate commits; `git add` only the files of each one.
5. `git push` the current branch (`git push -u origin <branch>` the first time). Never force push.
6. Report briefly: each commit (hash + message) and the push result.

Extra notes from the user: $ARGUMENTS
