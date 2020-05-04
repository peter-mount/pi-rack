#!/bin/bash
#
# Generates the cable trays
#
#

GENERATED="// Generated $(date)"

TITLE="// Cable tray"
USE="use <../../components/cabletray.scad>;"
FILENAME="cabletray"

DIRNAME=$(echo ${FILENAME}|tr - /)
mkdir -pv ${DIRNAME}
FILENAME="${DIRNAME}/${FILENAME}"

for widthU in 2 3 4 5
do
  for depth in 120 150 180
  do
    (
      echo "$TITLE ${widthU}U wide"
      echo "$GENERATED"
      echo "$USE"
      echo "cableTray(${widthU},${depth});"
    ) >"${FILENAME}-${widthU}x${depth}.scad"
    done
done
