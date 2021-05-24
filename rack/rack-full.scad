/*
 * This OpenSCAD file combines the various models into a single 19" print.
 *
 * Where on a normal XYZ printer you would have to print a RackTrayMount
 * for the left & right of the print & a RackTrayBracket for the centre
 * this allows for a single stronger print - but due to it being the full
 * width of a 19" rack, you need either an XYZ printer large enough or
 * a belt printer like the CR-30 3DPrintMill.
 *
 * This module generates one half of a fill 19" enclosure, you need a second one
 * to sit on top to form the entire enclosure.
 *
 * Print time is about 2.5 days each.
 */
use <../components/brackets.scad>
use <../components/boltHoles.scad>
use <../components/warpDisk.scad>
use <../rack/rack-bracket.scad>
use <../rack/rack-ear.scad>
use <../rack/rack-tray.scad>

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


// This version of rack() is for the CR-30 3DPrintMill or other Belt printers
// it differs in that it generates the rack in one single print
module FullRack() {
    rackWidthU = 14;
    rackWidth = rackWidthU * uWidth;

    ya = [.25, .5, .75, 1];
    xa = [0, 2, 4, 6, 8, 10, 12];

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
