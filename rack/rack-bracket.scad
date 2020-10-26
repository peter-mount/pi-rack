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
 * The rack tray mount. This is a 2U mount with a side which can be attached to the
 * bunny ears for mounting to the rack.
 *
 * Note: Although this is 2U, the outer 1U isn't full (due to the side panel).
 *       The outer 1U would need to be blanked off with a custom panel, although it
 *       could be used for LED's, switches etc.
 *
 * side     1=right, 2=left
 * depth    depth of tray/mount in mm
 * height   height of side panel, default 44mm
 */
module RackTrayMount(side,depth,height=44) {
    // Width of the mount in U
    rackWidthU=5;
    union() {
        RackTrayBracket(rackWidthU,side);
        translate([ side==1 ? ((rackWidthU*30)-5) : 0, 0, 0])
            difference() {
                cube([5,depth,height]);
                RackEarHoles(1.9);
            }
    }
}
