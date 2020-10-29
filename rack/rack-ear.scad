/*
 * OpenSCAD model of a 19" rack ear which can be used to mount equipment to said rack.
 *
 * Additional hardware required:
 * 2 or 3 M6 (or M5) cage bolts to mount to the rack.
 * 4 M3 or M4 bolts to attach to your model.
 *
 * Important Note:
 * When mounting to the rack do not use an electric screw driver as this will most likely cause
 * the print to break (read shatter) when the bolt tightens against the print.
 *
 * When I tested the original test print of this I used an electric screwdriver and this did
 * actually happen!
 *
 * An alternative (yet to be tested) is that this might require a higher fill or possibly a solid print
 *
 */

m3_clearance_rad=1.9;
m6_clearance_rad=3.7;

/*
 * A 1U RackEar
 *
 * radius           radius of mounting hole to component. Best keep to radius of bolt + 0.4mm
 *                  Default is for M3 bolt
 */
module RackEar(radius=m3_clearance_rad) {
    // More than 5mm and standard bolts won't reach the cage nuts
    frontThickness=5;
    // The bunny ear
    translate([-16,0,0]) difference() {
        translate([-5,0,0]) cube([28,frontThickness,44]);
        // The 3 mounting holes. These should accept an M6 bolt which is fine as most
        // Racks use either M6 or M5 bolts/cage-nuts
        for(y=[0:2]) {
            translate([7-4,frontThickness-4,6.35+(y*15.875)])
                rotate([90,0,0]) {
                    for(x=[0:6]) {
                        translate([x,0,0])
                            cylinder(r=m6_clearance_rad, h=frontThickness+4, center = true, $fn=25);
                    }
                }
        }
    }

    // The mount plate
    translate([3,0,0]) difference() {
        union() {
            cube([5,40,44]);
            translate([0,39,10]) cube([5,11,24]);
            for(y=[10,34]) {
                translate([2.5,40,y])
                    rotate([0,90,0])
                        cylinder(r=10, h=5, center=true, $fn=30);
            }
        }
        RackEarHoles(radius);
    }

}

/*
 * Holes for the rack mount.
 *
 * radius = size of mounting hole
 */
module RackEarHoles(radius) {
        translate([2,30,22])
            for(x=[-4,4]) {
                for(y=[-4,4]) {
                    rotate([0,90,0])
                        translate([m3_clearance_rad*x,m3_clearance_rad*y,0])
                            cylinder(r=radius, h=7, center = true, $fn=10);
                }
            }
}
