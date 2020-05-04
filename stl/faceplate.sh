#!/bin/bash
#
# Generates the blank faceplates.
#
# This is not those used by actual devices as they import faceplate as part of their
# models. These are usually used to fill in unused gaps within a rack.
#

GENERATED="// Generated $(date)"

TITLE="// Blank face plate"
USE="use <../../components/faceplate.scad>;"
FILENAME="faceplate"

DIRNAME=$(echo ${FILENAME}|tr - /)
mkdir -pv ${DIRNAME}
FILENAME="${DIRNAME}/${FILENAME}"

for widthU in 1 2 3 4 5
do
  (
    echo "$TITLE ${widthU}U wide"
    echo "$GENERATED"
    echo "$LICENCE"
    echo "$USE"
    echo "FacePlate(${widthU});"
  ) >"${FILENAME}-${widthU}.scad"
done
