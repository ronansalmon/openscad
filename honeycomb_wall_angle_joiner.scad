include <BOSL2/std.scad>

// OpenSCAD Parameterized Honeycomb Storage Wall 90 degree joiner
// Inspired by: https://www.printables.com/model/152592-honeycomb-storage-wall

/* [Size of the wall] */

// Number of hexagons high
numx=5;

/* [Shape of the hexes - you probably don't want to mess with these]  */
// thickness of the thinner wall
wall=1.8; //[:0.01]

// Height of the hexagon
height=20;


module end_plate(height,wall) {
    difference() {
        left(0.5*((height+wall*2)/sqrt(3))) cuboid([0.5*((height+wall*2)/sqrt(3)),height+wall*2,8],anchor=BOTTOM+RIGHT);
        down(1) cyl(d=2/sqrt(3)*(height+wall*2), h=10, $fn=6, anchor=BOTTOM);
    }
}

module end_section(numx) {
    grid_copies(n=[numx,1], spacing=sqrt(3)/2 * (height+wall*4), stagger=true) zrot(90) end_plate(height, wall);
}

union() {
    back(((height+wall*2)/sqrt(3))) end_section(numx*2);
    up(8) xrot(90) back(((height+wall*2)/sqrt(3))) end_section(numx*2);
    grid2d(n=[numx*2,1], spacing=sqrt(3)/2 * (height+wall*4), stagger=true) cuboid([(height+wall*2),8,8],anchor=BACK+BOTTOM);
}