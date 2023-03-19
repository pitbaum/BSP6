#!/bin/bash

# two arguments - video file, output directory path
# example - ./extract_left_right.sh chair001.m2ts /tmp/chair001/
if [ $# -ne 2 ];then
    echo "script expects two arguments - video file and output directory path";
    exit;
fi

# extract stereo frames using mplayer
mplayer -vo pnm:pgmyuv:outdir=${2} ${1} 

# If your matlab binary is not in $PATH then you can set its path in the following variable "$matlabpath"
matlabpath=matlab

# extract left and right channel using the matlab script
${matlabpath} -nodesktop -nojvm -nosplash -r "split_interlaced_stereo_frames_2('${2}'); exit";


# report bugs to nagaraja@cs.uni-freiburg.de
