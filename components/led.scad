/*
 * Various modules for LED mounts
 */

module Led(d,t) {
    translate([0,0,-1])
        cylinder(r=(d/2)+.25, h=t+2, $fn=80);
    // Show cutout for walls too thick for a 3mm LED
    if( t > 3 ) {
        //translate([0,0,3])
        Led(4,t-3);
    }
}

module Led3(t) {
    Led(3,t);
}

module Led5(t) {
    Led(5,t);
}

Led3(5);
