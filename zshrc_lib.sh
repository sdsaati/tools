# coyp right sdsaati
folder_of_script=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
home_folder=$(readlink -f ~)
set -o vi # enable vi mode in zsh/bash


##########################################
############### EXPORTS ##################
##########################################
export PATH="/home/$(whoami)/bin/ranger-1.9.4:/home/$(whoami)/bin:/home/$(whoami)/.fzf/bin:$HOME/Downloads/code-stable-x64-1759409365/VSCode-linux-x64:$PATH"
export RANGER_LOAD_DEFAULT_RC=FALSE
export BAT_THEME=Dracula
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export JAVA_HOME=""
export EDITOR="code --no-sandbox"
export fzf_theme="--color=16"


##########################################
############### ALIASES ##################
##########################################
alias vim="nvim.appimage"
alias nvim="nvim.appimage"
alias zshrc="$EDITOR /home/sdsaati/.zshrc & disown"
alias zshrclib="$EDITOR $home_folder/bin/zshrc_lib.sh & disown"
# alias winpy="wine64 /home/$(whoami)/.wine/drive_c/Python310/python.exe"
alias ls="lsd --hyperlink auto"
alias ll="lsd -lh --hyperlink auto"
alias la="lsd -lah --hyperlink auto"
alias m="systemctl restart minidlna"
alias tree="tree -a -I .git"
alias clock="tty-clock -B -C 7"
alias fzf="fzf $fzf_theme"
alias fcd="cd (dirname (fzf))"
#alias ping="ping -nc4"
#alias cat="bat"
alias rm="rm -rf"
alias warp="warp-cli connect"
alias warpd="warp-cli disconnect"
alias p="proxychains4 -q -f ~/bin/proxychain.conf"
alias ag="ag --search-binary -f --hidden --no-group --ignore='*.m4a' --ignore='*.webm' --ignore='*.flatpak' --ignore='*.deb' --ignore='*.appimage' --ignore='*.mp4' --ignore='*.mkv' --ignore='*.mp3' --ignore='*.iso'"
alias code="$HOME/Downloads/code-stable-x64-1759409365/VSCode-linux-x64/code --no-sandbox"
alias f='firejail --net=socks5 --socks-server="127.0.0.1:10808"'
alias ollama='docker exec -it ollama ollama'
##########################################
############## FUNCTIONS #################
##########################################
function mkv(){
  ffmpeg -threads auto -y -i "${1}" -preset ultrafast "0_${1}_new.mkv"
}

function mp4(){
  ffmpeg -threads auto -y -i "${1}" -preset ultrafast "0_${1}_new.mp4"
}
# Use 'jk' to exit insert mode in Zsh vi mode
function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
        echo -ne "\e[2 q"  # show cursor in normal mode
    else
        echo -ne "\e[6 q"  # hide cursor in insert mode (optional)
    fi
    zle reset-prompt
}
zle -N zle-keymap-select

# Bind 'jk' to behave like <Esc> in vi insert mode
bindkey -M viins 'jk' vi-cmd-mode
