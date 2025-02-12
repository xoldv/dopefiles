#!/usr/bin/env bash

BGreen="\033[1;32m"
Blue="\033[0;94m"


function installing_func(){
    brew_installing
    oh_my_zsh_installing
    powerlevel10k_installing
    brew_stuff_installing
    backup_nvim
    full_replacing_files
}

function brew_installing(){
    if command -v brew >/dev/null 
    then 
        echo -e "${BGreen}Brew already installed!"
    else
        echo -e "${Blue}Installing Brew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    return
}

function oh_my_zsh_installing(){
    if [[ $ZSH = $(pwd)/.oh-my-zsh ]]; then
        echo -e "${BGreen}Oh-My-ZSH already installed!"
    else

        echo -e "${Blue}Installing Oh-My-ZSH..."
        export RUNZSH=no
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        # if [[ $SHELL = /bin/bash/ ]]; then
        #     chsh -s $(which zsh)
        # fi
    fi
    return


}

function powerlevel10k_installing(){
    theme=$(grep -c "p10k" ~/.zshrc)
    if [[ $theme -le 0 ]]; then
        rm -rf ~/.p10k.zsh
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

        echo -e "${Blue}Installing ZSH plugins..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

    else
        echo -e "${BGreen}Theme PowerLevel10k already isntalled!"

    fi
    return
}

function brew_check_status(){
    local installing="$1"
    local name="$2"
    if [[ $installing =~ "Not installed" ]]; then
        echo -e "${Blue}Installing $name..."
        brew install $name
    else
        echo -e "${BGreen}$name already installed!"
    fi   
    return
}


function brew_stuff_installing(){

    stuff=("neovim" "lf" "tmux" "eza" "yabai" "skhd" "fastfetch" "btop" "spicetify-cli")
    for brew_service in ${stuff[@]}; do
        brew_check_status "$(brew info "${brew_service}")" "$brew_service"
    done
    # kitty installing or updating
    # curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    return
}


function backup_nvim(){
    while true; do
        read -p "Make a backup of your current nvim config (y/n)?" yn
        case $yn in
            [Yy]* ) mv ~/.config/nvim ~/.config/nvim.bak; mv ~/.local/share/nvim ~/.local/share/nvim.bak; mv ~/.local/state/nvim; ~/.local/state/nvim.bak mv ~/.cache/nvim ~/.cache/nvim.bak; break;;
            [Nn]* ) break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    if [[ $yn = n ]]; then
        rm -rf ~/.config/nvim
        rm -rf ~/.local/share/nvim
        rm -rf ~/.local/state/nvim
        rm -rf ~/.cache/nvim
    fi
    return
    
}

function full_replacing_files(){
    cp -fr ~/dopefiles/ ~/.config/
    cp -f ~/.config/.zshrc ~/
    cp -f ~/.config/.tmux.conf ~/
    cp -f ~/.config/.p10k.zsh ~/
    return
}


installing_func

echo -e "${BGreen}Установка zsh по умолчанию:"
chsh -s $(which zsh)
clear
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
    read -p "Reload terminal with zsh (y/n)? " yn
    case $yn in
        [Yy]* ) exec zsh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done



