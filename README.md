# claude-skills

A reusable set of [Claude Code](https://claude.com/claude-code) skills and rules: commit and branch conventions, root-cause debugging, safe refactoring, diff review, and a "smallest change that works" mode. Install it into any project with one command; it stays out of that project's git.

Bộ skill và rule dùng lại được cho [Claude Code](https://claude.com/claude-code): quy ước commit và nhánh, debug tận gốc, refactor an toàn, review diff, và chế độ "thay đổi nhỏ nhất mà đủ". Cài vào dự án bất kỳ bằng một lệnh; không đụng tới git của dự án đó.

[English](#english) · [Tiếng Việt](#tiếng-việt)

---

## English

### What is inside

**Skills** (`skills/<name>/SKILL.md`) — Claude loads a skill by itself when the task matches its description, or you call it with `/<name>`.

| Skill | What it does |
|---|---|
| `branch-naming` | `<type>/<short-kebab>` branch names; branch off before editing on `main`/`master`; never push |
| `commit-message` | Conventional Commits, one logical change per commit, no attribution lines; proposes a ready-to-copy commit message at the end of every task that changed files (does not commit or push by itself) |
| `commit-push` | Commit the current changes (split by logical change, `commit-message` format) and push the current branch; asks first on `main`/`master`, never force pushes. Runs only when called with `/commit-push` |
| `changelog` | Update `CHANGELOG.md` from commits since the last tag (Keep a Changelog) |
| `pr-description` | PR title + Summary / Why / How to test / Risks; shows a draft, does not open the PR |
| `debug-root-cause` | Reproduce → locate → confirm one cause → fix at the source → prove it → 3-line report |
| `qc-ui` | TakakoMes only: build pages in the Quality Control / QC Pro style (HeaderSection, GenericMudTable, tabs, chips, dialogs, forms); in other projects asks before applying |
| `refactor-safe` | Behavior-preserving refactor in small verified steps; no bug fixes mixed in |
| `review-diff` | Review a diff for correctness, security, data loss, performance, bloat; `file:line — problem — fix` |
| `docs-readme` | Update README in the same change when setup, config or usage changes |
| `ponytail` | Lazy senior dev mode: smallest complete change, reuse what exists, name what was skipped |
| `prompt-patterns` | Copy-paste prompts for planning, quality, verification and bug fixing |
| `github-issue` | Open a GitHub issue for each problem to solve (search for duplicates first); when it changes, update it as a new version (v2, v3… with date and tag/commit) and comment; without `gh`, write ready-to-paste text |

**Rules** (`rules/*.md`) — always-on guidance; a rule with `paths:` only applies when Claude touches matching files.

| Rule | Applies to |
|---|---|
| `code-style` | Everything: `Async` suffix for async functions, short plain names, no commented-out code, early returns, files under 300 lines |
| `api-design` | `src/api/**`, `src/routes/**`, `app/api/**`, `**/Controllers/**`, `**/Apis/**` |
| `testing` | `tests/**`, `*.test.*`, `*.spec.*` |
| `todo-priority` | Everything: `TODO(0)`…`TODO(4)`, `PERF`; no bare `TODO` |
| `task-commit` | Everything: when a task changed files, end the reply with a ready-to-copy commit message (propose only, no commit/push) |
| `logging` | Everything: log each step that can fail through the existing logger (sink such as Seq already configured), structured placeholders with IDs, right level, no secrets |

**`settings.json`** — blocks `git push` for Claude (you push yourself) and turns off the commit/PR attribution lines.

### Install

Requires PowerShell 7+ (Windows, macOS or Linux) and git.

```powershell
git clone <this-repo-url> claude-skills
.\claude-skills\install.ps1 -Target C:\path\to\your-project
```

The script:
1. Copies `skills/` and `rules/` into `<project>\.claude\` (overwrites only these files).
2. Writes `<project>\.claude\settings.json` only if it does not exist. Use `-Force` to overwrite it.
3. If the project's git does not ignore `.claude/` yet, adds it to `.git/info/exclude`. That file is local to your clone and never committed, so the skills are not pushed with the project.
4. Warns if the project already tracks files under `.claude/` (those would still be committed).

Restart Claude Code in the project (or open a new session) to load the skills.

### Update

Pull this repo, then run `install.ps1` again with the same `-Target`.

### Add or change a skill

Create `skills/<name>/SKILL.md` with front matter:

```markdown
---
name: <name>
description: <what it does and WHEN to use it — Claude decides from this line>
---

# Steps or rules here
```

Keep each skill short and specific. Then re-run `install.ps1` on your projects.

### Credits

- `ponytail` comes from [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) (MIT).
- `prompt-patterns` collects prompts shared by the Claude Code team.

---

## Tiếng Việt

### Có gì bên trong

**Skills** (`skills/<tên>/SKILL.md`): Claude tự dùng skill khi công việc khớp với phần mô tả, hoặc bạn gọi bằng `/<tên>`.

| Skill | Làm gì |
|---|---|
| `branch-naming` | Đặt tên nhánh `<loại>/<mô-tả-ngắn>`; đang ở `main`/`master` thì tạo nhánh trước khi sửa; không push |
| `commit-message` | Conventional Commits, mỗi commit một thay đổi, không thêm dòng attribution; cuối mỗi task có sửa file thì đề xuất sẵn nội dung commit để copy (không tự commit, không tự push) |
| `commit-push` | Commit các thay đổi hiện tại (tách theo từng thay đổi, theo `commit-message`) rồi push nhánh hiện tại; đang ở `main`/`master` thì hỏi trước, không force push. Chỉ chạy khi gọi `/commit-push` |
| `changelog` | Cập nhật `CHANGELOG.md` từ các commit kể từ tag gần nhất (Keep a Changelog) |
| `pr-description` | Tiêu đề PR + Summary / Why / How to test / Risks; chỉ đưa bản nháp, không tự mở PR |
| `debug-root-cause` | Tái hiện → tìm chỗ hỏng → xác nhận đúng một nguyên nhân → sửa tận gốc → chứng minh → báo cáo 3 dòng |
| `qc-ui` | Chỉ cho TakakoMes: dựng trang theo style Quality Control / QC Pro (HeaderSection, GenericMudTable, tab, chip, dialog, form); dự án khác thì hỏi trước khi áp dụng |
| `refactor-safe` | Refactor không đổi hành vi, từng bước nhỏ có kiểm tra; không trộn sửa bug vào |
| `review-diff` | Review diff về đúng/sai, bảo mật, mất dữ liệu, hiệu năng, code thừa; báo dạng `file:dòng — lỗi — cách sửa` |
| `docs-readme` | Đổi cách cài đặt, cấu hình hay sử dụng thì sửa README trong cùng thay đổi |
| `ponytail` | Chế độ "dev lười": thay đổi nhỏ nhất mà đủ, dùng lại cái có sẵn, nêu rõ phần đã bỏ qua |
| `prompt-patterns` | Mẫu câu lệnh copy-paste để lập kế hoạch, nâng chất lượng, kiểm chứng, sửa bug |
| `github-issue` | Mở issue GitHub cho từng vấn đề cần giải quyết (tìm trùng trước); khi có thay đổi thì cập nhật thành version mới (v2, v3… kèm ngày và tag/commit) và comment; không có `gh` thì đưa sẵn nội dung để dán |

**Rules** (`rules/*.md`): hướng dẫn luôn bật; rule nào có `paths:` thì chỉ áp dụng khi Claude sửa file khớp đường dẫn đó.

| Rule | Áp dụng cho |
|---|---|
| `code-style` | Toàn dự án: hàm async có hậu tố `Async`, tên ngắn rõ nghĩa, không để code bị comment, return sớm, file dưới 300 dòng |
| `api-design` | `src/api/**`, `src/routes/**`, `app/api/**`, `**/Controllers/**`, `**/Apis/**` |
| `testing` | `tests/**`, `*.test.*`, `*.spec.*` |
| `todo-priority` | Toàn dự án: `TODO(0)`…`TODO(4)`, `PERF`; không viết `TODO` trống |
| `task-commit` | Toàn dự án: xong task có sửa file thì cuối câu trả lời đưa sẵn nội dung commit để copy (chỉ đề xuất, không commit/push) |
| `logging` | Toàn dự án: log rõ từng bước có thể lỗi qua logger sẵn có (sink như Seq đã cấu hình, chỉ cần ghi log), placeholder có ID, đúng level, không log bí mật |

**`settings.json`**: chặn Claude chạy `git push` (bạn tự push) và tắt dòng attribution trong commit/PR.

### Cài đặt

Cần PowerShell 7+ (Windows, macOS hoặc Linux) và git.

```powershell
git clone <url-repo-này> claude-skills
.\claude-skills\install.ps1 -Target C:\duong-dan\du-an
```

Script sẽ:
1. Copy `skills/` và `rules/` vào `<dự án>\.claude\` (chỉ ghi đè các file này).
2. Chỉ tạo `<dự án>\.claude\settings.json` khi chưa có. Thêm `-Force` để ghi đè.
3. Nếu git của dự án chưa ignore `.claude/`, thêm vào `.git/info/exclude`. File này chỉ nằm trong bản clone trên máy bạn, không bao giờ được commit, nên bộ skill không bị push lên cùng dự án.
4. Cảnh báo nếu dự án đang track sẵn file trong `.claude/` (các file đó vẫn sẽ bị commit).

Mở lại Claude Code trong dự án (hoặc mở phiên mới) để nạp skill.

### Cập nhật

Pull repo này, rồi chạy lại `install.ps1` với cùng `-Target`.

### Thêm hoặc sửa skill

Tạo `skills/<tên>/SKILL.md` có phần đầu:

```markdown
---
name: <tên>
description: <làm gì và KHI NÀO dùng — Claude dựa vào dòng này để chọn skill>
---

# Các bước hoặc quy tắc
```

Giữ mỗi skill ngắn và cụ thể. Sau đó chạy lại `install.ps1` cho các dự án.

### Nguồn

- `ponytail` lấy từ [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) (MIT).
- `prompt-patterns` tổng hợp các câu lệnh do đội Claude Code chia sẻ.
