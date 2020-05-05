#!/bin/bash
#
# Generate the various scad files for various components then PNG & STL files.
#
# Run this from within the stl directory.
#
rm -rf */

./generate-scad.sh
./generate-stl.sh

