printerMargin = 0.5;

boxWallThickness = 2;
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
        
    translate([boxWallThickness,boxWallThickness,boxWallThickness])
      cube([boxSizeDepth-boxWallThickness*2, boxSizeWidth-boxWallThickness*2, boxSizeHeight+boxWallThickness*2]);
    translate([boxWallThickness, -2*diffMargin, boxSizeHeight-coverThickness+diffMargin]){
      cube([boxSizeDepth-boxWallThickness*2,boxWallThickness*2, coverThickness]);
    }

    translate([0,0, boxSizeHeight-coverThickness]) cover(0);
    
  }
  
}

module cover(margin=printerMargin){
  h = boxSizeWidth-boxWallThickness-margin;
  x = boxSizeDepth-boxWallThickness*2-margin;
  
  translate([boxWallThickness+0,0,0]){
    difference(){
      hull() {
        cube([x, h, coverThickness]);
        translate([-coverThickness/2, 0,0])
          cube([x+coverThickness, h+coverThickness/1.5, 0.1]);
      }
      translate([x/2, 10, coverThickness-notchThickness+0.1])
        notch();
    }
  }
}



box();
translate([-boxSizeDepth-1,0,0]) cover();
