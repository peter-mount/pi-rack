/*
 * This is a custom 2U tray for the Raspberry PI.
 *
 * I use this to house Raspberry PI 4B's. It's based on the led model
 * it it also includes space cut out to fit an Adafruit Mini PI 135x240 TFT screen
 * on the front.
 *
 * To setup, install the PI on the rack & insert the screen in the space provided.
 * Using Female-Male dupont cable connect the used GPIO & Power pins between the two.
 * I then used a hot glue gun to fix the screen and the cables in place.
 *
 * Tip: Not all pins are required so you only need to connect those used. You can
 *      get away with just 1 5V & 1 Ground bins being connected leaving the rest
 *      for further expansion - e.g. connecting the LED's or other hardware.
 */
use <led.scad>;
use <raspberryPiTray.scad>

ledSize=3;

module RaspberryPI_adafruitMiniPiTft135_240() {
    difference() {
        RaspberryPI( 2 );
        //translate([65,-3.2,15])
        translate([55,-3.2,12])
            rotate([90,-90,0])
            AdafruitMiniPiTft135_240();

        // LED's
        for( x = [0:2] ) {
            for( y = [0, 1] ) {
                translate([85-(7.5*y),
                    0,
                    20+(10*x)])
                rotate([90,0,0])
                Led(ledSize, 5);
            }
        }
    }
}

/*
 * Adafruit Mini PI TFT 135x240 screen.
 *
 * Use this to cut out of a panel
 */

module AdafruitMiniPiTft135_240() {
    w = 38;     //1.5 * inch;
    sh = 18;    // Screen height
    ph = 25;    // PCB height
    sd = 2;     // Depth of screen but not the pcb
    cw = 1;     // Cable spacing as it's flush with TFT front so need to account for that
    // The screen + buttons
    cube([w + cw, sh, sd]);
    // The PCB + extra room to cut out of a face plate
    translate([0,0,-6.5]) cube([w+cw,ph,7]);
}
