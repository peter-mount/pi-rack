/*
 * Tray to mount a 2.5" Harddrive in a 1U tray
 *
 * You will require 4 M3*8 bolts to mount the drive
 * to the tray.
 *
 * It's also best to add a sticky pad between the drive
 * and the tray to minimise vibration but also to handle
 * any remaining slack between the tray and the drive.
 */
 
use <warpDisk.scad>;
use <boltHoles.scad>;
use <faceplate.scad>;
use <raspberryPiTray.scad>;

module HardDrive2_5() {
    union() {
        // Face plate
        FacePlate(1);

        // Board mounting plate
        translate([ 12.5, -1, 0]) difference() {
            translate([-2,0,0])
                union() {
                // frame
                    cube([ 70, 110, 5 ]);
                // Extra 3mm for supporting the drive
                for(x = [0,60]) {
                    translate([x,0,0])
                    cube([10,110,8]);
                }
            }

            // cut out unwanted space to save plastic
            translate([7, 10, -1])
                cube([52, 90, 7]);

            // Mounting holes
            translate([0, 20, 0]) {
                translate([2, 3.5, 0]) {
                    for(x = [0,62]) {
                        for(y = [0,76]) {
                            translate([x,y,0])
                                HardDrive2_5Hole();
                        }
                    }
                }
            }
            
        }
    }
}

/*
 * 2.5 drives use M3, we include extra room for bolt
 * head
 */
module HardDrive2_5Hole() {
    MHole(3,5+5);
    MHole(7,4);
}

/*
rotate([90,0,0]) HardDrive2_5();
WarpDisk(-22,2,-5);
WarpDisk(-22,-33,-5);
WarpDisk(113,2,-5);
WarpDisk(113,-33,-5);
*/

HardDrive2_5();
WarpDisk(83.5,110.5,0);
WarpDisk( 7.5,110.5,0);
WarpDisk(-22,   3,0);
WarpDisk(-22,  -8,0);
WarpDisk(112.5, 3,0);
WarpDisk(112.5,-8,0);
