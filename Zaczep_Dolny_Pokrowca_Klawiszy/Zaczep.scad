use <MCAD/boxes.scad>

$fn=200;

//9mm grubość, 25mm szerokość, 100mm + 90mm (na skos) długość

module Igrek()
{
    difference()
    {
        union()
        {
            translate([0, -20 - (20.0 / 2), 0])
                roundedCube(size = [90.0, 25.0, 9.0], r = 2, sidesonly = true, center = false);

            translate([0, 0, 0])
                rotate([0, 0, 45 + 180])
                    roundedCube(size = [90.0 + 25.0, 25.0, 9.0], r = 2, sidesonly = true, center = false);
                    
            translate([5, -5, 0])
                rotate([0, 0, -45 + 180])
                    roundedCube(size = [95.0, 25.0, 9.0], r = 2, sidesonly = true, center = false);
        }
        translate([-89, -120, 0])   
            roundedCube(size = [25.0, 200.0, 9.0], r = 2, sidesonly = true, center = false);
    }
}

    difference()
    {
        Igrek();
        translate([0, -20 - (20.0 / 2), 20])
            rotate([0, 10, 0])
                roundedCube(size = [130.0, 25.0, 9.0], r = 2, sidesonly = true, center = false);
    }
