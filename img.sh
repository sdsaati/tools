#!/usr/bin/env bash
# YOU SHOULD INSTALL IMAGEMAGICK and OPTIPNG and JPEGOPTIM FIRST :)
# ===========================
# Usage: img.sh images ...
# ===========================

# ===========================
# initialize variables
# ===========================
echo 'PNG(0) or JPG(1)? 0/1? default:0'
read ext 
ext=${ext:-0}

echo 'Please enter the size of the images ex: 200x200:'
read size # this will resize the image to this size (\> means only if the original image is bigger than this size)

echo 'change aspect ratio or not? (if 1, images have same size) 0/1? default:1'
read aspect
aspect=${aspect:-1}

echo 'Should we convert only bigger images than the size you entered? 0/1? default:1'
read onlybigger
onlybigger=${onlybigger:-1}

# ===========================
# For each file passed to us
# ===========================
for i in "${@}"
do
    output_name="./converted_imgs/${i}"
    density="300"
    depth="48"
    liquid_rescale="${size}"
    aspectcharacter=''
    onlybiggercharacter=''

# ===========================
# force aspect ratio?
# ===========================
if [ ${aspect} -eq 1 ]; then
    aspectcharacter='!'
else
    aspectcharacter=""
fi

# ===========================
# convert only bigger pictures?
# ===========================
if [ ${onlybigger} -eq 1 ]; then
    onlybiggercharacter='>'
else
    onlybiggercharacter=""
fi


# ===========================
# Compress function
# =========================== 
function Compress() {
    if [ ${ext} -eq 0 ]; then # 0=png   1=jpg

        rm "${output_name}.png" 2>/dev/null; mkdir "./converted_imgs" 2>/dev/null; convert "${i}" -depth ${depth} -density ${density} -resize ${size}"${aspectcharacter}${onlybiggercharacter}" -liquid-rescale ${liquid_rescale} "${output_name}.png" && optipng -o9 "${output_name}.png" 

    else
        rm "${output_name}.jpg" 2>/dev/null; mkdir "./converted_imgs" 2>/dev/null; convert "${i}" -depth ${depth} -density ${density} -resize ${size}"${aspectcharacter}${onlybiggercharacter}" -liquid-rescale ${liquid_rescale} "${output_name}.jpg" && jpegoptim "${output_name}.jpg" 
    fi 
}


# ===========================
# the actuall command :)
# ===========================
Compress

done
