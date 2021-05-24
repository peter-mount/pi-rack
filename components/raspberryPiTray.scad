/*
 * This code is licensed under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike).
 * Please read LICENCE.md for full details.
 *
 * Raspberry PI mount
 *
 * Hat specification:
 * https://github.com/raspberrypi/hats/blob/master/hat-board-mechanical.pdf
 */

use <warpDisk.scad>;
use <boltHoles.scad>;
use <led.scad>;
use <faceplate.scad>;

// Led size, either 5 or 3mm depending on the available LED's
//ledSize=5;
ledSize = 3;

/*
 * height   height of panel in U, default 1
 * orig     original 2020 model, has open hole in mounting plate, default honeycomb
 * belt     1 for belt printer like CR-30, 0 for traditional XYZ printer
 * warp     1 to add warp disks
 */
module RaspberryPI(height = 1, orig = 0, belt = 0, warp = 0) {
    union() {
        // Face plate
        FacePlate(height);

        // PI mounting plate
        translate([15, - 1, 0]) difference() {
            // frame
            union() {
                translate([- 1, 0, 0]) cube([58, 76, 5]);
                translate([- 5, 0, 1.5]) rotate([45, 0, 0]) cube([65, 5, 5]);
                translate([- 5, - 1.5, 0]) cube([65, 5, 5]);
            }

            // Edge strengthner
            translate([30, 4.5, 10]) rotate([0, 90, 0]) cylinder(h = 76, r1 = 5, r2 = 5, center = true, $fn = 32);
            translate([- 4, 3.8, 9]) cylinder(h = 20, r1 = 3, r2 = 3, center = true, $fn = 32);
            translate([60, 3.8, 9]) cylinder(h = 20, r1 = 3, r2 = 3, center = true, $fn = 32);

            // cut out unwanted space to save plastic
            if (orig == 1) {
                // Original model had an empty space in the middle
                translate([10, 15, - 1])
                    cube([57 - 20, 55, 7]);
            } else {
                // Newer version has a honeycomb
                translate([1, 1, 0]) {
                    // cut out unwanted space to save plastic
                    if (belt == 1) {
                        // Belt mode cut out more underneath. Non-belt printers don't otherwise requires supports
                        translate([7.5, 5, - 1]) cube([57 - 18, 65, 3]);
                    }
                    translate([7.5, 5, 3]) cube([57 - 18, 65, 3]);

                    for (y = [1:6]) {
                        for (x = [1:3]) {
                            translate([12 * x, 10 * y, - 1]) {
                                cylinder(h = 15, r1 = 3.5, r2 = 3.5, center = false, $fn = 6);
                                translate([6.1, 5, 0])
                                    cylinder(h = 15, r1 = 3.5, r2 = 3.5, center = false, $fn = 6);
                            }
                        }
                    }
                }
            }

            translate([0, 10, 0]) {
                translate([3.5, 3.5, 0]) {
                    RaspberryPIHole();
                    translate([49, 0, 0]) RaspberryPIHole();
                    translate([0, 58, 0]) {
                        RaspberryPIHole();
                        translate([49, 0, 0]) RaspberryPIHole();
                    }
                }
            }
        }

        if (warp == 1) {
            WarpDisk(10, 81, 0, 10);//WarpDisk(10,88,0,16);
            WarpDisk(76, 86, 0, 14);
            WarpDisk(108, 9, 0, 14);
            WarpDisk(- 20, 5, 0, 10);
        }
    }
}

module RaspberryPIHole() {
    MHole(2.5, 5);
    MHole(6, 2);
}

// RaspberryPI with 3mm led's.
// The led's are arranged with a single one at the top
// and 4 at the bottom in a 2x2 arrangement
module RaspberryPI_3mLed() {
    difference() {
        RaspberryPI();

        // Top LED
        translate([5, 0, 15]) rotate([90, 0, 0]) Led(ledSize, 5);

        // Bottom LED's
        translate([85, 0, 10]) rotate([90, 0, 0]) Led(ledSize, 5);
        translate([85, 0, 20]) rotate([90, 0, 0]) Led(ledSize, 5);

        translate([77.5, 0, 10]) rotate([90, 0, 0]) Led(ledSize, 5);
        translate([77.5, 0, 20]) rotate([90, 0, 0]) Led(ledSize, 5);
    }
}
