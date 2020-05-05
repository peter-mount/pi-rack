#!/bin/bash
#
# This generates all of the scad files in this directory
#

export LICENCE=$(
  echo "// This code is licensed under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike)."
  echo "// Please read LICENCE.md for full details."
)

./brackets-angle.sh
./brackets-straight.sh
./brackets-90.sh
./cabletray.sh
./faceplate.sh
./raspberryPi.sh
./raspberryPiAdafruitMiniPi.sh
./side-bracket.sh
