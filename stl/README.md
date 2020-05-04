# PI Rack STL's
This directory contains the OpenSCAD scripts that generate the individual STL's ready for printing.

## File name conventions
The file naming conventions are:

    type-subtype-other-size-number.scad

Where:

| Filename | Content |
| -------- | ------- |
| type | The source scad file under components this file relates to |
| subtyppe | When type has multiple components or a component has multiple variants |
| other | Optional, other characteristic like thickness |
| size | The size of the component. Can be either in U or mm |
| number | Optional, some STL's can have multiple copies of the component in one print which can be more efficient. |

The other, size & number fields are optional. If they represent multiple dimensions then they should be comma delimited.

## Generating the files

All of the scad files in this directory are generated from bash scripts.
This is done to remove the possibility of errors when generating repetitive code.
