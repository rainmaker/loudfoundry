#! /bin/bash

set -x

# record a minute of audio
sox -d cf.wav trim 0 60

# find the average amplitude
sox cf.wav -n stat 2>&1 | sed -n '9p' | awk '{ print $3 }' >> loudness
