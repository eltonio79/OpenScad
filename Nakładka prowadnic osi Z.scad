placekZewn = 13;
placekWys = 2;
tulejaZewn = 9.8;
tulejaWewn = 8.1;
tulejaWys = 10;


$fn=64;
//$fn=15;

     
translate([0,0,placekWys/2])
{
    cylinder(h=placekWys, r=placekZewn/2, center=true);
}

translate([0,0,tulejaWys/2])
{
    difference()
    {
        cylinder(h=tulejaWys, r=tulejaZewn/2, center=true);
        cylinder(h=tulejaWys, r=tulejaWewn/2, center=true);
    }
}
        
        
