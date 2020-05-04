#!/bin/bash
#
# Generates the brackets-90 suite of openscad files
#

GENERATED="// Generated $(date)"

TITLE="// Raspberry PI tray"
USE="use <../../../components/raspberryPiTray.scad>;"
FILENAME="raspberrypi"

DIRNAME=$(echo ${FILENAME}|tr - /)

for widthU in 1 2 3 4 5
do
  mkdir -pv "${DIRNAME}/plain"
  (
    echo "$TITLE ${widthU}U plain"
    echo "$GENERATED"
    echo "$USE"
    echo "RaspberryPI(${widthU});"
  ) >"${DIRNAME}/plain/${FILENAME}-plain-${widthU}.scad"

  mkdir -pv "${DIRNAME}//led"
  (
    echo "$TITLE ${widthU}U 3mm leds"
    echo "$GENERATED"
    echo "$USE"
    echo "RaspberryPI_3mLed(${widthU});"
  ) >"${DIRNAME}/led/${FILENAME}-led-${widthU}-3.scad"
done
