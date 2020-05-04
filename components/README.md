# PI Rack Components
This directory contains the source for all the individual parts.

All the files are written in OpenSCAD and define modules which are then used to form the various components.
Even the components are modules so they can be included within other modules.

See the STL directory for how the final STL's are generated to see how this works.

## Utilities
These files contain modules used by the others:

| File | Content |
| ----- | ----- |
| boltHoles.scad | modules for creating bolt holes within a component. |
| led.scad | modules for creating holes to hold LED's |
| warpDisk.scad | module used to add anti-warp disks to a model to ensure that when printing corners do not warp off the print bed. |

## General components
These are generic components which can be reused for various projects:

| File | Content |
| ----- | ----- |

## Rack components
These components form the racking system:

| File | Content |
| ----- | ----- |
