/* This is a configurable OpenSCAD script to generate square tubing connectors. It comes configured to fit standard 1" x 0.065" wall aluminum tubing, but you should fine tune for your printer and tubing. 

    To use, first uncomment the appropriate variable definition lines for the configuration you want in one of the following two categories, then enter the required dimensions 
    
    1) CONNECTOR - A connector starts with one finger in the z-axis (best orientation for printing). Up to five additional fingers can be selected relative to the first finger orientation (bottom, top, left, right, straight). Support is required for all additional fingers except straight.
    
    2) SIZING TEST - Try one of these on your printer and test fit your tubing before printing a whole connector. The test fingers make a nice end plug or foot once you get them sized right.   
   */

// What Do You Want to Build (select 1 or 2)?

//1) CONNECTOR (comes with one finger, enable more if desired)
connector=true;
//bottomfinger=true;
//topfinger=true;
//leftfinger=true;
//rightfinger=true;
//straightfinger=true;

//2) SIZING TEST (variable connector must be commented out)
//testfinger=true;

//DIMENSIONS
tsize=25.4; //tubing size in mm
csize=25.6; //corner cube dimension
fsize=22.2; //finger cube dimension (size to desired fit in tubing)
vsize=1.5; //vein width

//High resolution (comment these lines out if you want faster rendering for testing)
$fs = 0.2;
$fa = 3;

union() {
  if(connector==true) {
    cube([csize,csize,csize],center=true);
    finger();  
    if(bottomfinger==true)
      rotate([-90,0,0]) finger();
    if(topfinger==true)
      rotate([90,0,0]) finger();
    if(leftfinger==true)
      rotate([0,90,0]) finger();
    if(rightfinger==true)
      rotate([0,-90,0]) finger();
    if(straightfinger==true)
      rotate([0,180,0]) finger();
  } else
    if(testfinger==true) {
      translate([0,0,1.5])
        cube([csize,csize,3], center=true);
      translate([0,0,(3-csize/2*0.4)])
        scale([1,1,0.4]) finger(); 
    }
};

module finger() {
  translate([0,0,(csize+fsize)/2]) {
    cube([(fsize-2*vsize),(fsize-2*vsize),fsize],center=true);
    for(i=[0:90:270])
      rotate([0,0,i]) vein();
  }
}

module vein() {
  for(i=[-1:1])
    translate([(fsize-vsize)/2,i*(tsize/6),0]) 
      cube([vsize,vsize,fsize],center=true);
}