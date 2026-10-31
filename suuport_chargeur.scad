// --- PARAMÈTRES DU CHARGEUR ---

epaisseur_paroi = 3;        // Épaisseur du plastique

// MOREC BS-PCD018
largeur_chargeur = 74;      // Largeur du boîtier
epaisseur_chargeur = 50;    // Épaisseur (profondeur) du boîtier
hauteur_support = 90;       // Hauteur totale de la demi-boîte
diametre_cable_haut = 30;   // Encoche de 30mm pour le passage du câble
diametre_cable_bas = 13;    // Encoche de 30mm pour le passage du câble

// ouverture devant
rebord = 20; // Largeur de la lèvre de maintien à gauche et à droite
hauteur_rebord_bas = 15; // Hauteur du rebord plein en bas

// --- PARAMÈTRES DE FIXATION ---
diametre_vis = 5;           // Diamètre du filetage de la vis murale
diametre_tete_vis = 9;      // Diamètre de la tête de vis (pour le fraisage)

module support_mural() {
    difference() {
        // 1. Corps principal extérieur
        cube([
            largeur_chargeur + (2 * epaisseur_paroi),
            epaisseur_chargeur + (2 * epaisseur_paroi),
            hauteur_support
        ]);

        // 2. Évidement central (pour glisser le chargeur, ouvert en haut)
        translate([epaisseur_paroi, epaisseur_paroi, epaisseur_paroi])
            cube([
                largeur_chargeur, 
                epaisseur_chargeur, 
                hauteur_support + 1
            ]);

        // 3. Fenêtre frontale (garde des rebords pour bloquer le chargeur)
        translate([epaisseur_paroi + rebord, epaisseur_paroi + epaisseur_chargeur - 1, epaisseur_paroi + hauteur_rebord_bas])
            cube([
                largeur_chargeur - (2 * rebord), 
                epaisseur_paroi + 2, 
                hauteur_support
            ]);

        // 4. Encoche en U pour le câble en bas (diamètre 30mm)
        hull() {
          translate([(largeur_chargeur + 2*epaisseur_paroi)/2, epaisseur_paroi + epaisseur_chargeur/2, -1]) {
              // Le trou rond
              cylinder(h = epaisseur_paroi + 2, d = diametre_cable_haut, $fn=60);
              // L'ouverture vers l'avant pour former le U
                  //cube([diametre_cable_haut, epaisseur_chargeur + epaisseur_paroi, epaisseur_paroi + 2]);
          }
          translate([(largeur_chargeur + 2*epaisseur_paroi)/2, epaisseur_chargeur+diametre_cable_bas/2, -1]) {
              cylinder(h = hauteur_support + 2, d = diametre_cable_bas, $fn=60);
          }
        }
        
        // 5. Trous de fixation murale (dans le dos de la boîte)
        marge_vis = 15;
        for (x = [marge_vis, largeur_chargeur + 2*epaisseur_paroi - marge_vis]) {
            for (z = [marge_vis, hauteur_support - marge_vis]) {
                translate([x, -1, z]) {
                    rotate([-90, 0, 0]) {
                        // Trou pour la tige de la vis
                        cylinder(h = epaisseur_paroi + 2, d = diametre_vis, $fn=30);
                        // Fraisage conique pour cacher la tête de vis à l'intérieur
                        translate([0, 0, epaisseur_paroi - 2])
                            cylinder(h = 3, d1 = diametre_vis, d2 = diametre_tete_vis, $fn=30);
                    }
                }
            }
        }

        // 6. Ouvertures de ventilation latérales pour la dissipation thermique
        largeur_fente = 5;
        hauteur_fente = hauteur_support - 30;
        espacement_fente = 12;
        nb_fentes = floor((epaisseur_chargeur - 10) / espacement_fente);

        for (i = [1 : nb_fentes]) {
            // Découpes flanc gauche
            translate([-1, epaisseur_paroi + 2 + i*espacement_fente, 15])
                cube([epaisseur_paroi + 2, largeur_fente, hauteur_fente]);
            // Découpes flanc droit
            translate([largeur_chargeur + epaisseur_paroi - 1, epaisseur_paroi + 2 + i*espacement_fente, 15])
                cube([epaisseur_paroi + 2, largeur_fente, hauteur_fente]);
        }
        translate([largeur_chargeur*.15, (epaisseur_chargeur - epaisseur_chargeur*.7)/2, -1])
          cube([epaisseur_paroi + 2, epaisseur_chargeur*.7, largeur_fente]);
        translate([largeur_chargeur*.85, (epaisseur_chargeur - epaisseur_chargeur*.7)/2, -1])
          cube([epaisseur_paroi + 2, epaisseur_chargeur*.7, largeur_fente]);
    }
}

// Rendu final
support_mural();