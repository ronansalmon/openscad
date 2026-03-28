include <BOSL2/std.scad>

// OpenSCAD Paramaterized Honeycomb Storage Wall
// Inspired by: https://www.printables.com/model/152592-honeycomb-storage-wall

/* [Size of the wall] */

// Number of hexagons to make in the X axis
numx=1;

// Number of hexagons to make in the Y axis
numy=8;

/* [Shape of the hexes - you probably don't want to mess with these]  */
// thickness of the thinner wall
wall=1.8; //[:0.01]

// Height of the hexagon
height=20;
cell_size = height + 2 * wall;
cell_height = 5 + 2 + 1;

// I do not known how to compute 1.5425 if you change height, numy, numx or wall
// grid_copies is the guilty function
id=2/sqrt(3)*(height+wall*2)/1.5425;


module cell_back(height, wall) {
    hull() {
        tube(od=2/sqrt(3)*(height+wall*2), id=2/sqrt(3)*height, h=5, $fn=6, anchor=BOTTOM);
        up(5) tube(od=2/sqrt(3)*(height+wall*2), id1=2/sqrt(3)*height,id2=2/sqrt(3)*(height+wall), h=1, $fn=6, anchor=BOTTOM);
        up(6) tube(od=2/sqrt(3)*(height+wall*2), id=2/sqrt(3)*(height+wall), h=2, $fn=6, anchor=BOTTOM);
    }
}

module abeille_back_cote() {
  union() {
      grid_copies(n=[2,numy], spacing=sqrt(3)/2 * (height+wall*4), stagger=true) 
        zrot(30) 
          cell_back(height, wall);
  }
}

translate([id-cell_size/2-cell_height, 0, 0])
  cube([cell_height, cell_size*numy+cell_height*2, cell_height]);
    
      abeille_back_cote();


module abeille_back_cote2() {
translate([id-cell_size/2-cell_height, 0, 0])
  union() {
    translate([0, -id/2-(cell_size*numy+cell_height*2)/2, 0])
      #cube([cell_height, cell_size*numy+cell_height*2, cell_height]);
    difference() {
        
        abeille_back_cote();
      *translate([-cell_size/4+cell_height, -cell_size*numy/2+cell_size/4-cell_height, -1])
        cube([cell_size, cell_size*numy-cell_size/2+cell_height+8, cell_height+2]);
    }
  }
}

*abeille_back_cote2();
*translate([-cell_height, 0, 0])
  rotate([0, 90, 0])
    abeille_back_cote2();