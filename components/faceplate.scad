/*
 * This code is licensed under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike).
 * Please read LICENCE.md for full details.
 *
 * Faceplates
 *
 */

use <boltHoles.scad>;

rack1UWidth=30;
rack1UHeight=90;
rack1UHmargin=20;
facePlateThickness=5;

/*
 * Basic faceplate placed in the correct location & mounting holes present.
 *
 * width    width in U
 * height   height in U, default 1
 * holes    custom hole position as a vector. Default [1] for width=1, or [1,3w-1] for width >=2
 */
module FacePlate(width, height=1, holes, fpt=facePlateThickness) {
    // Number & position of mounting holes
    holeStep = holes ? holes : width < 2 ? [1] : [1,(3*width)-2];
    h = (2*rack1UHmargin) + (height*rack1UHeight);

    translate([ -rack1UHmargin, -fpt, 0])
        difference() {
            cube([ h,
                   fpt,
                   width * rack1UWidth ]);

            for( x = holeStep ) {
                translate([10, 5, 5+(10*x)])
                    rotate([90,0,0])
                    MHole(4, fpt+2);

                translate([(height*rack1UHeight)+rack1UHmargin+10, 5, 5+(10*x)])
                    rotate([90,0,0])
                    MHole(4, fpt+2);
            }
        }
}
