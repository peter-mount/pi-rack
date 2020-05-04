#!/bin/bash
#
# Generates the brackets-straight suite of openscad files
#

GENERATED="// Generated $(date)"

TITLE="// Straight bracket"
USE="use <../components/brackets.scad>;"
FILENAME="brackets-straight"

DIRNAME=$(echo ${FILENAME}|tr - /)
mkdir -pv ${DIRNAME}
FILENAME="${DIRNAME}/${FILENAME}"

for thick in 2 3
do
  for holes in 2 3 4 5
  do
    HEADER=$(
      echo "$TITLE ${thick}mm thick & ${holes} bolt holes"
      echo "$GENERATED"
      echo "$LICENCE"
      echo "$USE"
    )

    # The single component
    (
      echo "$HEADER"
      echo "bracketStraight(${thick},${holes});"
    ) >"${FILENAME}-${thick}-${holes}-1.scad"

    # The combination component
    F=$(((holes*10)+10))
    X=4
    Y=3
    if [ $holes -ge 5 ]; then X=2;Y=5; fi
    N=$((X*Y))
    (
      echo "$HEADER"
      echo "for(x=[0:${X}]) {"
      echo "  for(y=[0:${Y}]) {"
      echo "    translate([${F}*x,15*y,0])"
      echo "      bracketStraight(3,${holes});"
      echo "  }"
      echo "}"
    ) >"${FILENAME}-${thick}-${holes}-${N}.scad"
  done
done

