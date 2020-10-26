/*
 * This code is licensed under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike).
 * Please read LICENCE.md for full details.
 *
 * Generic brackets
 */

use <warpDisk.scad>;
use <boltHoles.scad>;

/*
 * Straight bracket
 *
 *  t   Thickness in mm, default 3mm
 *  nx  number of holes on x axis
 *  ny  number of holes on y axis
 */
module bracketStraight(t=3, nx=2) {
    difference() {
        union() {
            cube([10*nx,10,  t]);
            WarpDisk(-2,-2,0);
            WarpDisk((10*nx)+3,-2,0);
            WarpDisk((10*nx)+3,12,0);
            WarpDisk(-2,12,0);
        }
        for(x=[0:nx-1]) {
            translate([ 5+(10*x), 5,0])
                MHole(4,t);
        }
    }
}

/*
 * 90 degree bracket
 *
 *  t   Thickness in mm, default 3mm
 *  nx  number of holes on x axis
 *  ny  number of holes on y axis
 */
module bracket90(t=3, nx=2, ny=2) {
    difference() {
        union() {
            cube([10,  10*ny,t]);
            cube([10*nx,10,  t]);
            WarpDisk(-2,-2,0);
            WarpDisk((10*nx)+3,-2,0);
            WarpDisk((10*nx)+3,12,0);
            WarpDisk(-2,(10*ny)+3,0);
            WarpDisk(12,(10*ny)+3,0);
        }
        for(x=[0:nx-1]) {
            translate([ 5+(10*x), 5,0])
                MHole(4,t);
        }
        for(y=[1:ny-1]) {
            translate([ 5, 5+(10*y),0])
                MHole(4,t);
        }
    }
}

/*
 * An angle bracket used in a frame with slotted bolt holes
 *
 * width        Width of the bracket, usually 150mm for a full length
 * height       Height of bracket, usually 20mm
 * thickness    Thickness, usually 5mm
 */
module AngleBracket(width, height, thickness) {
    baseOffset = thickness+1;
    topOffset = thickness-2;
    boltSize = 4; // M4

    // Base
    translate([0,0, thickness/2])
        SlottedBar( width, height, thickness, boltSize, baseOffset, topOffset);

    // Upright
    translate([0, -(height-thickness)/2, height/2])
    rotate([90,0,0])
        SlottedBar( width, height, thickness, boltSize, baseOffset, topOffset);

    // Warp disks
    for(i = [-1,1]) {
        WarpDisk(i*(width/2),(height/2));
        WarpDisk(i*(width/2),-(height/2));
    }
}

/*
 * Mark 2 mounting bracket replacing AngleBracket.
 *
 * The original is still useful but it's too flexible, rack trays
 * don't align properly in the vertical axis & it's easy for
 * an entire module to.
 *
 * width is the width of the bracket in mm
 * upright 0 for just the front, 1 for an additional wall to allow the bolts to
 *         to be permanently mounted to the rack (i.e. use a bolt to fasten
 */
module TrayBracket(width,upright=0) {
    height=15;      // Height of bracket
    thickness=2.5;  // thickness of bracket walls
    boltSize = 4;   // M4 bolt size

    u=width/30;

    // Base
    translate([-width/2,-height/2,0])
        cube([width, height, thickness]);

    // upright
    translate([-width/2, -(height)/2+thickness, 0])
        rotate([90,0,0])
        difference() {
            union() {
                // Front upright
                cube([width, height, thickness]);

                // Rear upright (optional)
                if(upright==1) {

                    for(x=[1:(3*u)-2]) {
                        if( (x%3)==1 ) {
                            translate([10*x,0,-thickness-5])
                                cube([10,height,thickness]);
                        }
                    }
                }
            }

            for(x=[1:(3*u)-2]) {
                if( (x%3)==1 ) {
                    translate([5+(10*x),10.5,-height])
                        MHole(boltSize,height+10);
                }
            }
        }
}
