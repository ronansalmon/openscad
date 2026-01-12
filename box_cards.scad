
// 32 cards
//internalz     = 11; // internal overall z dimension
//internalx     = 90; // internal x dimension
//internaly     = 57; // internal y dimension

// 54 cards
//internalz     = 20; // internal overall z dimension
//internalx     = 90; // internal x dimension
//internaly     = 57; // internal y dimension

// tarot
//internalz     = 29; // internal overall z dimension
//internalx     = 114; // internal x dimension
//internaly     = 62.5; // internal y dimension

// uno
internalz     = 32; // internal overall z dimension
internalx     = 90; // internal x dimension
internaly     = 57; // internal y dimension

internal_lidz = 4.5; // this is taken of off the internalz for the bottom height and acts as the lid internal height
lip_overlap   = 3.5; // how much overlap between box and lid, this works as a default but can be shrunk as needed
wallthickness = 2; // this is the wall of the lip, the box is twice as thick





//#############################
// INTERNAL VARIABLES, DO NOT MODIFY
actual_lid_z = internal_lidz + wallthickness;
actual_y = internaly + 2*wallthickness;
actual_x = internalx + 2*wallthickness;
actual_z = internalz + 2*wallthickness;

echo(actual_lid_z);

module lock(h) {
  rotate([-90,0,0])
    cylinder(r = 0.3, h = h, $fn = 30);
}

module lid(printerMargin=0, h = actual_y/4) {
  union() {
    difference() {
      cube([actual_x, actual_y, actual_lid_z]);
      
      translate([wallthickness, wallthickness, -0.01])
        cube([internalx,internaly,internal_lidz]);

      translate([wallthickness/2-printerMargin, wallthickness/2-printerMargin, -0.01])
        cube([internalx+wallthickness+2*printerMargin, internaly+wallthickness+2*printerMargin, lip_overlap]);

      // Holes (we can see what's inside!)
      translate([wallthickness+internalx/2-internalx/1.5/2, wallthickness++internaly/2-internaly/1.5/2, wallthickness*2])
        cube([internalx/1.5,internaly/1.5,internal_lidz]);
    
    }

    // lock
    translate([wallthickness/2, actual_y/2-h/2, lip_overlap/2]) lock(h);
    translate([actual_x-wallthickness/2, actual_y/2-h/2, lip_overlap/2]) lock(h);

  }
}

module bottom() {
  difference() {
    cube([actual_x, actual_y, actual_z]);
    translate([wallthickness, wallthickness, wallthickness])
      cube([internalx, internaly, internalz+10]);
    translate([0,0,actual_z-actual_lid_z]) lid(h = actual_y/2); 
  }
}



bottom();
//translate([0,-10,actual_lid_z]) rotate([180,0,0]) lid(printerMargin=0.25);