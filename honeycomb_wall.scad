include <BOSL2/std.scad>

// OpenSCAD Paramaterized Honeycomb Storage Wall
// Inspired by: https://www.printables.com/model/152592-honeycomb-storage-wall

/* [Size of the wall] */

// Number of hexagons to make in the X axis
numx=8;

// Number of hexagons to make in the Y axis
numy=5;

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

module cell(height, wall) {
    union() {
        tube(od=2/sqrt(3)*(height+wall*2), id=2/sqrt(3)*height, h=5, $fn=6, anchor=BOTTOM);
        up(5) tube(od=2/sqrt(3)*(height+wall*2), id1=2/sqrt(3)*height,id2=2/sqrt(3)*(height+wall), h=1, $fn=6, anchor=BOTTOM);
        up(6) tube(od=2/sqrt(3)*(height+wall*2), id=2/sqrt(3)*(height+wall), h=2, $fn=6, anchor=BOTTOM);
    }
}

module abeille_cote(numx, numy) {
  union() {
      grid_copies(n=[numx*2,numy], spacing=sqrt(3)/2 * (height+wall*4), stagger=true) zrot(30) cell(height, wall);
  }
}

module end_plate(height,wall) {
    difference() {
        left(0.5*((height+wall*2)/sqrt(3))) cuboid([0.5*((height+wall*2)/sqrt(3)),height+wall*2,8],anchor=BOTTOM+RIGHT);
        down(1) cyl(d=2/sqrt(3)*(height+wall*2), h=10, $fn=6, anchor=BOTTOM);
    }
}

module end_section(numx) {
    grid_copies(n=[numx,1], spacing=sqrt(3)/2 * (height+wall*4), stagger=true) zrot(90) end_plate(height, wall);
}

module angle_cote() {
  union() {
      back(((height+wall*2)/sqrt(3))) end_section(numx*2);
      up(8) xrot(90) back(((height+wall*2)/sqrt(3))) end_section(numx*2);
      grid_copies(n=[numx*2,1], spacing=sqrt(3)/2 * (height+wall*4), stagger=true) cuboid([(height+wall*2),8,8],anchor=BACK+BOTTOM);
  }
}

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


union() {

  abeille_cote(numx, numy);
  translate([0, -(cell_size*numy/2-cell_size/4), 0])
    angle_cote();
  translate([-cell_size/2, (cell_size*numy/2-cell_size/4), 0])
    rotate([0, 0, 180])
      angle_cote();

  translate([0, -(cell_size*numy/2-cell_size/4), cell_size*numy/2-cell_size/4 + cell_height+1])
    rotate([90, 0, 0])
      abeille_cote(numx, numy);

  translate([0, (cell_size*numy/2-cell_size/4), cell_size*numy/2-cell_size/4 + cell_height+1])
    rotate([270, 0, 0])
      abeille_cote(numx, numy);

  translate([-(cell_size*numx/2)-cell_size/4, 0, cell_size*numy/2+id-cell_size+cell_size/2])
    rotate([0, 90, 0]) 
      abeille_cote(numy, numy);

  translate([-(cell_size*numx/2)-cell_size/4, -cell_size*numy/2, 0])
    rotate([0, 0, 0]) 
      cube([cell_height, cell_size*numy, cell_height]);
  
  translate([-(cell_size*numx/2)-cell_size/4, -cell_size*numy/2-wall-0.3, 0])
    rotate([0, 0, 0]) 
      cube([cell_height, cell_height, cell_size*numy]);

  translate([-(cell_size*numx/2)-cell_size/4, cell_size*numy/2-cell_height+wall+0.3, 0])
    rotate([0, 0, 0]) 
      cube([cell_height, cell_height, cell_size*numy]);
}