#! /bin/bash

trap "echo 'catching ctrl-c'; exit 0" 2

while true; do
  # record a minute of audio
  echo ""
  echo "Recording a minute of audio..."
  sox -d cf.wav trim 0 30

  # find the average amplitude
  LOUDNESS=$(sox cf.wav -n stat 2>&1 | sed -n '9p' | awk '{ print $3 }')

  curl -X PUT localhost:9292/loudness -d "loudness=${LOUDNESS}"

  curl localhost:9292

  echo $RANDOM | cut -c1-3 | xargs sleep
done
