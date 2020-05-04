/*
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
