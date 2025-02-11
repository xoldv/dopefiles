#!/usr/bin/env bash

bold=$(tput bold)

function installing_func(){
    brew_installing
    # echo -ne '######                     (12.5%)\r'
    zsh_isntalling
    # echo -ne '##########                 (25%)\r'
    oh_my_zsh_installing
    # echo -ne '#############              (37.5%)\r'
    powerlevel10k_installing
    # echo -ne '###############            (50%)\r'
    brew_stuff_installing
    # echo -ne '#################          (62.5%)\r'
    backup_nvim
    # echo -ne '######################     (75%)\r'
    remove_all_old_configs
    # echo -ne '########################   (87.5%)\r'
    repo_downloading
    # echo -ne '########################## (99.9%)\r'
    # sleep 1
}

function brew_installing(){
    if command -v brew >/dev/null 
    then 
        echo "${bold}Brew already installed!"
    else
        echo "${bold}brew not installed"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    return
}

function zsh_installing(){
    if [[ $SHELL = /bin/zsh/ ]]; then
        echo "${bold}ZSH already isntalled!"
    else
        brew install zsh
    fi
    return

}

function oh_my_zsh_installing(){
    if [[ $ZSH = $(pwd)/.oh-my-zsh ]]; then
        echo "${bold}Oh-My-ZSH already installed!"
    else
        export RUNZSH=no
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        if [[ $SHELL = /bin/bash/ ]]; then
            chsh -s $(which zsh)
        fi
    fi
    return


}

function powerlevel10k_installing(){
    theme=$(grep -c "p10k" ~/.zshrc)
    if [[ $theme -le 0 ]]; then
        rm -rf ~/.p10k.zsh
        export RUNZSH=no
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

    else
        echo "${bold}Theme PowerLevel10k already isntalled!"

    fi
    return
}

function brew_check_status(){
    local installing="$1"
    local name="$2"
    if [[ $installing =~ "Not installed" ]]; then
        brew install $name
    else
        echo "$name alerady installed!"
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

function remove_all_old_configs(){
    rm ~/.tmux.conf && rm -rf ~/.tmux 
    rm -rf ~/.config/lf
    rm -rf ~/.config/yabai
    rm -rf ~/.config/skhd
    rm -rf ~/.config/fastfetch
    rm -rf ~/.config/kitty
    rm -rf ~/.config/.tmux.conf && rm -rf ~/.config/.zshrc && rm -rf ~/.config/cornechoc.json
    return
}

function repo_downloading(){
    mv ~/dopefiles/nvim ~/.config/
    mv ~/dopefiles/kitty ~/.config/
    mv ~/dopefiles/.tmux.conf ~/
    mv ~/dopefiles/lf ~/.config/
    mv ~/dopefiles/yabai ~/.config/
    mv ~/dopefiles/skhd ~/.config/
    mv ~/dopefiles/fastfetch ~/.config/
    mv ~/dopefiles/kitty ~/.config/
    rm -rf ~/.zshrc && mv dopefiles/.zshrc ~/
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    return
}

installing_func

echo "Установка zsh по умолчанию:"
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



