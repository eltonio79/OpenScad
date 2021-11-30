$fn=64;

srednica = 50;
gruboscScianki = 3;

module otoczka()
{
    difference() 
    {
        union()
        {
            minkowski()
            {
                cylinder(d=srednica,h=28.4, center=true);
                sphere(d=gruboscScianki);
            }
        }
        union()
        {
        cylinder(d=srednica - gruboscScianki,h=42, center=true);
        translate([0,0,-20])
            cylinder(d=srednica, h=20, center=true);
        }
    }
};

module smiglo()
{
    translate([0,0,2.75])
        cylinder (d=15,h=22, center=true);
    translate ([10,-10,3.0])
        rotate([0,80,45])
            cube([21.3,srednica / 2 - gruboscScianki / 2,2], center=true);
};


module wentylator()
{
    otoczka();
    
    for (i =[0:30:330])
     rotate([0,0,i])
        smiglo();
};

difference()
{
    wentylator();
    cylinder (d=8.1,h=44, center=true);
};

difference()
{
    translate([0,0,11.7])
        cylinder(d=srednica,h=8.15,center=true);
    translate([0,0,11.7])
        cylinder(d=35.5,h=8.5,center=true);
};

