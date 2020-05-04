/*
 * This code is licensed under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike).
 * Please read LICENCE.md for full details.
 *
 * Cable tray
 *
 * The cable tray mounts to the bottom angle bracket
 * and provides a barrier to stop cables from the rack
 * from hanging down into the space below.
 *
 * Due to how it's mounted it can be used to attach the
 * top angle bracket for the next row down.
 *
 * It can also be used as a basic top cover if required.
 *
 */

use <warpDisk.scad>;
use <boltHoles.scad>;

/*
 * Generate a cable tray
 *  u   Width of tray in U
 *  d   Depth of tray in mm
 */
module cableTray(u=5, d=120) {
    w=30*u; // Width of tray in mm
    h=5;    // Max height of tray
    gh1=20; // Height of grid
    gh2=15; // Height of grid in centre

    // Front mounting grid
    difference() {
        cube([w,d,5]);

        for(x=[0:(3*u)-1]) {
            if( (x%3)==0 || x==(3*u)-1 ) {
            translate([5+(10*x),15,0])
                MHole(4,5);
            translate([5+(10*x),d-7.5,0])
                MHole(4,5);
            }
        }

        for(x=[3:(d/10)-3]) {
            if( (x%3)==0 ) {
                translate([5, 5+(10*x),0])
                    MHole(4,5);
                translate([w-5, 5+(10*x),0])
                    MHole(4,5);
            }
        }

    }

    // Warp disks to stop the print warping
    WarpDisk( -2, -2,0);
    WarpDisk(w+2, -2,0);
    WarpDisk( -2,d+2,0);
    WarpDisk(w+2,d+2,0);

}

cableTray(); //5,250);
