/*
 * Optional supports for the rack to help keep it in shape.
 *
 * Use these when there are no suitable supports available, e.g. no side panels are in use.
 *
 */

use <warpDisk.scad>;
use <boltHoles.scad>;

// Constant width of 1U
uWidth          = 30;   //  30mm wide
uHeight         = 120;  // 130mm high (90mm + 20mm for the mounts)

// Tray, faceplate thickness
trayThickness   = 5;

// Default tray dimensions
trayDepth       = 120;
trayWidthU      = 5;
trayWidth       = trayWidthU * uWidth;

/*
 * A single rack support, used in the rear corners
 * Due to layout there's 2 versions for each corner
 * side=1  for the rear right
 * side=-1 for the rear left
 */
module RackSupport( side = 1) {
    scale([side,1,1]) {
        wx=15;
        wy=18;
        wz=uHeight+11;
        t=3;
        // Connection to top/bottom trays
        for( z = [0, wz-t] ) {
            translate([0,-3,z]) difference() {
                cube([wx,wy,t]);
                translate([(wx+5)/2,(wy+3)/2,-1])
                    MHole(4,5);
            }
        }
        // Sides
        translate([0,-t,0]) {
            cube([wx,t,wz]);
            cube([t,wy,wz]);
        }
    }
}

/*
 * A double rack support - if required use this to join
 * two units together
 */
module DualRackSupport() {
    RackSupport(-1);
    translate([-30,0,0]) {
        RackSupport(1);
    }
}
