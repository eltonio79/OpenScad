$fn=75;

x1 = 29.0;
y1 = 50.0;
z1 = 7.5;

x2 = 27.0;
//y2 = 22 - 10 + 1;
y2 = 22 - 10 + 2;
z2 = x1;

rBearing = 19.1 / 2;
rBolt = 5.4 / 2;

BearingHolder();

module BearingHolder()
{
    difference()
    {
        union()
        {
            BearingsHolder();
            translate([0, y1 / 2 - x2 / 2, 0]) rotate([90, 0, 90]) BearingsSlot();
        }
        // dziury
        union()
        {
            translate([0, y1 / 2 - x2 / 2, 0]) rotate([90, 0, 90]) translate([x2 / 2, y2, 0]) cylinder(h = x1, r = rBearing, center = false);

            translate([x1 / 2, (y1 - x2) / 2 / 2, 0]) cylinder(h = z1, r = rBolt, center = false);
            translate([x1 / 2, y1 - ((y1 - x2) / 2 / 2), 0]) cylinder(h = z1, r = rBolt, center = false);
        }
    }
}

module RoundedCubeEx(x_, y_, z_, r_)
{
    hull ()
    { 
        translate ([r_, r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
        translate ([x_ - r_, r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
        translate ([x_ - r_, y_ -r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
        translate ([r_, y_ - r_, z_ / 2]) cylinder(h = z_, r = r_, center = true);
    }
}

module BearingsSlot()
{
    difference()
    {
        union()
        {
            translate([x2 / 2, y2, 0]) cylinder(h = z2, r = x2 / 2, center = false);
            cube([x2, y2, z2]);
        }
        translate([0, -5, 0]) cube([x2, 5, z2]);
    }
}

module BearingsHolder()
{
    RoundedCubeEx(x1, y1, z1, 2);
}