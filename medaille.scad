// Paramètres
diametre_medaille = 70;
epaisseur_medaille = 5;
nb_facettes = 34;

diametre_hexagone = 36;
epaisseur_hexagone = 3;
prof_facette = 3; // Profondeur du "creux" (le centre des facettes est plus bas)

// Fonction pour interpolation linéaire
function lerp(a,b,t) = a + (b-a)*t;

// Motif facetté (facettes inclinées du bord au centre)
module facettes_soleil_incline() {
    for (i = [0 : nb_facettes-1]) {
        angle1 = 360/nb_facettes * i;
        angle2 = 360/nb_facettes * (i+1);
        h_centre = epaisseur_medaille-prof_facette;
        h_bord   = epaisseur_medaille;
        
        // Chaque facette = trapèze 3D, épais au bord, creusé au centre
        poly = [  
            [0, 0, h_centre],
            [cos(angle1)*diametre_medaille/2, sin(angle1)*diametre_medaille/2, h_bord],
            [cos(angle2)*diametre_medaille/2, sin(angle2)*diametre_medaille/2, h_bord]
        ];

        // Génère un prisme triangulaire 3D pour chaque facette
        polyhedron(
            points=[
                [0, 0, 0], // centre base
                [3+cos(angle1)*diametre_medaille/2, 2+sin(angle1)*diametre_medaille/2, 0], // bord base 1
                [cos(angle2)*diametre_medaille/2, sin(angle2)*diametre_medaille/2, 0], // bord base 2

                [0, 0, h_centre], // sommet centre haut
                [cos(angle1)*diametre_medaille/2, sin(angle1)*diametre_medaille/2, h_bord], // sommet bord 1
                [cos(angle2)*diametre_medaille/2, sin(angle2)*diametre_medaille/2, h_bord] // sommet bord 2
            ],
            faces=[
                [0, 1, 2],    // base dessous
                [3, 4, 5],    // dessus
                [0, 1, 4, 3], // flanc 1
                [1, 2, 5, 4], // flanc 2
                [2, 0, 3, 5]  // flanc 3
            ]
        );
    }
}

// Hexagone central en relief
module hexagone() {
    translate([0,0,epaisseur_medaille-epaisseur_hexagone])
        linear_extrude(height=epaisseur_hexagone)
            polygon(points=[
                for(i=[0:5])
                    [cos(60*i)*diametre_hexagone/2, sin(60*i)*diametre_hexagone/2]
            ]);
}

// Médaille complète
module medaille() {
    color("gold")
    facettes_soleil_incline();  // Effet soleil en relief
    color("gray")
    hexagone();                 // Hexagone central
}

medaille();