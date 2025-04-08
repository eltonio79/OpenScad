use <MCAD/boxes.scad>

$fn=200;

// Grubość ścianki X
sciankaX = 0.87;   // [0.2:0.01:5]

// Grubość ścianki Y
sciankaY = 0.87;   // [0.2:0.01:5]

// Grubość ścianki Z
sciankaZ = 0.32;   // [0.2:0.01:5]

// Szerokość zaczepu
zaczep = 5;        // [1:0.5:10]

//BoxGrubosc=0.5; // [0.5, 0.8, 1.0, 1.2]
//BoxSzerokosc=0.5; //[5]
//BoxDlugosc=5; // [5:10]
//BoxWysokosc=7.5; // [2.5:2.5:10]

module Lampka(x, y, z, tuba = true)
{
    tubaR = z / 1.6; // 1.45
    tubaH = tubaR * 2;

    difference()
    {
        roundedCube(size = [x, y, z], r = x / 4, sidesonly = true, center = true);

        if (tuba == true)
        {
            translate([0, (-y / 2) , ((2 * tubaR - z) / 2) + 1.25])
                rotate([90, 90, 180])
                {
                    cylinder(h = tubaH, r = tubaR, center = true);

                    translate([0, 0, tubaH / 2])
                        sphere(r = tubaR);
                }
        }
    }
}

lampkaX = 49;
lampkaY = 105;
lampkaZ = 9;

wypust = 7.5;
wydluzenie = 20;

difference()
{
    difference()
    {
        Lampka(lampkaX + (2 * sciankaX), lampkaY + (2 * sciankaY), lampkaZ + (2 * sciankaZ));

        translate([0, - (wydluzenie / 2), 0])
            Lampka(lampkaX, lampkaY + wydluzenie, lampkaZ, false);
    }
    translate([0, 0, - (4 * sciankaZ)])
        Lampka(lampkaX - zaczep, lampkaY - zaczep, lampkaZ + (2 * sciankaZ), false);
}