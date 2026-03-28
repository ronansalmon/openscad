include <BOSL2/std.scad>
include <BOSL2/screws.scad>
$fn=32;

h=10;
r=11;
difference(){
  union(){
    difference(){
      cylinder(r=r*2,h=h);
      cylinder(r=r,h=h);
    }
    translate([r, 0, 0])
      cube([h*1.7, h, h]);
    #translate([-h*1.7-r, 0, 0])
      cube([h*1.7, h, h]);
  }
  translate([-r*2, -r*2, 0])
    cube([r*2*2, r*2, h]);

  translate([-r*2.1, h/2, h/2])
    rotate([270, 0, 0])
      screw("#6", head="flat undercut",length=h);
  translate([r*2.1, h/2, h/2])
    rotate([270, 0, 0])
      screw("#6", head="flat undercut",length=h);
}

