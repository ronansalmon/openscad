include <BOSL2/std.scad>

stepladder_internal_x = 18;
stepladder_internal_y = 36.5;
stepladder_internal_z = 25;

stepladder_bottom_x = 22;
stepladder_bottom_y = 40;
stepladder_bottom_z = 5;

difference() {
  union() {
    translate([0, 0, stepladder_internal_z/2])
      cuboid([stepladder_internal_x, stepladder_internal_y, stepladder_internal_z], rounding=3, edges=[FWD+RIGHT,FWD+LEFT,BACK+RIGHT,BACK+LEFT]);
      
    translate([0, 0, stepladder_bottom_z/2])
      cuboid([stepladder_bottom_x, stepladder_bottom_y, stepladder_bottom_z], rounding=3, edges=[FWD+RIGHT,FWD+LEFT,BACK+RIGHT,BACK+LEFT]);
  }
  
  translate([0, 0, stepladder_internal_z/2+stepladder_bottom_z*2])
    cuboid([stepladder_internal_x-5, stepladder_internal_y-5, stepladder_internal_z], rounding=3, edges=[FWD+RIGHT,FWD+LEFT,BACK+RIGHT,BACK+LEFT]);
}