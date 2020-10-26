/*
 * OpenSCAD model of a rack tray.
 *
 * This component holds up to 5U of devices from above & below.
 */


use <../components/brackets.scad>
use <../components/boltHoles.scad>

// Constant width of 1U
uWidth          = 30;   //  30mm wide
uHeight         = 120;  // 130mm high (90mm + 20mm for the mounts)

// Tray, faceplate thickness
trayThickness   = 5;
trayBaseThickness = 3;

// Default tray dimensions
trayDepth       = 120;

module Interlock(thickness) {
    difference() {
        translate([3,-3,0]) rotate([0,0,45]) cube([6,6,thickness]);
        translate([3,-3,-1]) cube([8,9,thickness+2]);
    }
}

module RackTrayBracketInterlock(ox,dh) {
    for(x=[25,50,80]) {
        translate([ox, x,-dh]) Interlock(trayThickness+(2*dh));
    }
}

// Rack hole, a MHole(4,5) with a cutout to hold the bolt head
module RackHole() {
    MHole(4,trayThickness*2);
    MHole(8,trayThickness);
}

// RackBracket - cube to contain the RackHole
module RackHoleBracket(width=10,depth=trayDepth-15,thickness=trayThickness*2) {
    cube([width,depth,thickness]);
}

// Tray bracket
// trayWidthU is how wide in U's the tray is
// sides = which sides have holes, 1=left, 2=right, 3=both
module RackTrayBracket(trayWidthU=5,sides=3) {
    trayWidth = trayWidthU * uWidth;

    // Extra thick for the holes
    holeX1 = 5;
    holeX2 = trayWidth-5;

    difference() {
        union() {
            translate([trayWidth/2,15/2,0])
                TrayBracket(trayWidth,1);//,60);

            cube([trayWidth,trayDepth,trayBaseThickness]);

            if( sides==1 || sides==3 ) {
                translate([holeX1-5,0,0]) RackHoleBracket();
            }
            if( sides==2 || sides==3 ) {
                translate([holeX2-5,0,0]) RackHoleBracket();
            }
        }

        // bolt holes on edges
        for(x=[1:10]) {
            if( (x%3)==0 ) {
                if( sides==1 || sides==3 ) {
                    translate([holeX1, 5+(10*x),0]) RackHole();
                }
                if( sides==2 || sides==3 ) {
                    translate([holeX2, 5+(10*x),0]) RackHole();
                }
            }
        }

        // Helpers to pry off the print from the print bed
        for(x = [0, trayWidth-1]) {
            for(y=[17,104]) {
                translate([x-1,y-2.5,-1]) cube([3,5,2]);
            }
        }
        for(x = [20, 50, 80, 110]) {
            translate([x-2.5,trayDepth-2,-1]) cube([5,3,2]);
        }
    }
}
