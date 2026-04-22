//include <BOSL2/std.scad>

$fn             = 200;

wallThickness   = 2;
lipwallThickness   = 1;
internalRadius  = 42-lipwallThickness;
lipThickness    = 11;
topThickness    = 1.5;
hook=2;

box_w = 145;
box_d = 145;
box_h = 145;
box_wallThickness = 3;
screw_x = 20;
screw_y = 3.5;
screw_holder_h = 17;
screw_holder_d = 7;

lid_net_thickness = 0.5; // Épaisseur du fil
lid_net_distance = 3;  // Espace entre les fils
lid_net_length = box_w;   // net_length
lid_net_height = 1;        // net_height/Profondeur du filet

side_net_thickness = 5; // Épaisseur du fil
side_net_distance = 5;  // Espace entre les fils
side_net_length = box_w;   // net_length
side_net_height = box_wallThickness;        // net_height/Profondeur du filet

funnel_bottom = 16;
funnel_top = 6;

module funnel() {
  difference() {
    cylinder(r1=funnel_bottom, r2=funnel_top, h=37);
    cylinder(r1=funnel_bottom-wallThickness, r2=funnel_top-wallThickness, h=37);
    for ( i = [0 : 60 : 120] ){
      translate([0, 0, funnel_bottom*1.4])
        rotate([0, 0, i])
          cube([funnel_bottom*2, 2, 15], center=true);
    }
    for ( i = [30 : 60 : 150] ){
      translate([0, 0, funnel_bottom/1.4])
        rotate([0, 0, i])
          cube([funnel_bottom*2, 2, 15], center=true);
    }
  }
}


module mosquito_net(net_distance, net_thickness, net_length, net_height) {
  // X axes
  for (y = [0 : net_distance + net_thickness : net_length]) {
    translate([0, y, 0])
      cube([net_length, net_thickness, net_height]);
  }

  // Y axes
  for (x = [0 : net_distance + net_thickness : net_length]) {
    translate([x, 0, 0])
      cube([net_thickness, net_length, net_height]);
  }
}

module drawLid(
    internalRadius=internalRadius, 
    lipThickness=lipThickness, 
    lipwallThickness=lipwallThickness, 
    topThickness=topThickness
    ) {

  lipThickness = lipThickness - 1;
  union() {
    difference() {
      difference() {
        difference() {
          translate([0, 0, topThickness])
            rotate_extrude(angle=360) 
              polygon( points=[[0,0],
                           [internalRadius,0],
                           [internalRadius,lipThickness-1],
                           [internalRadius-hook,lipThickness],
                           [internalRadius-hook,lipThickness+1],
                           [internalRadius+lipwallThickness,lipThickness+1],
                           [internalRadius+lipwallThickness,-topThickness],
                           [0,-topThickness],
                           ] 
              );

        }

        union()  {
            translate([0, 0, (lipThickness/2)+topThickness+1])
                cube([(internalRadius+lipwallThickness)*2, internalRadius/2, lipThickness+topThickness], center=true);
            rotate([0, 0, 60])
                translate([0, 0, (lipThickness/2)+topThickness+1])
                    cube([(internalRadius+lipwallThickness)*2, internalRadius/2, lipThickness+topThickness], center=true);
            rotate([0, 0, 120])
                translate([0, 0, (lipThickness/2)+topThickness+1])
                    cube([(internalRadius+lipwallThickness)*2, internalRadius/2, lipThickness+topThickness], center=true);
        }
      }
    }
    difference() {
      cylinder(r=internalRadius+wallThickness,h=lipThickness+lipwallThickness+topThickness);
      cylinder(r=internalRadius,h=lipThickness+lipwallThickness+topThickness);
    }
  }
}


module lid_grid() {
  union() {
    difference() {
      drawLid();
      cylinder(r=internalRadius-5,h=10);
    }
    intersection() {
      cylinder(r=internalRadius+wallThickness,h=lipThickness+lipwallThickness+topThickness);
      
      translate([-lid_net_length/2, -lid_net_length/2, 0])
        mosquito_net(net_distance=lid_net_distance, net_thickness=lid_net_thickness, net_length=lid_net_length, net_height=lid_net_height);
    }
  }
}

