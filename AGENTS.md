# Agent Notes (AGENTS.md)

This repo is a personal dotfiles/config workspace (Neovim, tmux, zsh, etc.).
Agentic changes should preserve the existing conventions and keep diffs small.

Important
- Never commit `.gitignore` (repo root or any subdir). Keep it local-only.
- Never commit `AGENTS.md` (repo root or any subdir). Keep it local-only.
- No Cursor/Copilot rule files were found: no `.cursor/rules/`, no `.cursorrules`, no `.github/copilot-instructions.md`.

Repo Map (high-signal)
- `nvim/`: Neovim config (Lua, lazy.nvim plugin specs)
- `.zshrc`, `.tmux.conf`, `alacritty/`, `.hammerspoon/`: app configs
- `install.sh`: bootstrap installer (Homebrew + symlinks)
- `opencode/`: OpenCode plugin config (`opencode/opencode.json`)

What This Repo Is
- A mostly config-only workspace; most changes are edits to existing files.
- Expect Lua (Neovim), shell (zsh/bash), and a few app-specific formats (JSON/YAML/TOML).

Build / Lint / Test

There is no single “build” pipeline for this repo.
Use the checks below depending on what you touched.

Neovim smoke checks
- Start Neovim normally: `nvim`
- Headless start (basic syntax/runtime errors):
  - `nvim --headless "+qall"`
  - If you changed plugin bootstrapping: `nvim --headless "+lua require('config.lazy')" "+qall"`

Neovim formatting (in-editor)
- Format current buffer via conform: `<leader>m` (see `nvim/lua/plugins/lsp.lua`).

Lua formatting (Neovim config)
- This repo expects Lua formatting via `stylua` (see `nvim/lua/plugins/lsp.lua` -> conform formatters).
- If `stylua` is installed:
  - Check only: `stylua --check nvim/lua`
  - Format: `stylua nvim/lua`

Shell script checks
- Syntax check: `bash -n install.sh`
- Format (if `shfmt` installed):
  - Check: `shfmt -d install.sh`
  - Format: `shfmt -w install.sh`

JSON formatting
- Conform config formats JSON via `jq` (sorted keys, 2 spaces, ASCII).
- Manual equivalent:
  - `jq -S --indent 2 --ascii-output . < file.json > /tmp/file.json && mv /tmp/file.json file.json`

Python tests (when applicable)
- This repo contains Neovim config for running Python tests via neotest/pytest, but it is not itself a Python package.
- If you are working inside a separate Python project and need “single test” examples:
  - Run one file: `pytest path/to/test_file.py -q`
  - Run one test: `pytest path/to/test_file.py::TestClass::test_name -q`
  - Run by keyword: `pytest -k "keyword" -q`

Running a single test from Neovim (neotest)
- Nearest test: `<leader>tt`
- Current file: `<leader>tf`
- All tests: `<leader>ta`
- Stop: `<leader>ts`
- Output panel: `<leader>to`
- Debug current file: `<leader>tD`
- Debug nearest (with breakpoints bridge): `<leader>td` (see `nvim/lua/config/lazy.lua`)

OpenCode plugin workspace (optional)
- `opencode/` is a tiny JS workspace used to pin OpenCode plugins.
- If you need to update/install deps:
  - `cd opencode && bun install`

Code Style Guidelines

General
- Prefer minimal, mechanical diffs; avoid unrelated refactors.
- Keep configs readable; explicit > clever.
- Don’t introduce new tooling unless the repo already uses it.
- Preserve existing keybindings/UX; avoid “re-mapping everything” changes.
- Keep changes local to the feature/fix; avoid cross-file refactors unless required.

Lua (Neovim)

Files / structure
- Plugin specs live in `nvim/lua/plugins/*.lua` and usually `return { ... }`.
- Config modules live in `nvim/lua/config/*.lua`.

Formatting
- Follow existing indentation in the file (Lua files here commonly use tabs).
- Keep line length reasonable; Neovim UI is configured with `colorcolumn=120` in `nvim/lua/config/config.lua`.
- Prefer double quotes for strings to match current style.
- Prefer trailing commas in multi-line tables (makes diffs cleaner).

Imports / requires
- Prefer `local x = require("module")` near the top of the `config = function()` block.
- If a dependency might be optional/missing, guard with `pcall(require, ...)` and fail softly (notify + return).
- Avoid top-level side effects when possible; lazy-load inside `config = function()`.

Naming
- Use descriptive local names (`local neotest = require("neotest")`).
- For custom helpers, prefer `snake_case` local functions/variables.
- Avoid adding globals; if needed, name with `_G.` intentionally and keep scope small.

Types / diagnostics (Lua)
- Assume LuaLS is enabled; keep `vim` as the only global.
- Use annotations sparingly when they add clarity:
  - `---@type` for complex tables/opts
  - `---@param` / `---@return` for reusable helpers

Keymaps
- Use `vim.keymap.set`.
- Always set a `desc` so which-key / help UIs stay useful.
- Keep mappings consistent with existing leader patterns (tests under `<leader>t…`, formatting under `<leader>m`, etc.).
- Prefer buffer-local mappings when they are filetype/plugin-specific.

Error handling / UX
- Prefer early returns on missing prerequisites.
- Use `vim.notify(msg, vim.log.levels.WARN|INFO|ERROR)` for user-facing failures.
- Avoid hard crashes during startup; degrade gracefully.
- If reading files or running shell commands, handle nil/empty returns; avoid indexing nil.
- When deleting buffers/windows, use API calls and guard missing buffers.

Shell / Bash
- Quote variables and paths (`"$var"`) unless you intentionally want word-splitting.
- Prefer safe defaults; avoid destructive actions without clear prompts.
- Don’t add `set -e`/`set -u` retroactively unless you also make the script compatible.
- Keep `install.sh` changes conservative; it is user-facing and can be destructive.

Zsh
- Keep `.zshrc` changes compatible with interactive shells; avoid breaking non-interactive usage.
- Prefer lightweight functions/aliases; avoid adding heavy startup-time commands.

Git / Commits (Commit Skill)

Workflow for creating new commits:
1. **Analyze Changes**: Run `git status` and `git diff`. Understand the logic of changes across all files. Determine if files are linked by a single logical change or if they should be separate commits.
2. **Review Style**: Check the last 10 commits (`git log -10 --oneline`) to ensure the new commit matches the established style and scope naming.
3. **Draft Message**: Use the `type(scope): Description` format.
   - **Types**: `feat`, `fix`, `refactor`, `chore`, `docs`, `style`, `test`.
   - **Scopes**: Use specific scopes like `nvim:harpoon`, `nvim:config`, `alacritty`, `tmux`, `zshrc`, etc.
   - **Description**: Concise, imperative, no trailing period.
4. **Finalize**: Stage only related changes and commit.

Commit message style (match existing history)
- Use Conventional Commits-style subjects like:
  - `feat(scope): short imperative summary`
  - `fix(scope): ...`, `refactor(scope): ...`, `chore(scope): ...`
- Scopes frequently look like `nvim:harpoon`, `nvim:config`, `alacritty`, `tmux`, `zshrc`.
- Keep the subject short and specific; no trailing period.
- Examples seen in this repo:
  - `feat(nvim:neotest): Add diff helper consumer and <leader>ti mapping for failed tests`
  - `feat(tmux): Update resize keybindings`
  - `feat(config): Add opencode configuration`
