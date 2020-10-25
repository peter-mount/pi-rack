/*
 * OpenSCAD model of a 2U rack tray with side panel and bunny ears.
 *
 * There's 2 versions of this, one each for each side of a rack.
 *
 * Each one is 2*30 + 10 + 20 = 90
 */

use <../components/boltHoles.scad>
use <rack-tray.scad>
use <rack-ear.scad>

/*
 * Left hand rack tray mount
 *
 * depth    depth of tray/mount in mm
 */
module RackTrayMountLeft(depth,height=44) {
    union() {
        RackTrayBracket(2,2);
        difference() {
            cube([5,depth,height]);
            RackEarHoles(1.9);
        }
    }
}

/*
 * Left hand rack tray mount
 *
 * depth    depth of tray/mount in mm
 */
module RackTrayMountRight(depth,height=44) {
    union() {
        RackTrayBracket(2,1);
        translate([55,0,0]) difference() {
            cube([5,depth,height]);
            RackEarHoles(1.9);
        }
    }
}
