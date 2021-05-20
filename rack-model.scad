/*
 * This OpenSCAD file combines the various models into a single integrated model.
 *
 * This model is not for printing but to ensure that each component fits together
 * as expected.
 *
 * Now a 19" rack is 480mm wide (based on measuring a 1U device).
 * 20mm each side is taken up by the bunny ears (technical name for the parts that mount onto the actual rack.
 * That leaves us with with 440mm of usable space.
 * Using 2 150mm RackTrayBrackets that leaves us with 140mm to use on both sides.
 * With that we can fit in another 2U on each side with 10mm spare.
 *
 * So for the final rack we will have:
 *  2 RackTrayBracket's      provides 10U of space
 *  Left hand RackTrayMount  provides 2U of space, the side panel & the bunny ears
 *  Right hand RackTrayMount provides 2U of space, the side panel & the bunny ears
 *
 * This then forms the bottom half of the rack. The top half is exactly the same but rotated
 */

use <components/brackets.scad>
use <components/boltHoles.scad>
use <components/warpDisk.scad>
use <rack/rack-bracket.scad>
use <rack/rack-ear.scad>
use <rack/rack-tray.scad>

use <components/raspberryPiTray.scad>

// Constant width of 1U
uWidth = 30;   //  30mm wide
uHeight = 120;  // 130mm high (90mm + 20mm for the mounts)

// Tray, faceplate thickness
trayThickness = 5;

// Default tray dimensions
trayDepth = 160; //120;
trayWidthU = 5;
trayWidth = trayWidthU * uWidth;

sideHeight = 65;

// contains the 4 core components joined together
module rack() {
    // Left ear & mount
    translate([21, 0, 0]) RackEar();
    translate([29, 0, 0]) RackTrayMount(2, trayDepth, sideHeight);

    // Central 4U brackets
    translate([29 + 60 + (3 * uWidth), 0, 0]) RackTrayBracket(4);

    // Right ear & mount
    translate([29 + 60 + (7 * uWidth), 0, 0]) RackTrayMount(1, trayDepth, sideHeight);
    rotate([0, 180, 0]) translate([- (29 + 60 + (10 * uWidth) + 70) + 2, 0, - 44]) RackEar();

}

// This version of rack() is for the CR-30 3DPrintMill or other Belt printers
// it differs in that it generates the rack in one single print
module fullRack() {
    rackWidthU = 14;
    rackWidth = rackWidthU * uWidth;

    ya = [.25, .5, .75, 1];
    xa = [0, 2, 4, 6, 8, 10, 12];

    // Wind break to protect leading edge - specific to my print environment
    /*
    translate([0,120,0]) cube([1,40,1]);
    translate([10,trayDepth,0]) difference() {
        cylinder(h=1,r1=10,r2=10,center=false,$fn=60);
        translate([0,0,-.5]) cylinder(h=3,r1=9,r2=9,center=false,$fn=20);
    }
    translate([10,169,0]) cube([40,1,1]);
     */

    //translate([21, 0, 0]) RackEar();

    translate([29, 0, 0]) union() {
        // Base with grille
        difference() {
            cube([rackWidth, trayDepth, 2.5]);
            for (y = [3:(trayDepth / 10) - 2]) {
                for (x = [1:(2 * rackWidthU) - 2]) {
                    translate([uWidth * x / 2, 10 * y, - 1]) {
                        cylinder(h = 5, r1 = 4, r2 = 4, center = false, $fn = 6);
                        translate([7.1,5,0])
                            cylinder(h = 5, r1 = 4, r2 = 4, center = false, $fn = 6);
                    }
                }
            }
        }

        // Front bracket for trays
        translate([rackWidth / 2, 15 / 2, 0])
            TrayBracket(rackWidth, 1);

        // Rear support
        translate([0, trayDepth - 5, 0]) cube([rackWidth, 5, 10]);

        // Strenghen length ways
        for (y = ya) {
            translate([0, (y * trayDepth) - 5, 0]) cube([rackWidthU * uWidth, 5, 4]);
        }

        // strengthen front to back
        for (x = xa) {
            translate([x * uWidth, 0, 0]) cube([4, trayDepth, 4]);
        }

        // cross members
        for (x = xa) {
            for (y = ya) {
                w = uWidth * (y == .25 ? 2 : 2.4);
                translate([x * uWidth, y * trayDepth - 5, 0]) {
                    rotate([0, 0, - 34])
                        cube([w, 4, 4]);
                    translate([2 * uWidth, 0, 0])
                        rotate([0, 0, 34 - 180])
                            cube([w - 10, 4, 4]);
                }
            }
        }

        // Side panels
        for (side = [1, 2]) {
            translate([side == 1 ? rackWidth : - 5, 0, 0])
                difference() {
                    cube([5, trayDepth, sideHeight]);
                    RackEarHoles(1.9);
                }
        }

        // Side panel supports
        // left
        translate([- 4, 0, 5])
            rotate([0, 45, 0])
                cube([6, trayDepth, 6]);
        cube([4.5, trayDepth, 5]);
        // right
        translate([rackWidth - 4, 0, 5])
            rotate([0, 45, 0])
                cube([6, trayDepth, 6]);
        translate([rackWidth - 4, 0, 0]) cube([4.5, trayDepth, 5]);

        // warp disks
        WarpDisk(-18,-3,0,16);
        WarpDisk(-18,trayDepth+3,0,16);
    }
}

fullRack();
//RackEar();
// Entire rack at base
//rack();

// Copy above to test alignment with components
//rotate([0,180,0]) translate([-478,0,-131]) rack();

// Copy below to show alignment of 2 racks stacked together
//rotate([0, 180, 0]) translate([- 478, 0, + 1]) rack();

// Some example trays in position
/*
rotate([0,90,0]) translate([-110,0,60])
    for(x=[0:11]) {
        translate([0,0,uWidth*x])
            RaspberryPI(1);
    }
*/

// 13mm
// 13 - 5 - 5 = 3
//
//RackEar();
//RackTrayMount(2,trayDepth,sideHeight);
//RackTrayMount(1,trayDepth,sideHeight);
//RackTrayBracket(4);
//translate([4*uWidth,0,0]) RackTrayBracket(4);

//RackTrayShim();
