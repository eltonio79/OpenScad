$fn = 64;

minkowski ()
{
    cube ([7, 2, 1.0]);
    translate([0.25, 0.25, 0.25])
    sphere(0.3);
}

translate([1.65, 0.85, 2.5])
    cylinder(h = 3, r=0.4, center = true);
translate([6.15, 0.85, 2.5])
    cylinder(h = 3, r=0.4, center = true);
//cylinder();
//rotate ([-90, 0, 0]) 