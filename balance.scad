
wall = 2;
printer_marge = 0.2;

led_x_tftt = 3;
led_x_right = 9;
led_y_top = 3;
led_y_bottom = 4;

pi_x = 63.5;
pi_y = 110;
pi_z = 30;
pi_x_left = 90.5-pi_x;
pi_y_bottom = 140-pi_y;

pi_usb_x = 56;
pi_usb_z = 19;

pi_hdmi_y = 60;
pi_hdmi_z = 11;
pi_hdmi_bottom = 59;

box_x = 103;
box_y = 166 ;
box_z = 16;

hole_d = 4;
hole_axe = 5-hole_d/2;
$fn=60;

module box_ext(full = false) {
  difference() {
    if (full == false) {
      cube([box_x+wall*2, box_y+wall*2, box_z+wall*2]);
      translate([wall, wall, wall])
        cube([box_x, box_y, box_z+wall*2]);

      translate([wall+led_x_tftt, wall+led_y_bottom, -0.1])
        cube([box_x-led_x_tftt-led_x_right, box_y-led_y_top-led_y_bottom, box_z]);
    } else {
      cube([box_x+wall*2+printer_marge, box_y+wall*2+printer_marge, box_z+wall*2+printer_marge]);
    }
  }
}

module box_int(full = false) {
  union(){
    difference() {
      translate([wall, wall, box_z])
        if (full == false)
          cube([box_x-0.15, box_y-0.15, wall*2]);
        else
          cube([box_x, box_y, wall*2]);

      if (full == false) {
        translate([wall+pi_x_left, wall+pi_y_bottom, box_z])
          cube([pi_x, pi_y, wall*2]);
          
        // Screws
        translate([wall*2+hole_axe, wall*2+hole_axe, box_z])
          cylinder(wall*3, d=hole_d, center = false);

        translate([box_x-hole_axe, wall*2+hole_axe, box_z])
          cylinder(wall*3, d=hole_d, center = false);

        translate([wall*2+hole_axe, box_y-hole_axe, box_z])
          cylinder(wall*3, d=hole_d, center = false);

        translate([box_x-hole_axe, box_y-hole_axe, box_z])
          cylinder(wall*3, d=hole_d, center = false);
      }
    }
    
    difference() {
      translate([wall+pi_x_left, wall+pi_y_bottom, box_z])
        if (full == false)
          cube([pi_x, pi_y, pi_z]);
        else
          cube([pi_x+printer_marge, pi_y+printer_marge, pi_z+printer_marge]);

      if (full == false) {
        translate([wall+pi_x_left+wall, wall+pi_y_bottom+wall, box_z])
          cube([pi_x-wall*2, pi_y-wall*2, pi_z-wall*2]);

        // ports USB
        translate([wall+pi_x_left+wall, pi_y_bottom+wall, box_z+wall*2])
          cube([pi_usb_x, wall, pi_usb_z]);

        // ports USBc & HDMI
        translate([wall+pi_x_left, pi_hdmi_bottom, box_z+wall*2])
          cube([wall, pi_hdmi_y, pi_hdmi_z]);
      }
    }
  }
}

module box(full = false) {
  box_ext(full);
  box_int(full);
}

module socle() {
  hole_d = 5;
  difference() {
    translate([0, -10, -box_z*1.5])
      cube([box_x, box_y+20, box_z*1.5]);

      
    translate([box_x*0.5, 0, -box_z*1.8])
      cylinder(box_z*2, d=hole_d, center = false);
    translate([box_x*0.9, 0, -box_z*1.8])
      cylinder(box_z*2, d=hole_d, center = false);
    translate([box_x*0.5, box_y, -box_z*1.8])
      cylinder(box_z*2, d=hole_d, center = false);
    translate([box_x*0.9, box_y, -box_z*1.8])
      cylinder(box_z*2, d=hole_d, center = false);
      
    rotate([0, 45, 0])
      translate([0, 0, box_x/2+wall*3])
        rotate([0, 90, 0])
          translate([-(box_x-wall*2)/2, 0, 0])
            box(full=true);
  }
}

socle();