wymiarZewX = 120;
wymiarZewY = 19.5;
wymiarZewZ = 3.25;
gruboscScianki = 3.37;
wysokoscPizdryka = 3.25;
dlugoscPizdryka = 8;
offsetPidryka = dlugoscPizdryka + (2 * gruboscScianki);
offsetPidrykowy = 8.5;

//$fn=256;
$fn=16;

     
color ("red")translate([0, 0, -wymiarZewZ/2]) cube([wymiarZewX - gruboscScianki, wymiarZewY, wymiarZewZ], center=true);

for (i = [-wymiarZewX/2 : offsetPidryka : wymiarZewX/2 - offsetPidryka])
{
    color ("blue") translate([i + offsetPidrykowy, 0, +wymiarZewZ/2]) cube([dlugoscPizdryka, wymiarZewY, wymiarZewZ], center=true);
}
