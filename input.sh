#! /bin/bash

trap "echo 'catching ctrl-c'; exit 0" 2

while true; do
  # record a minute of audio
  echo 'Recording a minute of audio...'
  sox -d cf.wav trim 0 60

  echo $RANDOM | cut -c1-3 | sleep

  # find the average amplitude
  sox cf.wav -n stat 2>&1 | sed -n '9p' | awk '{ print $3 }' >> loudness
done
