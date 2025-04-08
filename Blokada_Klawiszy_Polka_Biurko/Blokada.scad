use <MCAD/boxes.scad>

$fn=200;

//8mm grubość, 18.5mm szerokość, 120mm długość + 10mm szerokość, 40mm długość "L" w jedną stronę
union()
{
    translate([-5, 0, 0])
        rotate([0, 0, 0])
            roundedCube(size = [120.0, 18.5 - 0.2, 8.0 - 0.2], r = 2, sidesonly = true, center = false);
            
    translate([0, 0, 0])
        rotate([0, 0, 90])
            roundedCube(size = [40.0, 8.0, 8.0 - 0.2], r = 2, sidesonly = true, center = false);
}
        