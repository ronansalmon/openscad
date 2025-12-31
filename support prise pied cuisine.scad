$fn = 100;

r = 67/2;
encoche = 10;
r_in = 49.5/2;

module ergo() {

  union() {
    translate([-3, -0.3, 1])
      hull(){
        cube([6,2,5]);
        cube([6,3.8,1]);
      }
    translate([-3, -0.3, -3.5])
      cube([6,2.1,4.5]);
  }
}

module encoche_plastron() {
  difference() {
    cylinder(1, r-9.5,  r-9.5);
    translate([0, 0, -0.1])
      cylinder(2, r-11,  r-11);
  }
}
union() {
  difference() {
    // plateau & support cylindre
    union() {
      cylinder(1, r,  r);
      translate([0, 0, 1])
        cylinder(1, r-1, r-1);

      translate([0, 0, 1])
        cylinder(10, r_in+0.5, r_in+0.5);
    
    }
    
    // défonce plastron
    translate([0, 0, -0.1]) encoche_plastron();
    translate([r-2, -5, -0.1])
      cube([encoche,encoche,3]);
    translate([-r-encoche+2, -5, -0.1])
      cube([encoche,encoche,3]);
    translate([-5, r-2, -0.1])
      cube([encoche,encoche,3]);
    translate([-5, -r-encoche+2, -0.1])
      cube([encoche,encoche,3]);

    
    // trou support de prise
    translate([0, 0, 2])
      cylinder(30, r_in-1.5, r_in-1.5);
    translate([0, 0, -0.1])
      cylinder(30, 42/2, 42/2);
    
    // trou vis fixation
    translate([r-2-3.5, 0, -0.1])
      cylinder(3, 4.9/2, 2.9/2);
    translate([-r+2+3.5, 0, -0.1])
      cylinder(3, 4.9/2, 2.9/2);
    translate([0, r-2-3.5, -0.1])
      cylinder(3, 4.9/2, 2.9/2);
    translate([0, -r+2+3.5, -0.1])
      cylinder(3, 4.9/2, 2.9/2);

    // souplesse à l'insert pour les ergos
    translate([-50, -5, 5])
      cube([100, 10, 20]);
    translate([-5, -50, 5])
      cube([10, 100, 20]);
      
  }

  translate([0, -r_in, 5])
    rotate([0,0,0])
      ergo();

  translate([0, r_in, 5])
    rotate([0,0,180])
      ergo();

  translate([r_in, 0, 5])
    rotate([0,0,90])
      ergo();

  translate([-r_in, 0, 5])
    rotate([0,0,270])
      ergo();
}