#!/usr/bin/env bash
# YOU SHOULD INSTALL IMAGEMAGICK and OPTIPNG and JPEGOPTIM FIRST :)
# ===========================
# Usage: sprite.sh images ...
# ===========================

# ============================
# let's use some colors :)
# ============================
path_of_here=$(dirname "$0")
source "${path_of_here}/colors.sh"


# ============================
# JPG or PNG ?
# ============================
echo -e "${txtblu}PNG(0)${resetcolor} or ${txtgrn}JPG(1)${resetcolor}? 0/1? default:0"
read ext 
ext=${ext:-0}


# ============================
# Initializing variables
# ============================
output_text="sprite_imgs/sprite.txt"
output_name="sprite_imgs/sprite.png"
tile="5x" # it means the rows is empty (not like 5x6 => we remove 6 that means unlimit)
#direction=""
output=""
width=0
oldwidth=0
oldheight=0
height=0
maxheight=0
count=0
row=0

# ============================
# For each image inside sprite get WxH+X+Y
# ============================
for i in "$@"
do
    if [ $(( $count % 5 )) -eq 0 ]; then
        row=$(( ${row} + 1 ))
        if [ $count -eq 0 ]; then 
            output+="Row${row} ---- \n"  
        else
            output+="\nRow${row} ---- \n"  
        fi
        oldwidth=0
        width=0
        oldheight=$(( (${row}-1)*$maxheight ))
    fi 
    if [ ${maxheight} -ge ${height} ]; then
        maxheight=${maxheight}
    else
        maxheight=${height}
    fi
    oldwidth=$(( ${oldwidth}+${width} ))
    height=$(identify -format "%h" "$i")
    width=$(identify -format "%w" "$i")
    output+="${width}x${height}+${oldwidth}+${oldheight}\t" 

    count=$(( ${count}+1 ))
done

# ============================
# let's delete the last outputs and make a folder if not exists
# ============================
rm "${output_name}" 2>/dev/null;rm "${output_text}" 2>/dev/null; mkdir "./sprite_imgs" 2>/dev/null;

# ============================
# for using convert:
# ============================
# ask user to check if we have to make a vertical or horizontal sprite image
#echo -e "Do you want a ${txtgrn}vertical[1]${resetcolor} sprite or ${txtblu}horizontal[2]${resetcolor} sprite?"
#read vertical

#if [ ${vertical} -eq 1 ]; then
#direction=" -append "
#else
#direction=" +append "
#fi
#-geometry 128x128+0+0 
# ============================


# ============================
# The actual command :)
# ============================
if [ ${ext} -eq 0 ]; then # 0=png   1=jpg
    output_name="sprite_imgs/sprite.png"
    montage "${@}" -tile ${tile} -geometry +0 -pointsize 10 +repage -background transparent  ${output_name} && optipng -o7 "${output_name}"
    #montage "${@}" -tile ${tile} -geometry +0 -pointsize 10 +repage -set label '%wx%h\n%[X]\n%[fx:printsize.x]\n%[fx:(t-2)?s[t-2].w+s[t-1].w:s[t].w]\n\n\n\n' +repage -background transparent  ${output_name} && optipng -o7 "${output_name}"
else
    output_name="sprite_imgs/sprite.jpg"
    montage "${@}" -tile ${tile} -geometry +0 -pointsize 10 +repage -background transparent  ${output_name} && jpegoptim "${output_name}"
fi 

# ============================
# Write the geo.txt file
# ============================
echo -e "${output}" > "${output_text}"
