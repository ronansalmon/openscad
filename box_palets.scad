
boxWallThickness = 4;
coverThickness = 3;
notchWidth = 10;
notchThickness = 1;
printerMargin = 0.5;

// Box inner size
boxSizeHeight = boxWallThickness+coverThickness   + 57;
boxSizeWidth  = 2*boxWallThickness + 116;
boxSizeDepth  = 2*boxWallThickness + 57;


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
    cube([boxSizeDepth, boxSizeWidth, boxSizeHeight]);
   translate([boxWallThickness, boxWallThickness, boxWallThickness]){
      cube([boxSizeDepth-2*boxWallThickness, boxSizeWidth-2*boxWallThickness, boxSizeHeight-boxWallThickness-coverThickness]);
    }
    
    translate([0,0, boxSizeHeight-coverThickness]) cover(0, false);
  }  
}

module cover(margin=printerMargin, notch=true){
  h = boxSizeWidth-boxWallThickness-margin;
  x = boxSizeDepth-boxWallThickness*2-margin;
  
  translate([boxWallThickness+0,0,0]){
    difference(){
      hull() {
        #cube([x, h, coverThickness]);
        #translate([-coverThickness/2, 0,0])
          cube([x+coverThickness, h+coverThickness/1.5, 0.1]);
      }
      
      if (notch)
        translate([x/2, 10, coverThickness-notchThickness+0.1])
          notch();
    }
  }
}


//box();
cover();