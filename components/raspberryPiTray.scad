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
ledSize=3;

/*
 * height   height of panel in U, default 1
 */
module RaspberryPI( height=1 ) {
    union() {
        // Face plate
        FacePlate(height);

        // PI mounting plate
        translate([ 15, -1, 0]) difference() {
            // frame
            union() {
                cube([ 57, 76, 5 ]);
                /*
                WarpDisk(57,80,0);
                WarpDisk(0,80,0);
                //WarpDisk(57,0,0);
                //WarpDisk(0,0,0);
                WarpDisk(97,-6,0);
                WarpDisk(97, 4,0);
                WarpDisk(-37,-6,0);
                WarpDisk(-37, 4,0);
                 */
            }

            // cut out unwanted space to save plastic
            translate([10, 15, -1])
                cube([57-20, 55, 7]);

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
    }
}

module RaspberryPIHole() {
    MHole(2.5,5);
    MHole(6,2);
}

// RaspberryPI with 3mm led's.
// The led's are arranged with a single one at the top
// and 4 at the bottom in a 2x2 arrangement
module RaspberryPI_3mLed() {
    difference() {
        RaspberryPI();

        // Top LED
        translate([ 5, 0, 15]) rotate([90,0,0]) Led(ledSize, 5);

        // Bottom LED's
        translate([85, 0, 10]) rotate([90,0,0]) Led(ledSize, 5);
        translate([85, 0, 20]) rotate([90,0,0]) Led(ledSize, 5);

        translate([77.5, 0, 10]) rotate([90,0,0]) Led(ledSize, 5);
        translate([77.5, 0, 20]) rotate([90,0,0]) Led(ledSize, 5);
    }
}
