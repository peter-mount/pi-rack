#!/bin/bash
#
# Generates the custom side-bracket I use to mount into an existing rack.
#
#

GENERATED="// Generated $(date)"

TITLE="// Custom rack mount"
USE="use <../../../components/side-bracket.scad>;"
FILENAME="custom-sidebracket"

DIRNAME=$(echo ${FILENAME}|tr - /)
mkdir -pv ${DIRNAME}
FILENAME="${DIRNAME}/${FILENAME}"

(
  echo "$TITLE"
  echo "$GENERATED"
  echo "$USE"
  echo "for ( n = [0:1] ) {"
  echo "    rotate( [0, 0, 180*n] )"
  echo "    translate([ -40*n, -70*n, 0 ])"
  echo "    union() {"
  echo "        roundHolder(0, n);"
  echo "        translate([5,0,0]) roundHolder(1, n);"
  echo "    }"
  echo "}"
) >"${FILENAME}.scad"
