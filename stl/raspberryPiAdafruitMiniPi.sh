#!/bin/bash
#
# Generates the brackets-90 suite of openscad files
#

GENERATED="// Generated $(date)"

TITLE="// Raspberry PI tray with Adafruit Mini PI TFT screen"
USE="use <../../../components/raspberryPiAdafruitMiniPi.scad>;"
FILENAME="raspberrypi"

DIRNAME=$(echo ${FILENAME}|tr - /)

for widthU in 1 2 3 4 5
do
  PROJECT="adafruitMiniPi"
  mkdir -pv "${DIRNAME}/${PROJECT}"
  (
    echo "$TITLE ${widthU}U plain"
    echo "$GENERATED"
    echo "$USE"
    echo "RaspberryPI_adafruitMiniPiTft135_240();"
  ) >"${DIRNAME}/${PROJECT}/${FILENAME}-${PROJECT}.scad"
done
