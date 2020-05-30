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
