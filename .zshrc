# Options
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_SILENT INTERACTIVE_COMMENTS
bindkey -e  # emacs keys (otherwise zsh picks vi mode because EDITOR=nvim)

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY HIST_VERIFY

# Completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=*'  # case-insensitive
zstyle ':completion:*' list-colors ''
export CLICOLOR=1

# zsh-autosuggestions (brew install zsh-autosuggestions)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Prompt (gitstatus)
source ~/gitstatus/gitstatus.prompt.zsh
export PS1='%F{#ba3d40}%n@%m:%~%f${GITSTATUS_PROMPT}$ '

# Editor
export EDITOR='nvim'

# zoxide
export _ZO_DOCTOR=0
eval "$(zoxide init zsh --cmd cd)"

# Aliases
alias zi=__zoxide_zi
alias n=nvim
alias vim=nvim
alias lg=lazygit
alias cr=tuicr
alias venv='. .venv/bin/activate'
alias syncvault='git commit -m "vault backup: $(date "+%Y-%m-%d %H:%M:%S")"'
alias ipyright='[ -f pyrightconfig.json ] && echo "pyrightconfig.json already exists" || echo "{\n  \"venvPath\": \".\",\n  \"venv\": \".venv\",\n  \"extraPaths\": [\"src\"]\n}" > pyrightconfig.json'
alias lint='ruff check --fix --unsafe-fixes src/; 2>/dev/null 1>&2 ruff check --fix --unsafe-fixes app/; ruff check --fix --unsafe-fixes tests/; ruff format .'
alias t='~/tmux-sessionizer'
alias f='fzf --preview="cat {}" --bind enter:"become(nvim {})"'

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
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}

# Keybindings
bindkey -s '^T' '~/tmux-sessionizer\n'
bindkey '^b' beginning-of-line
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search '^[OB' down-line-or-beginning-search
bindkey '^[[3~' delete-char
bindkey '^[[1;3D' backward-word '^[[1;3C' forward-word
autoload -U edit-command-line && zle -N edit-command-line
bindkey '^x^e' edit-command-line

export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/Users/dlk/.spicetify"
export PATH=/Users/dlk/.opencode/bin:$PATH
