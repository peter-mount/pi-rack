#!/bin/bash
#
# Generates STL's from all generated models.
#
# The output of this is large, over 200Mb of STL's and PNG iamges.
#

for scad in $(find -name "*.scad")
do
  (
    cd $(dirname ${scad})
    src=$(basename ${scad})
    for type in png stl
    do
      out=$(basename ${scad} .scad).${type}
      echo Generating ${out}
      openscad \
        --o ${out} \
        --autocenter \
        --viewall \
        ${src}
    done
  )
done
