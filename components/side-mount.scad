/*
 * Side panel of the rack which has mounting holes to mount the rack in some other enclosure or racking.
 */

use <warpDisk.scad>;
use <boltHoles.scad>;

/*
 * Side mounting holes.
 *
 * Use this module to add these holes to your own module so they align up correctly
 * with this panel
 */
module SideMount(thickness) {
    for(x=[-3.5,3.5]) {
        for(y=[-13,13]) {
            translate([x,y,-1])
                MHole(3,thickness+2);
        }
    }
}
/*
 * Full size side panel - This defines a full size
 * side=0 for left, 1 for right
 */
module FullSidePanel(width, height, thickness,side=0) {
    difference() {
        union() {
            // Panel
            cube([thickness,width,height]);

            // Side mounts
            x= side==0 ? thickness-1 : -13;
            for(z=[2,height-thickness]) {
                translate([x,21,z])
                    cube([15,20,3]);
            }
        }

        // Mounting holes
        translate([0,25,height/2])
            rotate([90,0,90])
            SideMount(thickness);
        /* Alternate arrangement with 2 sets of holes
        for(y=[30,height-30]) {
            translate([0, 25, y]) rotate([90,0,90]) SideMount(thickness);
        }
        */

        // Mounting holes onto the top/bottom plates
        x= side==0 ? 10 : -5;
        for(z=[2,height-thickness]) {
            translate([x,35,z-1])
                MHole(4,5);
        }

        /* Cutouts for easy removal from the bed */
        for(y=[0,135]) {
            translate([-2,18,y-1])
                cube([3,4,3]);
        }
        for(x=[40,70,96]) {
            translate([-2,39,x-1])
                cube([3,3,4]);
        }
    }

}

/*
 * New mini side-bracket
 *
 * The above failed as, although it held the top/bottom together it was weak
 * (one broke as I installed it) and makes the rack too wide (I have 300mm wide to
 * fit this in).
 *
 * So this design replaces it with a simple bracket that attches to the side of the
 * cable tray, so it's the tray thats mounted to the exterior not the entire rack.
 */
module SideBracket2() {
    width=45;
    height=15;
    depth=10;
    thickness=3;
    difference() {
        union() {
            cube([depth,width,thickness]);
            translate([0,1+width/4,0]) {
                cube([2*depth/3,(width/2)-2,thickness+3]);
                cube([thickness,(width/2)-2,height]);
                for(x=[0, (width/2)-4]) {
                    translate([0,x,0])
                        cube([depth, 2, height]);
                }
            }
        }

        // Side mount
        translate([0,width/2,2*height/3])
            rotate([90,0,90])
            for(x=[-3.5,3.5]) {
                translate([x,0,-1])
                    MHole(3,thickness+2);
            }

        // Cable Tray mount
        for(x=[7, width-8]) {
            translate([depth/2,x,0])
                MHole(4,5);
        }
    }

    for(x=[-2,depth+2]) {
        for(y=[width+3,-3]) {
            WarpDisk(x,y, 0);
        }
    }
}
