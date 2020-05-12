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
 * A single rack support, used in the rear corners
 * Due to layout there's 2 versions for each corner
 * side=1  for the rear right
 * side=-1 for the rear left
 */
module RackSupport( side = 1) {
    scale([side,1,1]) {
        wx=15;
        wy=18;
        wz=uHeight+11;
        t=3;
        // Connection to top/bottom trays
        for( z = [0, wz-t] ) {
            translate([0,-3,z]) difference() {
                cube([wx,wy,t]);
                translate([(wx+5)/2,(wy+3)/2,-1])
                    MHole(4,5);
            }
        }
        // Sides
        translate([0,-t,0]) {
            cube([wx,t,wz]);
            cube([t,wy,wz]);
        }
    }
}

/*
 * A double rack support - if required use this to join
 * two units together
 */
module DualRackSupport() {
    RackSupport(-1);
    translate([-30,0,0]) {
        RackSupport(1);
    }
}

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
                TrayBracket(trayWidth, 15, 2.5);
                //AngleBracket(trayWidth, 15, 2.5);
            
                // Connection to below
                //rotate([180,0,180])
                rotate([0,180,0])
                    translate([0,0,trayThickness])
                    TrayBracket(trayWidth, 15, 2.5);
                    //AngleBracket(trayWidth, 15, 2.5);
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

    open=0;
    if( open ){
        // Right rear support
        translate([trayWidth - 15,trayDepth-15,trayThickness])
            RackSupport(1);

        // Left rear support or a dual to attach modules
        translate([15,trayDepth-15,trayThickness])
            RackSupport(-1);
        //    DualRackSupport();
    } else {
        // Full left panel
        
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

/*
 * Mark 2 mounting bracket replacing AngleBracket.
 *
 * The original is still useful but it's too flexible, rack trays
 * don't align properly in the vertical axis & it's easy for
 * an entire module to
 */
module TrayBracket(width, height, thickness) {
    boltSize = 4; // M4
    
    u=width/30;
    
    // Base
    translate([-width/2,-height/2,0])
        difference() {
            cube([width, height, thickness]);
            
            for(x=[0:(3*u)-1]) {
                if( (x%3)==0 || x==(3*u)-1 ) {
                    translate([5+(10*x),10,0])
                        MHole(4,5);
                }
            }

        }
        
    // upright
    translate([-width/2, -(height)/2+thickness, 0])
        rotate([90,0,0])
        difference() {
            cube([width, height, thickness]);
            
            for(x=[0:(3*u)-1]) {
                translate([5+(10*x),10.5,0])
                    MHole(4,5);
            }
        }
}

/*
 * Full size side panel - This defines a full size
 *
 */
module FullSidePanel(width,height,thickness) {
    cube([thickness,width,height]);
}

ExampleRack1();
//RackSupportPrint();
