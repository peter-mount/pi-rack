#!/bin/bash
#
# Generates the brackets-90 suite of openscad files
#

GENERATED="// Generated $(date)"

TITLE="// 90 degree bracket"
USE="use <../../../components/brackets.scad>;"
FILENAME="brackets-90"

DIRNAME=$(echo ${FILENAME}|tr - /)
mkdir -pv ${DIRNAME}
FILENAME="${DIRNAME}/${FILENAME}"

for thick in 2 3 4
do
  for holex in 2 3 4 5
  do
    for holey in 2 3 4 5
    do
      # Reduce number of runs as you can just rotate the final item when using it
      if [ $holey -le $holex ]
      then
        HEADER=$(
          echo "$TITLE ${thick}mm thick & ${holex}x${holey} bolt holes"
          echo "$GENERATED"
          echo "$USE"
        )

        # The single component
        (
          echo "$TITLE"
          echo "$GENERATED"
          echo "$USE"
          echo "bracket90(${thick},${holex},${holey});"
        ) >"${FILENAME}-${thick}-${holex}x${holey}-1.scad"

        # The combination component
        Fx=$(((holex*10)+10))
        Fy=$(((holey*10)+10))
        X=4
        Y=3
        if [ $holex -ge 5 ]; then X=2; fi
        if [ $holey -ge 5 ]; then Y=2; fi
        N=$((X*Y))
        (
          echo "$TITLE"
          echo "$GENERATED"
          echo "$USE"
          echo "for(x=[0:${X}]) {"
          echo "  for(y=[0:${Y}]) {"
          echo "    translate([${Fx}*x,${Fy}*y,0])"
          echo "      bracket90(${thick},${holex},${holey});"
          echo "  }"
          echo "}"
        ) >"${FILENAME}-${thick}-${holex}x${holey}-${N}.scad"
      fi
    done
  done
done
