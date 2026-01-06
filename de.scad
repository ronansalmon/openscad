// https://cyberweb.cite-sciences.fr/wiki/lib/exe/fetch.php?media=animations:ateliers_openscad:exercices:atelier_de2.scad

taillede     =   50;
ecartementde = 0.25;
$fn          =   50;

//corps du dé.
difference(){	
  intersection(){//donne le coté arrondi au cube			
    cube(taillede, center=true); //cube de la taille définie
    sphere(r=0.7*taillede, $fn=200);
  } //sphere de diamètre définie qui permet d'arrondir les angles
	
  
  //Faces 1/6
	translate([0,0,(-0.1+taillede/2)]) {
    //translate d'une demie hauteur le cylindre à enlever
		cylinder(d=taillede/5,h=0.5);//cylindre à enlever
	}

	translate([ecartementde*taillede,0,-(0.1+taillede/2)]) {
		cylinder(d=taillede/5,h=0.5);
	}
	translate([-ecartementde*taillede,0,-(0.1+taillede/2)]) {
		cylinder(d=taillede/5,h=0.5);
	}
	translate([ecartementde*taillede,ecartementde*taillede,-(0.1+taillede/2)]) {
		cylinder(d=taillede/5,h=0.5);
	}
	translate([-ecartementde*taillede,ecartementde*taillede,-(0.1+taillede/2)]) {
		cylinder(d=taillede/5,h=0.5);
	}
	translate([ecartementde*taillede,-ecartementde*taillede,-(0.1+taillede/2)]) {
		cylinder(d=taillede/5,h=0.5);
	}
	translate([-ecartementde*taillede,-ecartementde*taillede,-(0.1+taillede/2)]) {
		cylinder(d=taillede/5,h=0.5);
	}

//Faces 2/5
	rotate([90,0,0]){
		translate([0,0,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([ecartementde*taillede,ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([-ecartementde*taillede,ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([ecartementde*taillede,-ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([-ecartementde*taillede,-ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
	}//fin rotate

	rotate([-90,0,0]){
		translate([-ecartementde*taillede,ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([ecartementde*taillede,-ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
	}//fin rotate

//Faces 3/4
	rotate([0,90,0]){
		translate([0,0,(-0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([ecartementde*taillede,ecartementde*taillede,(-0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([-ecartementde*taillede,-ecartementde*taillede,(-0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}

		translate([ecartementde*taillede,ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([-ecartementde*taillede,ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([ecartementde*taillede,-ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
		translate([-ecartementde*taillede,-ecartementde*taillede,-(0.1+taillede/2)]) {
			cylinder(d=taillede/5,h=0.5);
		}
	}//fin rotate
}//fin diff