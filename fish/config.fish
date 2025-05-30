if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
end
alias vim="nvim.appimage"
alias nvim="nvim.appimage"
alias winpy="wine64 /home/$(whoami)/.wine/drive_c/Python310/python.exe"
alias ls="lsd --hyperlink auto"
alias ll="lsd -lh --hyperlink auto"
alias la="lsd -lah --hyperlink auto"
alias m="systemctl restart minidlna"
alias tree="tree -a -I .git"
alias clock="tty-clock -B -C 7"
alias fzf="fzf $fzf_theme"
alias fcd="cd (dirname (fzf))"
alias ping="ping -nc4"
alias ranger="ranger.py"
alias cat="bat"
alias rm="rm -rf"
alias gl="git log --oneline --decorate"
alias gs="git status"
alias gaAll="git add -A"
alias ga="git add"
alias gc="git commit"
alias gr="git rm"
alias grOnlyFromGit="git rm --cached"
alias gm="git mv"
alias gunstage="git restore --staged"
alias gamend="git commit --amend"
alias gdiscard="git restore"
alias gclone="git clone"
alias gpullOriginMain="git pull origin main"
alias gpullOriginMaster="git pull origin master"
alias gpushOriginMain="git push origin main"
alias gpushOriginMaster="git push origin master"
alias gtagList="git tag -l"
alias gtagCreate="git tag -a"
alias gshow="git show"
alias p="proxychains4 -q -f ~/bin/proxychain.conf"
alias ag="ag --search-binary -f --hidden --no-group --ignore='*.m4a' --ignore='*.webm' --ignore='*.flatpak' --ignore='*.deb' --ignore='*.appimage' --ignore='*.mp4' --ignore='*.mkv' --ignore='*.mp3' --ignore='*.iso'"
set fish_key_bindings fish_user_key_bindings
# set -gx LD_LIBRARY_PATH "~/bin/luajit/lib:$LD_LIBRARY_PATH"
#fish_add_path -p ~/bin/luajit/bin
fish_add_path -p ~/bin
fish_add_path -p ~/.local/bin
fish_add_path -p ~/Downloads/ollama/bin
set -x PATH "/home/$(whoami)/bin:/home/$(whoami)/.fzf/bin:$PATH:/home/$(whoami)/bin/ranger-1.9.4"
# set -x colorls_theme "--dark"
set -x RANGER_LOAD_DEFAULT_RC FALSE
set -x BAT_THEME Dracula
set -x ANDROID_EMULATOR_USE_SYSTEM_LIBS 1
set -x JAVA_HOME ""
set -x EDITOR "$HOME/bin/nvim.appimage"
set -x fzf_theme "--color=16"
set -x FZF_DEFAULT_OPTS "--preview 'bat --color=always {}'"
set -x FZF_DEFAULT_COMMAND "rg --files --hidden --smart-case --follow --glob \"!.*__pycache__/*\" --glob \"!venv/*\" --glob \"!.venv/*\" --glob \"!.git/*\""
# set -x SUDO_ASKPASS (which ssh-askpass)
