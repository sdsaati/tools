function f
# this is a find for files and folders
    set file (fzf --preview 'bat --style=numbers --color=always --line-range=:500 {}' --height 40%)
    if test -n "$file"
        echo (realpath $file)
    end
end
