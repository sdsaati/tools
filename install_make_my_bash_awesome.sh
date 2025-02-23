#!/usr/bin/env bash
folder_of_script=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
home_folder=$(readlink -f ~)
clear
# ==============
# Install stuffs
# ==============
sudo apt install -y zsh\*
sudo apt install -y ruby
sudo apt install -y ruby-dev
sudo apt install -y dunst # notify system
sudo apt install -y bat
sudo apt install -y fzf
sudo apt install -y fish
sudo apt install -y ffmpeg
sudo apt install -y tty-clock # terminal clock
sudo apt install -y kew # terminal audio player (Best :D)
sudo apt install -y volumeicon-alsa # systray icon for sound
sudo apt install -y pasystray # systray icon for sound
sudo apt install -y gnome-keyring
sudo apt install -y silversearcher-ag # ag (search in contents of files)
sudo apt install -y proxychains4 # proxify app through your proxy
sudo apt install -y dnscrypt-proxy # dns over https to hide your dns from isp
sudo apt install -y aria2
sudo apt install -y aria2c
sudo apt install -y luajit
sudo apt install -y lxpolkit
sudo apt install -y ffmpegthumbnailer
sudo apt install -y flameshot
sudo apt install -y chafa
sudo apt install -y fdfind
sudo apt install -y fd
sudo apt install -y ueberzug
sudo apt install -y ripgrep
sudo apt install -y fdclone
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
sudo apt install -y python3-yaml
sudo apt install -y tldr
sudo apt install -y python3-dev
sudo apt install -y python3-pip
sudo apt install -y python3-jedi
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
sudo apt install -y alacritty
sudo apt install -y conky
sudo apt install -y conky-all
sudo apt install -y p7zip-full
sudo apt install -y plocate
sudo apt install -y locate
sudo apt install -y mlocate
# sudo gem install colorls vifm

# =======================
# DNS settings
# =======================
sudo systemctl disable --now systemd-resolved
sudo rm -f /etc/resolv.conf
sudo touch /etc/resolv.conf
sudo echo "nameserver 127.0.0.1" > /etc/resolv.conf
sudo chattr +i /etc/resolv.conf
# NOTE: in your dwm you must run `pkexec dnscrypt-proxy -config ~/bin/dnscrypt.toml & disown`
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
elif type batcat 2>/dev/null; then
        batcat="batcat"