module screw_hole() {
  cylinder(h=box_wallThickness, r1=1.1, r2=3);
}
module screw_holder() {
  difference(){
    hull() {
      translate([0, screw_holder_d/2, 0])
        cube([screw_holder_d, 1, screw_holder_h], center=true);
      cylinder(h=screw_holder_h, d=screw_holder_d, center=true);
    }
    cylinder(h=screw_holder_h, d=3, center=true);
  }
}

module bottom() {
  difference(){
    // dirty fix, need to realign screw holes
    translate([-box_wallThickness, -box_wallThickness, 0])
      cube([box_w+box_wallThickness*2, box_d+box_wallThickness*2, box_wallThickness]);
    translate([box_w/2, box_d/2, 0])
      cylinder(r=internalRadius+wallThickness,h=lipThickness+lipwallThickness+topThickness);

    translate([screw_x, screw_y, 0])
      screw_hole();
    translate([screw_y, screw_x, 0])
      screw_hole();

    translate([box_w-screw_x, screw_y, 0])
      screw_hole();
    translate([box_w-screw_y, screw_x, 0])
      screw_hole();
    
    translate([screw_x, box_d-screw_y, 0])
      screw_hole();
    translate([screw_y, box_d-screw_x, 0])
      screw_hole();
    
    translate([box_w-screw_x, box_d-screw_y, 0])
      screw_hole();
    translate([box_w-screw_y, box_d-screw_x, 0])
      screw_hole();

  }
  translate([box_w/2, box_d/2, 0])
    lid_grid();
}

module side() {
  union() {
    difference() {
      cube([box_w, box_d, box_wallThickness]);
      translate([box_wallThickness,box_wallThickness,0])
        cube([box_w-box_wallThickness*2, box_d-box_wallThickness*2, box_wallThickness]);
      translate([box_w/2, box_d/3, 0])
        cylinder(r=funnel_bottom, h=box_wallThickness);
    }
    difference() {
      mosquito_net(net_distance=side_net_distance, net_thickness=side_net_thickness, net_length=side_net_length, net_height=side_net_height);
      translate([box_w/2, box_d/3, 0])
        cylinder(r=funnel_bottom, h=box_wallThickness);
    }
    translate([box_w/2, box_d/3, 0])
      funnel();
    
    translate([screw_x, screw_holder_h/2, box_wallThickness+screw_y])
      rotate([270, 0, 0])
        screw_holder();
    translate([box_w-screw_x, screw_holder_h/2, box_wallThickness+screw_y])
      rotate([270, 0, 0])
        screw_holder();
    translate([screw_x, box_d-screw_holder_h/2, box_wallThickness+screw_y])
      rotate([270, 0, 0])
        screw_holder();
    translate([box_w-screw_x, box_d-screw_holder_h/2, box_wallThickness+screw_y])
      rotate([270, 0, 0])
        screw_holder();
  }
}
module top() {
  difference() {
    // dirty fix, need to realign screw holes
    translate([-box_wallThickness, -box_wallThickness, 0])
      cube([box_w+box_wallThickness*2, box_d+box_wallThickness*2, box_wallThickness]);
    
    translate([screw_x, screw_y, 0])
      screw_hole();
    translate([screw_y, screw_x, 0])
      screw_hole();

    translate([box_w-screw_x, screw_y, 0])
      screw_hole();
    translate([box_w-screw_y, screw_x, 0])
      screw_hole();
    
    translate([screw_x, box_d-screw_y, 0])
      screw_hole();
    translate([screw_y, box_d-screw_x, 0])
      screw_hole();
    
    translate([box_w-screw_x, box_d-screw_y, 0])
      screw_hole();
    translate([box_w-screw_y, box_d-screw_x, 0])
      screw_hole();
  }
  translate([box_w/2, box_d/2, 9/2])
    rotate([90, 90, 0])
      difference() {
        rotate_extrude()
          translate([10, 0, 0])
            circle(d = 6);
        translate([9, 0, 0])
          cube([10, 100, 10], center =true);
}
    

}


//bottom();
side();
//top();
