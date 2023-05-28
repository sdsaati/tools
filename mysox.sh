#!/bin/env bash
# seq start step end
startHz=1
step=50
endHz=500
width=15h
Hz=($(seq $startHz $step $endHz))
after=soxOutput
before=soxInput
outExt=mp4
progressbar=##

echo -ne "\n=============Converting================\n${progressbar}\r"
ffmpeg -y -i "${1}" soxNoisered.wav > /dev/null 2>&1

# sox in.ext out.ext trim {start: s.ms} {duration: s.ms}
sox soxNoisered.wav noise-audio.wav trim 0 0.400
progressbar+=##
# generate noise profile
echo -ne "${progressbar}\r"
sox noise-audio.wav -n noiseprof noise.prof
progressbar+=###
# remove noise
echo -ne "${progressbar}\r"
sox soxNoisered.wav soxInput.wav noisered noise.prof 0.3
progressbar+=##
# remove noisy audio
echo -ne "${progressbar}\r"
rm soxNoisered.wav 
rm noise-audio.wav
rm noise.prof
progressbar+=#
echo -ne "${progressbar}\r"

progressbar+=#
echo -ne "${progressbar}\r"
for i in "${Hz[@]}"
do
    progressbar+=##
    sox "${before}.wav" "${after}${i}.wav" bandreject ${i} ${width} && rm "${before}.wav" > /dev/null 2>&1
    # echo -e "${before}.wav" "${after}${i}.wav \n" 
    before="${after}${i}"
    echo -ne "${progressbar}\r"
done 
progressbar+=##
ffmpeg -y -i "$1" -i ${after}*.wav -map 0:v -map 1:a -c:v copy -c:a aac -b:a 128k Cleared"${1}".${outExt} > /dev/null 2>&1
rm ${after}*.wav
progressbar+=##
echo -e "${progressbar}\r\nFinished 100%"

