include <BOSL2/std.scad>
wall = 2;
box_x = 14;
box_y = 55;
box_z = 50;

screw_holder_h = box_x-wall;
screw_holder_d = 8;

module screw_holder() {
  difference(){
    hull() {
      translate([0, screw_holder_d/2, 0])
        cube([screw_holder_d, 0.1, screw_holder_h], center=true);
      cylinder(h=screw_holder_h, d=screw_holder_d, center=true);
    }
    cylinder(h=screw_holder_h, d=4, center=true);
  }
}
union() {
  difference() {
    cuboid(
      [box_x+wall, box_y+wall*2, box_z+wall], rounding=5,
      edges=[BOTTOM+FRONT,BOTTOM+RIGHT,FRONT+RIGHT, BACK+RIGHT, BACK+BOTTOM],
      $fn=24
    );
    translate([-wall/2,0,wall/2])
      cuboid(
        [box_x, box_y, box_z], rounding=5,
        edges=[BOTTOM+FRONT,BOTTOM+RIGHT,FRONT+RIGHT, BACK+RIGHT, BACK+BOTTOM],
        $fn=24
      );
  }

  translate([-wall, -box_y/2-screw_holder_d/2, 0])
    rotate([90, 90, 90])
      screw_holder();
  translate([-wall, box_y/2+screw_holder_d/2, 0])
    rotate([90, -90, 90])
      screw_holder();
}