$fn = 50;

difference()
{
    union()
    {
        cube([14, 25, 6]);
    translate ([0, 25, - (27 - 22)]) rotate ([90, 0, 0]) cube([14, 27, 7]);
    }
    
    union()
    {
        translate ([2, 25, - (27 - 22)]) rotate ([90, 0, 0]) cube([10, 27, 2]);
        translate ([14 / 2, 25, 18]) rotate([90, 0, 0]) cylinder(h=20, r=3.3 / 2, center=true);
        translate ([14 / 2, 7, 0]) cylinder(h=20, r=5.5 / 2, center=true);
    }
}
    translate ([14 / 2, 22.5, -0.8]) rotate([90, 0, 0]) cylinder(h=5, r=2.8 / 2, center=true);

