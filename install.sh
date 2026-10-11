#!/usr/bin/env bash

set -euo pipefail

BGreen="\033[1;32m"
Blue="\033[0;94m"
Yellow="\033[0;93m"
NC='\033[0m'

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

function info() {
    echo -e "${Blue}$1${NC}"
}

function ok() {
    echo -e "${BGreen}$1${NC}"
}

function warn() {
    echo -e "${Yellow}$1${NC}"
}

function install_brew() {
    if command -v brew >/dev/null; then
        ok "Brew already installed!"
        return
    fi

    info "Installing Brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    local prefix
    for prefix in /opt/homebrew /usr/local; do
        if [[ -x "$prefix/bin/brew" ]]; then
            eval "$("$prefix/bin/brew" shellenv)"
            if ! grep -qs "brew shellenv" ~/.zprofile; then
                printf '\neval "$(%s/bin/brew shellenv)"\n' "$prefix" >>~/.zprofile
            fi
            return
        fi
    done
}

function install_packages() {
    info "Installing packages from Brewfile..."
    if ! brew bundle --no-upgrade --file="$DOTFILES/Brewfile"; then
        warn "Some packages failed to install, continuing..."
    fi
}

function install_gitstatus() {
    if [[ -d ~/gitstatus ]]; then
        ok "gitstatus already installed!"
        return
    fi

    info "Installing gitstatus..."
    git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/gitstatus
}

# Symlink $DOTFILES/$1 to $2. Anything already at $2 is moved to $2.bak.<timestamp>.
function link() {
    local src="$DOTFILES/$1"
    local dst="$2"

    if [[ ! -e "$src" ]]; then
        warn "Skipping $1 (not in repo)"
        return
    fi

    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        ok "$dst already linked!"
        return
    fi

    if [[ -e "$dst" || -L "$dst" ]]; then
        warn "Backing up $dst -> $dst.bak.$STAMP"
        mv "$dst" "$dst.bak.$STAMP"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    info "Linked $dst"
}

function link_files() {
    local name
    for name in nvim alacritty ghostty kitty karabiner opencode yazi; do
        link "$name" "$HOME/.config/$name"
    done

    link .zshrc "$HOME/.zshrc"
    link .tmux.conf "$HOME/.tmux.conf"
    link .hammerspoon "$HOME/.hammerspoon"
    link gitstatus.prompt.zsh "$HOME/gitstatus/gitstatus.prompt.zsh"
}

function install_oh_my_zsh() {
    if [[ -d ~/.oh-my-zsh ]]; then
        ok "Oh-My-ZSH already installed!"
        return
    fi

    info "Installing Oh-My-ZSH..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function set_default_shell() {
    if [[ "$SHELL" == */zsh ]]; then
        ok "zsh already default shell!"
        return
    fi

    info "Setting zsh as default shell..."
    chsh -s /bin/zsh
}

install_brew
install_packages
install_gitstatus
link_files
install_oh_my_zsh
set_default_shell

cat << "EOF"

          ⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⡴⠶⠚⠛⠛⠛⠛⠓⠶⢦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀
          ⠀⠀⠀⠀⠀⣠⡴⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢦⣄⠀⠀⠀⠀⠀
          ⠀⠀⠀⣠⡾⠋⠀⢀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⣶⡍⠙⣷⣦⠀⠙⢷⣄⠀⠀⠀          
          ⠀⠀⣴⠋⠀⢠⣾⣿⡟⠉⠙⣿⣷⣆⠀⠀⠀⠀⠙⠁⠀⣼⡿⠀⠀⠀⠹⣦⠀⠀          
          ⠀⣼⠃⠀⢠⣿⣿⣿⠀⠀⠀⢸⣿⣿⣇⠀⠀⠀⠀⠈⠛⣧⣄⠀⠀⠀⠀⠘⣧⠀
          ⢰⡏⠀⠀⢸⣿⣿⣿⠀⠀⠀⢸⣿⣿⣿⡀⠀⢠⣶⡆⠀⣸⣿⠇⠀⠀⠀⠀⢹⡆
          ⣾⠁⠀⠀⠸⣿⣿⣿⡀⠀⠀⣸⣿⣿⣿⡇⠀⠀⠛⠦⠶⠛⠋⠀⠀⠀⠀⠀⠀⣷
          ⣿⠀⠀⠀⠀⠙⢿⣿⣷⣄⣠⢿⣿⣿⣿⡇⠀⠀⠉⠉⢉⣉⠉⠁⠀⠀⠀⠀⠀⣿              ＳＵＣＣＥＳＳＦＵＬ ＩＮＳＴＡＬＬＩＮＧ！
          ⢿⠀⠀⠀⠀⠀⠀⠈⠉⠉⠀⢸⣿⣿⣿⠁⠀⠀⠀⢠⣿⣿⠀⠀⠀⠀⠀⠀⠀⡿
          ⠸⣇⠀⠀⠀⣴⣾⣶⣆⠀⠀⣸⣿⣿⡏⠀⠀⠀⣠⠏⣿⣿⠀⠀⠀⠀⠀⠀⣸⠇
          ⠀⢻⡄⠀⠀⢿⣿⡿⠋⠀⢀⣿⣿⠏⠀⠀⠀⢰⣏⣀⣿⣿⣀⠀⠀⠀⠀⢠⡟⠀
          ⠀⠀⠻⣆⠀⠈⠙⠛⠶⠞⠛⠋⠁⠀⠀⠀⠀⠈⠉⠉⣿⣿⠉⠀⠀⠀⣰⠟⠀⠀
          ⠀⠀⠀⠙⢷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠉⠀⣠⡾⠋⠀⠀⠀
          ⠀⠀⠀⠀⠀⠙⠳⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⠞⠋⠀⠀⠀⠀⠀
          ⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠳⠶⢤⣤⣤⣤⣤⡤⠶⠞⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀

                                                                                                                      𝟓𝟎𝟕𝟎𝟏𝟓†
EOF

while true; do
    read -r -p "Reload terminal with zsh (y/n)? " yn

    case $yn in
        [Yy]*) exec zsh ;;
        [Nn]*) break ;;
        *) echo "Please answer yes or no." ;;
    esac
done
