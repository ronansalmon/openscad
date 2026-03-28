
wall = 1.8;
support_d = 13.5;
support_h = 25;
$fn = 60;

union() {
  translate([0, 0, wall])
    difference() {
      cylinder(support_h, d=support_d+wall*2);
      cylinder(support_h, d=support_d);
    }
  cylinder(wall, d=support_d*4);
}