#!/usr/bin/env bash
# $#: number of parameters
# shift: decrease $# and $[num]
# just a cool sed tutorial ;) sed 's|$|<br/>|' testfile 


# ===========================
help="$(cat <<EOF
minify the css, html, and javascript
=============================
Usage:
 minify.sh file1.css file2.css ...
    OR
 minify.sh file1.js file2.js ...
    OR
 minify.sh file1.html file2.html ...  
=============================
-h --help        show this help message
-o --output name save the output in the name file
-O --stdout      show the result on the stdout instead of saving on the file
-v --version     print the version
EOF
)"


# ===========================
# default values
# ===========================
version="1.0.0"
to_stdout=0
output='./mini.html' 
files=() 
mini_files=()


# ===========================
# For each file passed to us
# ===========================
while [[ "$#" -gt 0 ]]; do
    case $1 in

        -h | --help)
            echo -e "$help"
            ;;

        -o | --output)
            output="$2"
            shift  # because we got the $2, we don't want to process it again
            ;;

        -O | --stdout)
            to_stdout=1
            ;;

        -v | --version)
            echo -e "$version"
            ;; 

        *)
            # push all files into files array
            files+=("${1}") 
            #declare -p files # this dump the array contents to see what we have
            ;; 
    esac
    shift
done 
#echo -e "parameters:\nto_stdout=${to_stdout}\noutput=${output}\nfiles=${files[@]}\n"



# ===========================
# Compress function
# =========================== 
function do_minify {
    # PATTERNS
    #remove_nullbyte="~\\0*~~gm"
    not_inside_tags_and_quotes="(\\s*\"*[^\"]*\"*\\s*)|(<.*>)|(>[^<]*<)|(\\s*'\\''[^'\\'']*'\\''\\s*)|"
    remove_multiline_comments="~\/\\*.*\\*\/~~gm"
#   remove_inline_comments="~([^\\\:\"])\\s*//(.*)$~\\1\\2~gm"
#    remove_inline_comments="~(^//.*$|\\s+//.*$)|//.*~\\1~gm"
    remove_html_comments="~<!--.*-->~ ~gm"
    remove_empty_lines="/^\\s*$/d"
    remove_first_whitespaces="~^\\s*~~gm"
    remove_last_whitespaces="~\\s*$~~gm" 
#   whitespace_gt="~$not_inside_tags_and_quotes\\s*(>\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_lt="~$not_inside_tags_and_quotes(\\s*<)\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_semicolor="~$not_inside_tags_and_quotes\\s*(;\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_open_parantesis="~$not_inside_tags_and_quotes\\s*(\()\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_close_parantesis="~$not_inside_tags_and_quotes\\s*(\))\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_plus="~$not_inside_tags_and_quotes\\s*(\\+)\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_multiple="~$not_inside_tags_and_quotes\\s*(\\*)\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_divide="~$not_inside_tags_and_quotes(\\s*/\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_minus="~$not_inside_tags_and_quotes(\\s*\\-\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_double_qoutes="~$not_inside_tags_and_quotes(\\s*\"\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_single_qoutes="~$not_inside_tags_and_quotes(\\s*\\'\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_equal="~$not_inside_tags_and_quotes(\\s*=\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_sharp="~$not_inside_tags_and_quotes(\\s*#\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_backtick="~$not_inside_tags_and_quotes\\s*(\\\`\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_isign="~$not_inside_tags_and_quotes(\\s*!\\s*)~\\1\\2\\3\\4\\5~gm"
#   whitespace_shifttilda="|(\\s*~\\s*)|\\1|gm"
#   whitespace_atsign="~$not_inside_tags_and_quotes\\s*(@)\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_ampersign="~$not_inside_tags_and_quotes(\\s*&)\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_or="~(\\s*\\|\\s*)~\\1~gm"
#   whitespace_comma="~$not_inside_tags_and_quotes\\s*(,)\\s*~\\1\\2\\3\\4\\5~gm"
#   whitespace_hat="~(\\s*\\^\\'s*)~\\1~gm"
#   whitespace_dolor="~(\\s*\\$\\s*)~\\1~gm"
    remove_extra_whitespaces="~$not_inside_tags_and_quotes(\\s)\\s*~\\1\\2\\3\\4\\5~gm"
    php_start="~\\s*<\\?=\\s*~<?= ~gm"
    php_start_alt="~\\s*<\\?=\\s*~<?= ~gm"
    php_end="~\\s*\\?>\\s*~ ?>~gm"
#    correct_html="~((\\s*)\\&[^;&]*;(\\s*))~\\2\\1\\3~gm" 
    # STEP ONE
    step1=$(cat "$1" | iconv -f latin1 -t UTF-8 | LANG=en_US.UTF-8 sed -E  -e "s$remove_multiline_comments" -e "s$remove_html_comments" -e '/^\s*\/\/\s*/d' -e 's@[[:blank:]]\{1,\}//.*@@' -e "$remove_empty_lines" -e "s$remove_first_whitespaces" -e "s$remove_last_whitespaces") 
    # STEP TWO
    step2=$(echo -n "$step1" | iconv -f latin1 -t UTF-8 | tr '\r\n' ' ') 
    # STEP THREE
    step3=$(echo -n "$step2" | iconv -f latin1 -t UTF-8 | LANG=en_US.UTF-8 sed -E -e "s$remove_extra_whitespaces" -e "s$php_start" -e "s$php_start_alt" -e "s$php_end")
    # FINAL STEP
    mini_files+=("$step3")
}
# 

# ===========================
# should save in file or print on stdout?
# ===========================
if [ ! $to_stdout -eq 1 ]; then # save on file
    for i in "${files[@]}"
    do
        echo -e "we are in file $i and before minify\n"
        do_minify "$i"
        echo -e "we are in file $i and after minify\n"
    done 
    echo -n "${mini_files[@]}" | tr '\r\n' ' ' | iconv -f latin1 -t UTF-8 > "$output" 
else # print on stdout
    for i in "${files[@]}"
    do
        echo -e "we are in file $i and before minify stdout\n"
        do_minify "$i"
        echo -e "we are in file $i and after minify stdout\n"
    done 
    echo -n "${mini_files[@]}" | tr '\r\n' ' '
fi


