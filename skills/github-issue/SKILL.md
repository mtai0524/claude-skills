---
name: github-issue
description: Open a GitHub issue for every problem that needs solving, and update it as a new version when the problem, plan or status changes. Use whenever you raise a bug, gap, risk, follow-up or open question that will not be fixed in the current change, when the user asks to log/track an issue, and when work touches a problem that already has an issue.
---

# GitHub issue

## Open an issue

1. Look for an existing one first: `gh issue list --state all --search "<keywords>"`. If it exists, update it (below) instead of opening a duplicate.
2. One problem per issue. Title: short and plain, Conventional Commit style: `fix(qc): shift tab loses the selected day after export`.
3. Body (`gh issue create --title "..." --body-file <file> --label <type>`):

   ```markdown
   **Version:** v1 · YYYY-MM-DD · <ref>

   ## Problem
   What is wrong or missing, where (`file:line`, page, route), how to reproduce.

   ## Expected
   What it should do.

   ## Proposal
   The fix or the options, with the recommended one first. Open questions as a list.

   ## Version history
   - v1 · YYYY-MM-DD · <ref> — opened
   ```

   `<ref>` = `git describe --tags --always` (last tag, or the short commit hash when there is no tag).
4. Labels: reuse existing ones (`gh label list`): `bug`, `enhancement`, `question`, `documentation`, plus the module label if there is one. Do not create labels.
5. Never put secrets, connection strings, customer personal data or full logs in an issue; quote only the relevant lines.
6. Reply with the issue number and URL.

## Update an issue (new version)

When the problem, the analysis, the plan or the status changes:

1. Bump the version: `v1` → `v2` …, with today's date and the current `<ref>`.
2. Edit the body (`gh issue edit <n> --body-file <file>`): rewrite Problem / Expected / Proposal so they show the current state, update the `**Version:**` line, and add one line to **Version history**: `- v2 · YYYY-MM-DD · <ref> — <what changed>`. Never delete older history lines.
3. Add a comment with the same headline so watchers get notified: `gh issue comment <n> --body "v2 · YYYY-MM-DD · <ref> — <what changed>"`, plus the details (findings, commit, PR).
4. A commit or PR that fixes the issue says `Fixes #<n>` (or `Refs #<n>` when partial). When it is fixed, add the final version line (`— fixed in <commit/PR>`) and close it: `gh issue close <n> --reason completed`.

## Without gh

If `gh` is not installed or not signed in, do not skip the issue: write the full title, labels and body (or the version comment) in a code block ready to paste, and say that `gh` is missing (`winget install GitHub.cli`, then `gh auth login`).
