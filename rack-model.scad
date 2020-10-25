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
use <rack/rack-bracket.scad>
use <rack/rack-ear.scad>
use <rack/rack-tray.scad>

use <components/raspberryPiTray.scad>

// Constant width of 1U
uWidth          = 30;   //  30mm wide
uHeight         = 120;  // 130mm high (90mm + 20mm for the mounts)

// Tray, faceplate thickness
trayThickness   = 5;

// Default tray dimensions
trayDepth       = 120;
trayWidthU      = 5;
trayWidth       = trayWidthU * uWidth;

// contains the 4 core components joined together
module rack() {
    // Left ear & mount
    translate([21,0,0]) RackEar();
    translate([29,0,0]) RackTrayMountLeft(trayDepth);

    // Central 5U brackets
    translate([29+60,0,0]) RackTrayBracket();
    translate([29+60+(5*uWidth),0,0]) RackTrayBracket();

    // Right ear & mount
    translate([29+60+(10*uWidth),0,0]) RackTrayMountRight(trayDepth);
    rotate([0,180,0]) translate([-(29+60+(10*uWidth)+70)+2,0,-44]) RackEar();
}

// Entire rack at base
rack();

// Copy above to test alignment with components
rotate([0,180,0]) translate([-478,0,-130]) rack();

// Copy below to show alignment of 2 racks stacked together
rotate([0,180,0]) translate([-478,0,+1]) rack();

// Some example trays in position
rotate([0,90,0]) translate([-110,0,60])
    for(x=[0:11]) {
        translate([0,0,uWidth*x])
            RaspberryPI(1);
    }