else
        batcat="cat"
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
fzf=$(cat <<'EOF'
# export FZF_COMPLETION_TRIGGER=""
# bindkey "^T" fzf-completion
# bindkey "^I" $fzf_default_completion
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'cat {}'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'batcat -n --color=always {}' "$@" ;;
  esac
}
EOF
)
oldIFS=$IFS
IFS=$'\n'
arr_things_should_be_added_to_bashrc_and_zshrc=(
 'export PATH="/home/$(whoami)/bin:/home/$(whoami)/.fzf/bin:$PATH"'
 'export colorls_theme="--dark"'
 'export RANGER_LOAD_DEFAULT_RC=FALSE'
 'export BAT_THEME="GitHub"'
# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
 'setopt glob_dots'     # no special treatment for file names with a leading dot
# 'source $(dirname $(gem which colorls))/tab_complete.sh'
 'export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1'
 'export JAVA_HOME=""'
 'export EDITOR="vim"'
 'export fzf_theme="--color=16"'
 'export FZF_DEFAULT_OPTS="--preview '\'''${batcat}' --color=always {}'\''"'
 'export FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case --follow --glob \"!venv/*\" --glob \"!.venv/*\" --glob \"!.git/*\""'
 'alias vim="nvim.appimage"'
 'alias winpy="wine64 /home/$(whoami)/.wine/drive_c/Python310/python.exe"'
# 'bindkey -v'
# 'export KEYTIMEOUT=1'
# 'bindkey -M viins "jk" vi-cmd-mode'
 'alias ls="colorls $colorls_theme"'
 'alias ll="colorls $colorls_theme -lh"'
 'alias la="colorls $colorls_theme -lah"'
 'alias m="systemctl restart minidlna"'
 'alias tree="tree -a -I .git"'
 'alias fzf="fzf $fzf_theme"'
 'alias ping="ping -nc4"'
 'alias cat="batcat"'
 'alias rm="rm -rf"'
 # ===========
 # Git aliases
 # ===========
 'alias gl="git log --oneline --decorate"'
 'alias gs="git status"'
 'alias gaAll="git add -A"'
 'alias ga="git add"'
 'alias gc="git commit"'
 'alias gr="git rm"'
 'alias grOnlyFromGit="git rm --cached"'
 'alias gm="git mv"'
 'alias gunstage="git restore --staged"'
 'alias gamend="git commit --amend"'
 'alias gdiscard="git restore"'
 'alias gclone="git clone"'
 'alias gpullOriginMain="git pull origin main"'
 'alias gpullOriginMaster="git pull origin master"'
 'alias gpushOriginMain="git push origin main"'
 'alias gpushOriginMaster="git push origin master"'
 'alias gtagList="git tag -l"'
 'alias gtagCreate="git tag -a"'
 'alias gshow="git show"'
 'alias pip="pip --proxy 127.0.0.1:20171"'
  $mkv
  $mp4
  $theme
  #$tmux
  $fzf
)
arr_things_should_be_added_to_fish=(
 'fish_add_path -p ~/bin'
 'set fish_greeting' 
 'set -x PATH "/home/$(whoami)/bin:/home/$(whoami)/.fzf/bin:$PATH"'
 'set -x colorls_theme "--dark"'
 'set -x RANGER_LOAD_DEFAULT_RC FALSE'
 'set -x BAT_THEME "GitHub"'
 'set -x ANDROID_EMULATOR_USE_SYSTEM_LIBS 1'
 'set -x JAVA_HOME ""'
 'set -x EDITOR "vim"'
 'set -x fzf_theme "--color=16"'
 'set -x FZF_DEFAULT_OPTS "--preview '\'''${batcat}' --color=always {}'\''"'
 'set -x FZF_DEFAULT_COMMAND "rg --files --hidden --smart-case --follow --glob \"!venv/*\" --glob \"!.venv/*\" --glob \"!.git/*\""'

 'alias vim="nvim.appimage"'
 'alias winpy="wine64 /home/$(whoami)/.wine/drive_c/Python310/python.exe"'
 'alias ls="colorls $colorls_theme"'
 'alias ll="colorls $colorls_theme -lh"'
 'alias la="colorls $colorls_theme -lah"'
 'alias m="systemctl restart minidlna"'
 'alias tree="tree -a -I .git"'
 'alias fzf="fzf $fzf_theme"'
 'alias ping="ping -nc4"'
 'alias cat="batcat"'
 'alias rm="rm -rf"'
 # ===========
 # Git aliases
 # ===========
 'alias gl="git log --oneline --decorate"'
 'alias gs="git status"'
 'alias gaAll="git add -A"'
 'alias ga="git add"'
 'alias gc="git commit"'
 'alias gr="git rm"'
 'alias grOnlyFromGit="git rm --cached"'
 'alias gm="git mv"'
 'alias gunstage="git restore --staged"'
 'alias gamend="git commit --amend"'
 'alias gdiscard="git restore"'
 'alias gclone="git clone"'
 'alias gpullOriginMain="git pull origin main"'
 'alias gpullOriginMaster="git pull origin master"'
 'alias gpushOriginMain="git push origin main"'
 'alias gpushOriginMaster="git push origin master"'
 'alias gtagList="git tag -l"'
 'alias gtagCreate="git tag -a"'
 'alias gshow="git show"'
 'alias pip="pip --proxy 127.0.0.1:20171"'
)
# ===================
# Change shell to fish
# ===================
chsh -s /usr/bin/fish

# =============================================
# Add the array content into .bashrc and .zshrc
# =============================================
for i in ${arr_things_should_be_added_to_bashrc_and_zshrc[@]}; do
    echo "$i" >> ~/.zshrc
done
# for i in ${arr_things_should_be_added_to_fish[@]}; do
#     echo "$i" >> "${folder_of_script}"/fish/config.fish
# done
IFS=oldIFS
#source $(type p10k | sed -E '$s$.*from (.*)$\1$')

tldr --update
# # ===========
# # Install fzf
# # ===========
# git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# ~/.fzf/install
# exec zsh



# # Installing the LazyVim
# mv ~/.config/nvim{,.bak}
# mv ~/.local/share/nvim{,.bak}
# mv ~/.local/state/nvim{,.bak}
# mv ~/.cache/nvim{,.bak}
# git clone https://github.com/LazyVim/starter ~/.config/nvim
# rm -rf ~/.config/nvim/.git

# hide firefox tab bar
"${folder_of_script}"/hide_tabs_in_firefox.sh

mkdir -p "${home_folder}"/.config/zellij
mkdir -p "${home_folder}"/.config/dunst
# ================================================
# Create symlinks for config files of applications
# ================================================
ln -sf "${folder_of_script}"/ranger_configs "${home_folder}"/.config/ranger
ln -sf "${folder_of_script}"/mpv_ "${home_folder}"/.config/mpv
ln -sf "${folder_of_script}"/ranger "${home_folder}"/.local/lib/python3.10/site-packages/ranger
ln -sf "${folder_of_script}"/qtile "${home_folder}"/.config/qtile
ln -sf "${folder_of_script}"/fish "${home_folder}"/.config/fish
ln -sf "${folder_of_script}"/.SpaceVim "${home_folder}"/.SpaceVim
ln -sf "${folder_of_script}"/.SpaceVim.d "${home_folder}"/.SpaceVim.d
ln -sf "${folder_of_script}"/.SpaceVim "${home_folder}"/.config/nvim
ln -sf "${folder_of_script}"/.alacritty.toml "${home_folder}"/.alacritty.toml
ln -sf "${folder_of_script}"/dunstrc "${home_folder}"/.config/dunst/dunstrc
ln -sf "${folder_of_script}"/zellij_config/config.kdl "${home_folder}"/.config/zellij/config.kdl
sudo ln -sf "${folder_of_script}"/20-tearfree-xorg.conf "/etc/X11/xorg.conf.d/20-tearfree-xorg.conf"
# ===========================================
# Install Python modules for qtile and ranger
# ===========================================
pip install xcffib
pip install qtile
pip install pulsectl_asyncio
pip install pyxdg
pip install dbus-next
pip install ranger-fm
pip install jdatetime
pip install rich

# this will update the locate database for searching files
# TIP: you can use locate file_name | fzf to fuzzy find on results of the locate
sudo updatedb
