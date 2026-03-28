
wall = 3;

box_x = 150;
box_y = 200;
box_z = 150;
hole_r = 5;

module holes(rx=-10, ry=10, rz=box_x, trz=hole_r) {
  translate([0, ry, trz])
    rotate([rx,0,0])
    hull() {
      sphere(r = hole_r);
      translate([0, 0, rz/5*3])
        sphere(r = hole_r);
    }
}

 
difference() {
  cube([box_x, box_y, box_z]);
  translate([wall, 0, wall])
    cube([box_x-wall*2, box_y-wall, box_z]);
  *for (i = [0 : 1 : 8])
    translate([0, i * 20, box_x/6])
      holes();

  *for (i = [0 : 1 : 9])
    translate([box_x, i * 20, box_x/6])
      holes();

  *for (i = [1 : 1 : 7])
    translate([i * 20-5, box_y, box_x/6])
      holes(0, 0);
  
  *for (i = [1 : 1 : 7])
    translate([i * 20-5, box_y/6*5, -5])
      holes(90, 0, box_y/4*5);
}