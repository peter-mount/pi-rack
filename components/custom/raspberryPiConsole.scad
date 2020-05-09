/*
 * A 2U tray for a Raspberry PI 3A with an
 * Elegoo 3.5" TCT LCD 480x320 screen mounted in
 * portrait.
 *
 * Although this screen isn't great in refresh
 * performance (I've not tried graphics with this
 * screen) it is brilliant when used as a text
 * console - just don't expect it to be the same
 * as a traditional monitor.
 *
 * Associated with this model is a keyboard try
 * as it's also used with a small wireless keyboard
 * of the type used for small media centre systems.
 *
 * Note: This is not an endorsement/advert for this
 * specific screen, just that I tried one and this
 * is the resulting result.
 *
 * TFT screen: https://smile.amazon.co.uk/gp/product/B01MRQTMTD/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1
 */
 
use <warpDisk.scad>;
use <boltHoles.scad>;
use <faceplate.scad>;
use <raspberryPiTray.scad>;

module ConsolePI() {
    // Dimensions of display in portrait mode
    // values from PDF on supplied CDRom
    dw=55.6;
    dh=85.42;
    
    difference() {
        union() {
            // Face plate
            FacePlate(3);
            translate([-3,12-6,(89-(dw/2))/2])
                cube([dh+6,3,dw/2]);
            translate([-3,0,(89-(dw/2))/2])
                cube([3,9,dw/2]);
            translate([dh,0,(89-(dw/2))/2])
                cube([3,9,dw/2]);
        }
        // Display cutout
        translate([0,-6,(89-dw)/2])
            cube([dh,12,dw]);
    }
}

rotate([90,0,0]) ConsolePI();
WarpDisk(-22,2,-5);
WarpDisk(-22,-93,-5);
WarpDisk(112,2,-5);
WarpDisk(112,-93,-5);
