// Support mural pour Switch Réseau D-Link GO-SW-8G (130 x 90 x 25 mm)
// Conçu pour s'imprimer SANS supports (imprimer à plat sur le dos)

// --- Paramètres ajustables ---
largeur_switch = 130;
profondeur_switch = 25;
marge = 2; // Marge pour que le switch glisse facilement

// Dimensions internes calculées
int_w = largeur_switch + marge; 
int_d = profondeur_switch + marge;
int_h = 50; // Hauteur de maintien 

ep = 3; // Épaisseur des parois (3mm pour la solidité)

module support() {
    difference() {
        // 1. Bloc extérieur complet
        cube([int_w + 2*ep, int_d + 2*ep, int_h + ep]);
        
        // 2. Évidement central (l'endroit où on glisse le switch)
        translate([ep, ep, ep])
            cube([int_w, int_d, int_h + 1]);
            
        // 3. Grande ouverture à l'avant (économie de plastique et aération)
        translate([ep + 12, int_d + ep - 1, ep])
            cube([int_w - 24, ep + 2, int_h + 1]);
            
        // 4. Ouverture en bas (pour les câbles réseau si orientés vers le bas)
        translate([ep + 12, ep, -1])
            cube([int_w - 24, int_d, ep + 2]);
            
        // 5. Trous de fixation murale (au dos)
        translate([25, -1, int_h/2 + ep])
            rotate([-90, 0, 0])
            cylinder(d=4.5, h=ep+2, $fn=30);
            
        translate([int_w + 2*ep - 25, -1, int_h/2 + ep])
            rotate([-90, 0, 0])
            cylinder(d=4.5, h=ep+2, $fn=30);
            
        // 6. Fraisures pour cacher les têtes de vis (diamètre 8.5mm)
        translate([25, ep, int_h/2 + ep])
            rotate([90, 0, 0])
            cylinder(d1=8.5, d2=4.5, h=2.1, $fn=30); 
            
        translate([int_w + 2*ep - 25, ep, int_h/2 + ep])
            rotate([90, 0, 0])
            cylinder(d1=8.5, d2=4.5, h=2.1, $fn=30);
            
        // 7. Trous latéraux pour le connecteur d'alimentation
        // Démarre à 5mm du fond et s'arrête à 20mm du bord supérieur 
        // pour conserver une ceinture très rigide en haut de la pièce.
        translate([-1, ep + 3, ep + 5])
            cube([int_w + 2*ep + 2, int_d - 6, 25]);
    }
}

support();