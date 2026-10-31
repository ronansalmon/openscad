$fn = 60;
inner = 67.5;
outer = 90;
inner_z = 15;
wall = 2;

difference() {
  union() {
    cylinder(d=inner+wall*2,h=inner_z);
    cylinder(d=outer,h=wall);
  }    
  cylinder(d=inner,h=inner_z);
}