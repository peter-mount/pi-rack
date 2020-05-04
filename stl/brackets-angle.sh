#!/bin/bash
#
# Generates the brackets-angle suite of openscad files
#

GENERATED="// Generated $(date)"

TITLE="// 90 degree bracket"
USE="use <../../../components/brackets.scad>;"
FILENAME="brackets-angle"

DIRNAME=$(echo ${FILENAME}|tr - /)
mkdir -pv ${DIRNAME}
FILENAME="${DIRNAME}/${FILENAME}"

for thick in 2 3
do
    # height=15 for 2.5mm thick & 20 for 3mm thick brackets
    if [ $thick -ge 3 ]
    then
      height=20
    else
      height=15
      thick=2.5 # -ge above only works for integers
    fi
    sep=$((height+7))

  # Width of bracket in U
  for widthU in 2 3 4 5
  do
    # Width of bracket in mm
    width=$((30*widthU))

    HEADER=$(
      echo "$TITLE ${thick}mm thick & ${widthU}U (${width}mm) wide"
      echo "$GENERATED"
      echo "$USE"
    )

    # Create models for 1..4 per print
    for num in 1 2 3 4
    do
      (
        echo "$HEADER"
        comp=0
        while [ $comp -le $num ]
        do
          echo "translate([0,$((comp*sep)),0])"
          echo "  AngleBracket(${width},${height},${thick});"
          comp=$((comp+1))
        done
      ) >"${FILENAME}-${thick}-${widthU}-${num}.scad"
    done
  done
done
