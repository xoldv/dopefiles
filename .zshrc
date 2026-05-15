# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY

# Completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# zsh-autosuggestions (brew install zsh-autosuggestions)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt (gitstatus)
source ~/gitstatus/gitstatus.prompt.zsh
export PS1='%F{green}%n@%m:%~%f${GITSTATUS_PROMPT}$ '

# Editor
export EDITOR='nvim'

# PATH
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/Users/dlk/.spicetify"

# zoxide
export _ZO_DOCTOR=0
eval "$(zoxide init zsh --cmd cd)"

# Aliases
alias zi=__zoxide_zi
alias n=nvim
alias lg=lazygit
alias venv='. .venv/bin/activate'
alias syncvault='git commit -m "vault backup: $(date "+%Y-%m-%d %H:%M:%S")"'
alias ipyright='[ -f pyrightconfig.json ] && echo "pyrightconfig.json already exists" || echo "{\n  \"venvPath\": \".\",\n  \"venv\": \".venv\",\n  \"extraPaths\": [\"src\"]\n}" > pyrightconfig.json'
alias lint='ruff check --fix --unsafe-fixes src/; 2>/dev/null 1>&2 ruff check --fix --unsafe-fixes app/; ruff check --fix --unsafe-fixes tests/; ruff format .'
alias t='~/tmux-sessionizer'
alias f='fzf --preview="cat {}" --bind enter:"become(nvim {})"'
alias o=opencode

# Live grep → nvim
fw() {
  local initial_query="${*:-}"
  fzf --ansi --disabled --query "$initial_query" \
      --bind "change:reload:rg --column --line-number --no-heading --color=always --smart-case -- {q} || true" \
      --delimiter : \
      --preview "bat --style=numbers --highlight-line {2} {1} 2>/dev/null || cat {1}" \
      --bind "enter:become(nvim +{2} {1})" \
      --header "Search in files (Live Grep)"
}

# Keybindings
bindkey -s '^T' '~/tmux-sessionizer\n'
bindkey '^b' beginning-of-line
