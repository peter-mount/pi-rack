/*
 * Custom tray for a mini-PC
 *
 * This is a quad core Intel Atom 1.4GHz board with
 * 4Gb ram & 64Gb flash + a few interfaces.
 *
 * It's own case is 96x96mm which is a little too big to
 * fit in the rack but as it also ran a bit hot I
 * took the board out and it on it's own fits.
 *
 * So this model is a custom rack tray to hold this
 * machine (which is part of the build environment).
 *
 * https://smile.amazon.co.uk/gp/product/B081DR8CVN
 *
 * Note: Although a 1U tray could suffice it's a bit
 * tight with the battery & WiFi/Bluetooth antennas
 * so this model is 2U.
 *
 */
 
use <../warpDisk.scad>;
use <../boltHoles.scad>;
use <../faceplate.scad>;
use <../raspberryPiTray.scad>;

module WintelPro() {
    union() {
        // Face plate
        difference() {
            FacePlate(2);
            // Cutouts
            translate([ 15+5+3.5, 10-1+3.5, 0]) {
                // motherboard led
                translate([6,-18,5+6])
                    cube([12,10,10]);
                
                // Power button
                translate([45, -18, 5+6])
                    cube([12,10,10]);
            }

            // Some room for the board
            translate([0,-3,5+6-3])
                cube([90,10,15]);
        }

        // Board mounting plate
        //
        // This is virtually the same as the PI but shifted
        // 5mm to the bottom to allow room
        // for the UDB & SSD sockets on the top
        // Hence the +5 in the translation
        translate([ 15+5, -1, 0]) difference() {
            // frame
            union() {
                translate([-2,0,0]) cube([ 61, 76, 5 ]);
                //WarpDisk(57,80,0);
                //WarpDisk(0,80,0);
                ////WarpDisk(57,0,0);
                ////WarpDisk(0,0,0);
            }

            // cut out unwanted space to save plastic
            translate([10, 15, -1])
                cube([57-20, 55, 7]);

            // Mounting holes
            translate([0, 10, 0]) {
                translate([3.5, 3.5, 0]) {
                    // front mount holes
                    RaspberryPIHole();
                    translate([50, 0, 0]) RaspberryPIHole();
                    
                    // rear mount holes
                    translate([0, 57, 0]) {
                        RaspberryPIHole();
                        translate([50, 0, 0]) RaspberryPIHole();
                    }
                }
            }
            
        }
    }
}

rotate([90,0,0]) WintelPro();
WarpDisk(-22,2,-5);
WarpDisk(-22,-63,-5);
WarpDisk(113,2,-5);
WarpDisk(113,-63,-5);
