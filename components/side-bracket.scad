/*
 * This is specific to my use case but this provides the means to attach our angle
 * brackets to an existing rack system.
 *
 * In my case this is plastic racking from a DIY store which has a 40mm diameter round
 * posts which this wraps around.
 *
 * It's here so we have an example of how to make custom mounts for other types of racking.
 *
 * Note: This is the raw original and hasn't been converted to use the common modules
 *       so there are some duplication. At some point I might clean this one up
 *       but as this is custom I've left it as is.
 */

/*
 * Mounting bracket
 */
width=40;
height=20;
t=5;

module warpDisk(x,y) {
    translate([x,y,0]) cylinder(r=5,h=.6,$fn=30);
}

/*
 * holderDiam is the diameter of round holder.
 * Adjust this to be the inner diameter you are attaching the bracket to.
 * This doesn't need to be accurate but close & bigger the better.
 *
 * holderThickness is the thickness in mm of the bracket. Doesn't need to be
 * too thick but not too think that it'll break. 2 or 3mm is usually enough.
 */
holderDiam=41;
holderThickness=3;

module bracket( top ) {
    rotate([ 90*top, 0, 0]) union() {
        slottedPanel();
        rotate([90,0,0]) translate([0,0,-t]) slottedPanel();
    }
    /*
    warpDisk(-3,-3);
    warpDisk(-3,height+3);
    warpDisk(width+3,-3);
    warpDisk(width+3,height+3);
    */

    //translate([t/2,0,0]) rotate([0,-90,0]) sideBracket();
    //translate([width,0,0]) rotate([0,-90,0]) sideBracket();
}

module slottedPanel() {
    difference() {
        cube([width,height,t]);
        for( n = [0:2] ) {
            translate([2.5+(10*n),8,-1]) {
                cube([5,8,10]);
            }
        }
    }
}


/*
 * Handles the rendering of the round holder bracket.
 *
 * This module renders each side of the part that attaches to a round post.
 *
 * side 0=left, 1=right to show/render
 * top  1=top, 0=bottom
 */
module roundHolder(side, top) {
    // Thickness of mount wall
    thickness=4;

    // Height of mount
    h=height;

    hr = (holderDiam/2)+holderThickness;

    x = width*3/4+(holderDiam/2)+holderThickness;
    y = width/3;
    difference() {
        // Union of the outer cylinder and the bracket
        union() {
            // bracket
            translate([ 0, y, 0]) bracket( top );

            // Outer cylinder
            translate([x,y,0])
                cylinder( r=hr, h=h, $rn=120 );

            // cylinder bolt mount
            translate([ x-5, y+hr-1, 0]) cylinderBoltMount(1);
            translate([ x-5, y-hr-15+1, 0]) cylinderBoltMount(0);
        }

        // Difference with the inner cylinder
        translate([x,y,-1])
            cylinder( r=holderDiam/2, h=h+2, $rn=120 );

        // Cut away the unwanted half
        translate([side ? 0 : x, y-hr-15, -1])
            cube([ side ? x : hr+10, (hr+15)*2, h+2 ]);
    }
}

/*
 * The bolt mount used to hold each half together
 *
 * align = 1 to show alignment marker
 */
module cylinderBoltMount( align ) {
    difference() {
        cube([ 10, 15, height ]);

        // Bolt hole
        translate([ -1, 15/2, height/2])
            rotate([ 0, 90, 0])
                cylinder( r=4, h=12, $rn=120 );

        // Alignment hole
        if( align ) {
        translate([5,4.5,height+1])
            rotate([0,90,45])
                cube([2,4,4]);
        }
    }
}

//cylinderBoltMount();
//bracket();
for ( n = [0:1] ) {
    rotate( [0, 0, 180*n] )
    translate([ -40*n, -70*n, 0 ])
    union() {
        roundHolder(0, n);
        translate([5,0,0]) roundHolder(1, n);
    }
}
