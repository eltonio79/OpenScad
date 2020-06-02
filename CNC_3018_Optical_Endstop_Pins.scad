$fn=50;

//Pyciek_Z();
//Pyciek_X();
Pyciek_Y();

module RoundedCube(x_, y_, z_, r_)
{
    hull ()
    { 
        translate ([r_, r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
        translate ([x_ - r_, r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
        translate ([x_ - r_, y_ -r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
        translate ([r_, y_ - r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
    }
}

module Pyciek_Z()
{
    heightBase = 2.0;
    heightPyciek = 1.6;

    RoundedCube(7, 12, heightBase, 2);
    //translate([0, 5, 0]) cube([7, 2, 7]);
    translate([0, 7]) rotate ([90, 0, 0]) RoundedCube(7, 7, heightBase, 1.5);
}

module Pyciek_X()
{
    heightBase = 8.0;
    widthBase = 25.0;
    depthBase = 2.5;
    depthPyciek = 1.6;
    
    translate([0, (57 / 2) - (25 / 2), 0]) RoundedCube(heightBase, widthBase, depthBase, 2);

    translate([3.2, 0, depthBase]) rotate([90, 0, 90]) RoundedCube(57, 6, depthPyciek, 2);
}

module Pyciek_Y()
{
    depthPyciek = 1.6;

difference(){
cube([15, 25, 6]);
translate ([7.5, 15, 0]) cylinder(h = 6, r = 5.6 / 2, center = false);}

translate ([0, 3, -32.3 + 6]) rotate([90, 0, 0]) cube([15, 32.3, 3]);

translate ([0, 0, -32.3 + 6 - (depthPyciek / 2)]) rotate([0, 0, 0]) cube([15, 10, depthPyciek]);
}