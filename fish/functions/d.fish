function d
# this is a find for files and folders
    set directory (fzf --preview 'bat --style=numbers --color=always --line-range=:500 {}' --height 40%)
    if test -n "$directory"
        echo (realpath (dirname $directory))
    end
end
