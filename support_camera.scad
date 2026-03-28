
WallThickness = 3;
grip_x=14;
//grip_y=40;
grip_y=40;
grip_z=40;
cam_holder_x=50;
cam_holder_z=20;
entraxe=11.8;

/*
union() {
  difference(){
    cube([grip_x, grip_y, grip_z]);
    translate([WallThickness,0,0])
      cube([grip_x-WallThickness*2, grip_y, grip_z-WallThickness]);
    translate([grip_x-WallThickness,0,0])
      cube([grip_x-WallThickness*2, grip_y, grip_z-WallThickness*2]);
  }
  translate([grip_x-WallThickness*2,0,grip_z-WallThickness*3])
    cube([WallThickness*2, grip_y, WallThickness]);
}

hull() {
  cube([1, grip_y, grip_z]);
  
  translate([grip_x-WallThickness*2,0,grip_z-WallThickness*3])    
  cube([45, 45, WallThickness]);
}
*/
union() {
  hull() {
    cube([6, grip_y, 0.1]);
    translate([-2, 0, 3])
      cube([10, grip_y, 0.1]);
  }
  translate([0, 0, 3])
    cube([6, grip_y, 2]);
  //renfort
  translate([-2, grip_y/2-WallThickness, 5])
    cube([10, WallThickness*3, 5]);
  
  translate([-2, grip_y/2, 5])
    cube([grip_x, WallThickness, WallThickness]);

  difference() {
    hull() {
      translate([-2, grip_y/2, 5])
        cube([grip_x, WallThickness, WallThickness]);

      translate([15, grip_y/2, 10])
        rotate([-20, 0, 0])
            cube([cam_holder_x-15, WallThickness, cam_holder_z]);
    }


    translate([-2, grip_y/2, 10])
      rotate([-20, 0, 0]) {
      #translate([cam_holder_x/2-entraxe/2+10, WallThickness*1.9, cam_holder_z/2])
        rotate([90, 0, 0])
          cylinder(h=WallThickness*2, d2=2.8, d1=8, $fn=50);
      #translate([cam_holder_x/2+entraxe/2+10, WallThickness*1.9, cam_holder_z/2])
        rotate([90, 0, 0])
          cylinder(h=WallThickness*2, d2=2.8, d1=8, $fn=50);
    }
  }
}