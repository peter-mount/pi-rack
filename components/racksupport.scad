/*
 * This is a vertical support to hold 2 cable tray's
 * together to provide either extra structual support
 * or for when it's used to create a standalone
 * enclosure.
 *
 * There's 2 versions of this:
 * 1 bolt connection which can be used at each rear
 * corner of the cable tray.
 *
 * 2 bold connection which can be used to bind 2
 * cable tray's together.
 *
 */

use <warpDisk.scad>;
use <boltHoles.scad>;

// Used for modelling
use <brackets.scad>;
use <faceplate.scad>;
use <cabletray.scad>;
use <side-mount.scad>;
use <rack-supports.scad>;

// Constant width of 1U
uWidth          = 30;   //  30mm wide
uHeight         = 120;  // 130mm high (90mm + 20mm for the mounts)

// Tray, faceplate thickness
trayThickness   = 5;

// Default tray dimensions
trayDepth       = 120;
trayWidthU      = 5;
trayWidth       = trayWidthU * uWidth;

/*
 * Dummy module with the various components
 * joined together in one model.
 *
 * This is useful in layouts
 */
module ExampleRack1() {
    // Vertical distance between trays.
    // This is the uHeight of 120mm
    // Top & Bottom trays
    for(z = [0, uHeight + 21 - trayThickness]) {
        translate([0,0,z]) {
            cableTray(trayWidthU, trayDepth);
            
            translate([75,trayThickness+7.5,trayThickness]) {
                // Connection to above
                TrayBracket(trayWidth,1);

                // Connection to below
                //rotate([180,0,180])
                rotate([0,180,0])
                    translate([0,0,trayThickness])
                    TrayBracket(trayWidth);
            }
        }
    }

    // Blank face plates to ensure they fit
    // 0.5 is the vertical margin between tray & faceplate to make
    // it easier to install (same as 1mm between U horizontally)
    for(x = [0,2,4]) {
        translate([x*uWidth,trayThickness, uHeight-trayThickness+0.5])
            rotate([0,90,0])
                FacePlate( 1 );
    }

    // 1=risers, otherwise full
    open=1;
    if( open == 1 ){
        // Right rear support
        translate([trayWidth - 15,trayDepth-15,trayThickness])
            RackSupport(1);

        // Left rear support or a dual to attach modules
        translate([15,trayDepth-15,trayThickness])
            RackSupport(-1);
        //    DualRackSupport();

        // Partial left panel
        translate([ 0, 28, trayThickness])
            SideBracket2();
            //FullSidePanel(55, uHeight+21-trayThickness, trayThickness, 0);

        // Partial right panel
        translate([trayWidth, 28,trayThickness/2])
            SideBracket2();
            //FullSidePanel(55, uHeight+21-trayThickness, trayThickness, 1);
    } else {
        // Full left panel
        translate([ -trayThickness, 0, 0])
        FullSidePanel(trayDepth, uHeight+21, trayThickness);
    }
}

/*
 * Pair of RackSupports with warp disks suitable for printing
 */
module RackSupportPrint() {
    rotate([90,0,0]) {
        RackSupport(1);
        translate([40,0,0]) RackSupport(-1);
    }
    for(y=[2.5, -134]) {
        WarpDisk(-2.5, y, -3);
        WarpDisk(18.5, y, -3);
        WarpDisk(21.5, y, -3);
        WarpDisk(43.5, y, -3);
    }
}

ExampleRack1();
//RackSupportPrint();
//FullSidePanel(trayDepth, uHeight, trayThickness);

/*
for(x=[0:3]) {
    translate([14*x,0,0])
        SideBracket2();
}
*/

/*
for(c=[0:0]) {
    translate([0,25*c,0]) {
        //TrayBracket(trayWidth,1);
        rotate([0,-90,0])
            FullSidePanel(41, uHeight+21-trayThickness, trayThickness, 0);
        for(y=[-1,1]) {
            for(x=[-1,1]) {
                WarpDisk(x*(2+trayWidth/2),y*9.5,0);
            }
        }
    }
}
*/

/*
for(c=[0:0]) {
    translate([0,25*c,0]) {
        rotate([0,-90,0])
            FullSidePanel(41, uHeight+21-trayThickness, trayThickness, 0);
        for(y=[0,1]) {
            for(x=[-1:0]) {
                WarpDisk(x*(uHeight+21-trayThickness),y*41,0);
            }
        }
    }
}
*/
