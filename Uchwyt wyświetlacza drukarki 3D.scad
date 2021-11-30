difference()
{
    union()
    {
        difference()
        {
            cube(size = [100,10,3], center = false);
            union()
            {
                translate([80, 5, -5])
                    cylinder(h=20, r=2.25, center=true, $fn = 100);
                translate([60, 5, -5])
                    cylinder(h=20, r=2.25, center=true, $fn = 100);
            }
        }
        translate([0, 0, 0])
            rotate([0,45,0])
                difference()
                {
                    cube(size = [20,10,3], center = false);
                    translate([10, 5, -5])
                        cylinder(h=20, r=1.6, center=true, $fn = 100);
                }
    }
    translate([0, 0, 0])
        rotate([0,45,0])
            translate([10, 5, 15])
                cylinder(h=20, r=2.25, center=true, $fn = 100);
                
}