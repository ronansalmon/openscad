// based on https://www.thingiverse.com/thing:1755428/files


printerErrorMargin = 0.2; // Printer XY Dimensional Error
boxWallThickness = 1.5;
coverThickness = 2;
notchWidth = 10;
notchThickness = 1;

// Box side size
boxSizeHeight =  35 + 2*coverThickness;
boxSizeWidth  = 175 + 2*boxWallThickness;
boxSizeDepth  =  50 + 2*boxWallThickness;


/* [HIDDEN] */
$fn = 50;
diffMargin = 0.01;

/* Aux Functions */
module coverCutCylinder(d,h) {
  rotate(a=[-90,0,0])
    cylinder(d=d, h=h);
}

module notch() {
  intersection(){
    cylinder(d=notchWidth, h=notchThickness);
    translate([-notchWidth/2,0,0])
      cube([notchWidth, notchWidth, notchThickness]);
  }
}

module box() {
  bwt = boxWallThickness;
  difference(){
    minkowski(){
      translate([0.5,0.5]) cube([boxSizeDepth-1,boxSizeWidth-1,boxSizeHeight-1]);
      cylinder(d=1,h=1);
    }
        
    translate([bwt,bwt,bwt])
      cube([boxSizeDepth-bwt*2, boxSizeWidth-bwt*2, boxSizeHeight+bwt*2]);
    translate([bwt, -2*diffMargin, boxSizeHeight-coverThickness+diffMargin]){
      cube([boxSizeDepth-bwt*2,bwt*2, coverThickness]);
    }
    
    d = coverThickness*2/3;
    h = boxSizeWidth+2*diffMargin-boxWallThickness;
    
    translate([boxWallThickness,-2*diffMargin, boxSizeHeight-coverThickness+d/2]) 
      coverCutCylinder(d, h);
    translate([boxSizeDepth-boxWallThickness, -2*diffMargin, boxSizeHeight-coverThickness+d/2])
      coverCutCylinder(d, h);
  }
  
}

module cover(){
  bwt = boxWallThickness;
  h = boxSizeWidth-bwt-printerErrorMargin;
  x = boxSizeDepth-bwt*2-printerErrorMargin;
  translate([bwt+0,0,0]){
    difference(){
      cube([x, h, coverThickness]);
      translate([x/2, 10, coverThickness-notchThickness+0.1])
        notch();
    }
    d = coverThickness*2/3;
    translate([0, -2*diffMargin,d/2])
      coverCutCylinder(d, h);
    translate([boxSizeDepth-bwt*2-printerErrorMargin, -2*diffMargin, d/2])
      coverCutCylinder(d, h);
  }

}



//box();
translate([-boxSizeDepth-1,0,0]) cover();
