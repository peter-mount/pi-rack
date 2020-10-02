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

// Default tray dimensions
trayDepth       = 120;
//trayWidthU      = 5;
//trayWidth       = trayWidthU * uWidth;

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

// Tray bracket
module RackTrayBracket(trayWidthU=5) {
    trayWidth = trayWidthU * uWidth;

    difference() {
        union() {
            translate([trayWidth/2,15/2,0])
                TrayBracket(trayWidth,1,60);

            cube([trayWidth,trayDepth,trayThickness]);

            // Interlock males on right hand side
            //RackTrayBracketInterlock(trayWidth,0);
        }

        // Interlock females on left hand side
        //RackTrayBracketInterlock(0,1);

        // bolt holes on edges
        for(x=[1:10]) {
            if( (x%3)==0 ) {
                translate([5, 5+(10*x),0]) MHole(4,5);
                translate([trayWidth-5, 5+(10*x),0]) MHole(4,5);
            }
        }

        // Holes on back edge
        for(x=[0:14]) {
            if( (x%3)==0 || x==(15)-1 ) {
                //translate([5+(10*x),15,0]) MHole(4,5);
                translate([5+(10*x),trayDepth-7.5,0]) MHole(4,5);
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
