#!/usr/bin/env bash
folder_of_script=$(dirname $0)
clear
# ==============
# Install stuffs
# ==============
sudo apt install -y zsh\*
sudo apt install -y ruby
sudo apt install -y ruby-dev
sudo apt install -y bat
sudo apt install -y fzf
sudo apt install -y fdfind
sudo apt install -y fd
sudo apt install -y batcat
sudo apt install -y  tmux\*
sudo apt install -y libncursesw5-dev
sudo apt install -y sshfs
sudo apt install -y curlftpfs
sudo apt install -y fuse
sudo apt install -y fuse-zip
sudo apt install -y fusefat
sudo apt install -y fuseiso
sudo apt install -y python3
sudo apt install -y tldr
sudo apt install -y python3-dev
sudo apt install -y python3-pip
sudo apt install -y python3-jedi
sudo gem install colorls vifm
sudo apt install -y espeak
sudo apt install -y espeak-ng
sudo apt install -y rygel
sudo apt install -y tasksel
sudo apt install -y python3-tabulate
sudo apt install -y xfce4
sudo apt install -y xsettingsd
sudo apt install -y xfce4-session
sudo apt install -y xfce4-goodies
sudo apt install -y rofi
sudo apt install -y bind9-dnsutils
sudo apt install -y nitrogen
sudo apt install -y libpulse
sudo apt install -y python3-pulsectl_asyncio
sudo apt install -y python3-pyxdg
sudo apt install -y python3-psutil
sudo apt install -y python3-dbus
sudo apt install -y kbdd
sudo apt install -y conky
sudo apt install -y conky-all
# Install z4h (zsh for humans)
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install && p10k configure)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install && p10k configure)"
fi

# =======================
# Check for fd and batcat
# =======================
batcat=""
fd=""

if type fd 2>/dev/null; then
        fd="fd"
    else
        fd="fdfind"
fi
if type bat 2>/dev/null; then
        batcat="bat"
    else
        batcat="batcat"
fi

# =================================
# Declare and array of stuff needed
# to be added in .bashrc and .zshrc
# =================================
theme=$(cat <<'EOF'
function theme(){
    declare -A vars
    vars["colorls_theme"]="--light"
    vars["fzf_theme"]="--color=16"
    vars["BAT_THEME"]="GitHub"
    keys=("${(@k)vars}")
    echo -ne "\033[36mYou are using 'dark' theme or 'light' on your terminal(\033[34m[l]/d\033[36m)?\033[31m "
    read user_theme

    for i in ${keys[@]};
    do
        #echo "export ${i:1:-1}=\"${vars[$i]}\""
        setopt extendedglob
        if [[ "${user_theme}" == (#i)"d" ]] || [[ "${user_theme}" == (#i)"dark" ]]; then
        vars["colorls_theme"]="--dark"
        vars["fzf_theme"]="--color=16"
        vars["BAT_THEME"]="ansi"
        sed -i -E "s@export ${i:1:-1}=[\"']?.*[\"']?@export ${i:1:-1}=\"${vars[$i]}\"@" ~/.zshrc
        else
        vars["colorls_theme"]="--light"
        vars["fzf_theme"]="--color=16"
        vars["BAT_THEME"]="GitHub"
        sed -i -E "s@export ${i:1:-1}=[\"']?.*[\"']?@export ${i:1:-1}=\"${vars[$i]}\"@" ~/.zshrc
        fi

    done
    setopt extendedglob
    if [[ "${user_theme}" == (#i)"d" ]] || [[ "${user_theme}" == (#i)"dark" ]]; then
    echo -e "\033[31mDark\033[0m theme applied."
    else
    echo -e "\033[31mLight\033[0m theme applied."
    fi

    echo -e "\033[0mTo change your prompt you can run \033[31mp10k configure\033[0m"
    echo -e "You also need to restart your terminal to apply your changes properly!"
}
EOF
)
mkv=$(cat <<'EOF'
function mkv(){
  ffmpeg -threads auto -y -i "${1}" -preset ultrafast "0_${1}_new.mkv"
}
EOF
)
mp4=$(cat <<'EOF'
function mp4(){
  ffmpeg -threads auto -y -i "${1}" -preset ultrafast "0_${1}_new.mp4"
}
EOF
)
tmux=$(cat <<'EOF'
export TERM=xterm
function start_tmux() {
    if type tmux &> /dev/null; then
        #if not inside a tmux session, and if no session is started, start a new session
        if [[ -z "$TMUX" && -z $TERMINAL_CONTEXT ]]; then
            (tmux attach || tmux new -s main -d)
        fi
    fi
}
start_tmux
EOF
)
oldIFS=$IFS
IFS=$'\n'
arr_things_should_be_added_to_bashrc_and_zshrc=(
 'export PATH="/home/$(whoami)/bin:$PATH"'
 'export colorls_theme="--light"'
 'export fzf_theme="--color=16"'
 'export RANGER_LOAD_DEFAULT_RC=FALSE'
 'export BAT_THEME="GitHub"'
 'export FZF_DEFAULT_OPTS="--preview '\'''${batcat}' --color=always {}'\''"'
# 'source $(dirname $(gem which colorls))/tab_complete.sh'
 'export FZF_DEFAULT_COMMAND="'${fd}' --type f"'
 'alias ls="colorls $colorls_theme"'
 'alias ll="colorls $colorls_theme -lh"'
 'alias la="colorls $colorls_theme -lah"'
 'export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1'
 'export JAVA_HOME=""'
 'export EDITOR="nvim"'
 'alias winpy="wine64 /home/$(whoami)/.wine/drive_c/Python310/python.exe"'
 'alias vim="nvim"'
# 'bindkey -v'
# 'export KEYTIMEOUT=1'
# 'bindkey -M viins "jk" vi-cmd-mode'
 'alias locate="plocate"'
 'alias m="systemctl restart minidlna"'
 'alias tree="tree -a -I .git"'
 'alias fzf="fzf $fzf_theme"'
 'alias ping="ping -nc4"'
 'alias cat="batcat"'
 'alias rm="rm -rf"'
 # ===========
 # Git aliases
 # ===========
 'alias g/l="git log --oneline --decorate"'
 'alias g/s="git status"'
 'alias g/a/all="git add -A"'
 'alias g/a="git add"'
 'alias g/c="git commit"'
 'alias g/r="git rm"'
 'alias g/r/only_from_git="git rm --cached"'
 'alias g/m="git mv"'
 'alias g/unstage="git restore --staged"'
 'alias g/amend="git commit --amend"'
 'alias g/discard="git restore"'
 'alias g/clone="git clone"'
 'alias g/pull/origin/main="git pull origin main"'
 'alias g/pull/origin/master="git pull origin master"'
 'alias g/push/origin/main="git push origin main"'
 'alias g/push/origin/master="git push origin master"'
 'alias g/tag/list="git tag -l"'
 'alias g/tag/create="git tag -a"'
 'alias g/tag/show="git show"'
  $mkv
  $mp4
  $theme
  #$tmux
)

# ===================
# Change shell to zsh
# ===================
chsh -s /usr/bin/zsh

# =============================================
# Add the array content into .bashrc and .zshrc
# =============================================
for i in ${arr_things_should_be_added_to_bashrc_and_zshrc[@]}; do
    echo "$i" >> ~/.zshrc
done
IFS=oldIFS
#source $(type p10k | sed -E '$s$.*from (.*)$\1$')

tldr --update
# ===========
# Install fzf
# ===========
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
exec zsh
