// CLAPET DE DÉCHARGE POUR ASPIRATEUR
include <BOSL2/std.scad>

diametre_interne = 31;
epaisseur_paroi = 4;
hauteur_corps = 40;
entaille = 12;
rainure_hauteur = 20;
rainure_largeur = 13;
teton_hauteur = 2;
teton_largeur = 1;
teton_profondeur = 1.5;
teton_dist_rainure = 7;

$fn = 100;

union() {
  
    // renfort
  difference() {
    cylinder(h = epaisseur_paroi, d = diametre_interne+epaisseur_paroi*2, center = false);
    cylinder(h = epaisseur_paroi, d = diametre_interne, center = false);
    translate([diametre_interne/2-entaille/2, -entaille/2, -1])
      cube([entaille, entaille, hauteur_corps+2]);
  }
  difference() {
    translate([0, 0, hauteur_corps-epaisseur_paroi])
      cylinder(h = epaisseur_paroi, d = diametre_interne+epaisseur_paroi*2, center = false);
    translate([0, 0, hauteur_corps-epaisseur_paroi])
      cylinder(h = epaisseur_paroi, d = diametre_interne, center = false);
    translate([diametre_interne/2-entaille/2, -entaille/2, -1])
      cube([entaille, entaille, hauteur_corps+2]);
  }
  
  
  difference() {
    cylinder(h = hauteur_corps, d = diametre_interne+epaisseur_paroi, center = false);
    translate([0, 0, -1])
      cylinder(h = hauteur_corps+2, d = diametre_interne, center = false);
    translate([diametre_interne/2-entaille/2, -entaille/2, -1])
      cube([entaille, entaille, hauteur_corps+2]);
    // rainure
    translate([-diametre_interne/2-entaille/2, -entaille/2, hauteur_corps/2-rainure_hauteur/2])
      cube([rainure_largeur, rainure_largeur, rainure_hauteur]);
       
  }
  // teton
  rotate([0, 0, 30])
    translate([-diametre_interne/2, 0, hauteur_corps/2-rainure_hauteur/2-teton_dist_rainure+teton_hauteur/2])
      cuboid([teton_profondeur, teton_largeur, teton_hauteur], center = true, rounding = 0.2);
  
}