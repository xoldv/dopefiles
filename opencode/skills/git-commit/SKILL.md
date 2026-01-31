---
name: git-commit
description: Create and maintain high-quality git commits matching the project's style and conventions.
---

# Git Commit Skill

This skill helps you create and maintain high-quality git commits that match the project's style and conventions.

## Workflow

1. **Analyze Changes**:
   - Run `git status` to see which files are modified or untracked.
   - Run `git diff` (and `git diff --cached`) to examine the actual code changes.
   - Determine if the changes across multiple files are logically related or should be split into multiple commits.

2. **Fix Existing Commits**:
   - Check the recent local commits that haven't been pushed (e.g., `git log @{u}..HEAD --oneline` or the last few commits).
   - If any commit message deviates from the established style (e.g., "fast fix", "update", "temp"), **rename them**.
   - Use `git commit --amend` for the last commit or `git rebase -i` (if appropriate and safe) to fix older unpushed commits.
   - Analyze the diff of those commits to generate a meaningful `type(scope): description` message.

3. **Understand Style & Scopes**:
   - Format: `type(scope): description`
   - **Types**: `feat`, `fix`, `refactor`, `chore`, `docs`, `style`, `test`.
   - **Scopes**: `nvim:config`, `nvim:harpoon`, `nvim:neotest`, `alacritty`, `tmux`, `zshrc`, `config`, etc.

## Commit Examples
- `feat(config): Add opencode configuration`
- `feat(nvim:harpoon): Update toggle menu keybinding to <C-e>`
- `feat(nvim:config): Update window resizing and add git search mapping`
- `feat(nvim): Remove neovim-remote plugin from lockfile`
- `feat(alacritty): Remove useless keybindings`
- `feat(tmux): Update resize keybindings`
- `feat(nvim:neotest): Add diff helper consumer and <leader>ti mapping for failed tests`
- `feat(nvim:harpoon): Use Command MacOS key in harpoon keybindings`
- `feat(zshrc): Add fzf alias for searching word in files`
- `feat(nvim:close-buffers): Refactor config`
- `fix(nvim:lsp): Fix diagnostic hover color`
- `chore(deps): Update lazy.nvim plugins`

## Guidelines
- **No Pushing**: NEVER push to the remote repository. This is a critical safety rule.
- **Description**: Concise, imperative mood, no trailing period.
- **Auto-Correction**: If you see "lazy" commit messages in the local history, proactively offer or perform a rename based on the actual changes.
- **Atomic Commits**: Keep diffs focused. If changes are unrelated, suggest splitting them.
