$fn = 50;

dlugosc = 13;
szerokosc = 8;
wysokosc = 1.7;
wysokoscMasztu = 10;


minkowski()
{
mirror ([1, 0, 0]) cube([dlugosc, szerokosc, wysokosc]);
cylinder(wysokosc/2,wysokosc/2,wysokosc/2);
}
minkowski()
{
mirror ([1, 0, 0]) translate([0, szerokosc - 5.5, 1.25])
    cube([dlugosc + 12, wysokosc/2, szerokosc]);
mirror ([1, 0, 0]) translate([0, szerokosc - 5.5, 1.25])
    sphere(wysokosc/2,wysokosc/2,wysokosc/2, false);
}

minkowski()
{
translate([5, 0, 0]) cube([dlugosc, szerokosc, wysokosc]);
translate([5, 0, 0]) cylinder(wysokosc/2,wysokosc/2,wysokosc/2);
}
minkowski()
{
translate([5, 0, 0]) translate([0, szerokosc - 5.5, 1.25])
    cube([dlugosc + 12, wysokosc/2, szerokosc]);
translate([5, 0, 0]) translate([0, szerokosc - 5.5, 1.25])
    sphere(wysokosc/2,wysokosc/2,wysokosc/2, false);
}

