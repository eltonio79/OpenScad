$fn = 64;

minkowski ()
{
    cube ([15, 7, 1.5]);
    translate([0.25, 0.25, 0.25])
    sphere(0.3);
}

translate([8.25, 0, 0])
rotate([0, -90, 0])
minkowski ()
{
    cube ([10, 7, 1.5]);
    translate([0.25, 0.25, 0.25])
    sphere(0.3);
}


//10, 1.5 7 15