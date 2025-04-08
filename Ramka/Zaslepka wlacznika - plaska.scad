//$fn=256;
$fn=50;

wymiarZewX = 54.5;
wymiarZewY = 54.5;
wymiarZewZ = 6.2;
wymiarWewX = 51.7;
wymiarWewY = 51.7;
gruboscScianki = 4;

boxMiniOuterX = 2.6;
boxMiniOuterY = 7.7;
boxMiniOuterZ = 2.0;
boxMiniInnerX = 1.4;
boxMiniInnerY = 4.9;
boxMiniInnerZ = 3.18;    

zaslepka();

module baza()
{
    translate([0,0,wymiarZewZ/2])
    {
        difference()
        {
            cube(size = [wymiarZewX,wymiarZewY,wymiarZewZ], center = true);

            translate([0,0,-1])
            {
                cube(size = [wymiarZewX - gruboscScianki,wymiarZewY - gruboscScianki,wymiarZewZ], center = true);
            }
        }
    }
    
    //bloczki zew
    translate([-wymiarZewX/2,-boxMiniOuterY/2,boxMiniOuterZ/2])
    {
        cube(size = [boxMiniOuterX, boxMiniOuterY,5.0], center = false);
    }
    translate([wymiarZewX/2 - boxMiniOuterX,-boxMiniOuterY/2,boxMiniOuterZ/2])
    {
        cube(size = [boxMiniOuterX, boxMiniOuterY,5.0], center = false);
    }
}

module zaslepka()
{
    difference()
    {
        baza();
        wyciecia();
    }
   
    haczyki();
    
    wypustki();
}

module haczyki()
{
    // haczyki
    gruboscPizdryka = 1.25;
    dlugoscPizdryka = 7.7;
    offsetPidryka = 4.6;

    translate([-wymiarZewX / 2 + 1, offsetPidryka, dlugoscPizdryka - (0.5 * gruboscScianki)])
      rotate([0, 180, 90]) haczyk(haczykWidth = gruboscPizdryka, haczykHeight = dlugoscPizdryka);
    translate([wymiarZewX / 2 - 1, -offsetPidryka, dlugoscPizdryka - (0.5 *  gruboscScianki)])
      rotate([0, 180, 270]) haczyk(haczykWidth = gruboscPizdryka, haczykHeight = dlugoscPizdryka);
    translate([-wymiarZewX / 2 + 1, -offsetPidryka, dlugoscPizdryka - (0.5 *  gruboscScianki)])
      rotate([0, 180, 90]) haczyk(haczykWidth = gruboscPizdryka, haczykHeight = dlugoscPizdryka);
    translate([wymiarZewX / 2 - 1, offsetPidryka, dlugoscPizdryka - (0.5 *  gruboscScianki)])
      rotate([0, 180, 270]) haczyk(haczykWidth = gruboscPizdryka, haczykHeight = dlugoscPizdryka);
}

module haczyk(haczykWidth = 5, haczykDepth = 5, haczykHeight = 5, lipDepth = 1.5, lipHeight = 2.4)
{
    // haczyk
    translate([-haczykWidth/2, -(haczykDepth-lipDepth), 0]) rotate([90, 0, 90])
    linear_extrude(height = haczykWidth, convexity = 10)
    polygon(points = [
                [0, 0], 
                [haczykDepth - lipDepth, 0],
                [haczykDepth - lipDepth, haczykHeight - lipHeight],
                [haczykDepth - 0.25, haczykHeight - lipHeight],
                [haczykDepth, haczykHeight - lipHeight + 0.25],
                [haczykDepth - lipDepth * 0.8, haczykHeight],
                [(haczykDepth - lipDepth) * 0.3, haczykHeight] 
            ], 
            paths=[[0,1,2,3,4,5,6]]
    );
}

module wypustki()
{
    // wypustki
    offsetWypustMini = 15.0;
    
    translate([-wymiarZewX / 2, offsetWypustMini, 0.6])
      rotate([0, 180, 90]) cube (size = [2.5, 0.8, 1.2], center = true);
    translate([-wymiarZewX / 2, -offsetWypustMini, 0.6])
      rotate([0, 180, 90]) cube (size = [2.5, 0.8, 1.2], center = true);
    translate([wymiarZewX / 2, offsetWypustMini, 0.6])
      rotate([0, 180, 90]) cube (size = [2.5, 0.8, 1.2], center = true);
    translate([wymiarZewX / 2, -offsetWypustMini, 0.6])
      rotate([0, 180, 90]) cube (size = [2.5, 0.8, 1.2], center = true);
    translate([-offsetWypustMini, -wymiarZewY / 2, 0.6])
      rotate([0, 180, 270]) cube (size = [0.8, 2.5, 1.2], center = true);
    translate([offsetWypustMini, -wymiarZewY / 2, 0.6])
      rotate([0, 180, 270]) cube (size = [0.8, 2.5, 1.2], center = true);
    translate([-offsetWypustMini, wymiarZewY / 2, 0.6])
      rotate([0, 180, 270]) cube (size = [0.8, 2.5, 1.2], center = true);
    translate([offsetWypustMini, wymiarZewY / 2, 0.6])
      rotate([0, 180, 270]) cube (size = [0.8, 2.5, 1.2], center = true);
}

module wyciecia()
{
    // wyciecia
    offsetWnekaMini = 20.8;
    wnekaSzerokoscDuza = 19.65;
    wnekaSzerokoscMala = 1.75;
    wnekaWysokoscA = 3.70; // wneka B (pod zaczep) x 2
    wnekaWysokoscB = 3.20; // wneka A x 2 
    wnekaWysokoscC = wnekaWysokoscB; // mini wneka x 8

    // wycinki szerokie
    translate([0,0,wnekaWysokoscA/2])
    {
       cube(size = [wymiarZewX + 10, wnekaSzerokoscDuza, wnekaWysokoscA], center = true);
    }
    translate([0,0,wnekaWysokoscB/2])
    {
        cube(size = [wnekaSzerokoscDuza, wymiarZewY + 10, wnekaWysokoscB], center = true);
    }
    
    // wycinki wąskie
    translate([0,-offsetWnekaMini,wnekaWysokoscC/2])
    {
       cube(size = [wymiarZewX + 10, wnekaSzerokoscMala, wnekaWysokoscC], center = true);
    }
    translate([0,offsetWnekaMini,wnekaWysokoscC/2])
    {
       cube(size = [wymiarZewX + 10, wnekaSzerokoscMala, wnekaWysokoscC], center = true);
    }
    translate([-offsetWnekaMini,0,wnekaWysokoscC/2])
    {
       cube(size = [wnekaSzerokoscMala, wymiarZewY + 10, wnekaWysokoscC], center = true);
    }
    translate([offsetWnekaMini,0,wnekaWysokoscC/2])
    {
       cube(size = [wnekaSzerokoscMala, wymiarZewY + 10, wnekaWysokoscC], center = true);
    }
    
    // bloczki wew
    translate([-wymiarZewX/2,-boxMiniInnerY/2,boxMiniOuterZ])
    {
        cube(size = [boxMiniInnerX, boxMiniInnerY,boxMiniInnerZ], center = false);
    }
    translate([wymiarZewX/2 - boxMiniInnerX, -boxMiniInnerY/2,boxMiniOuterZ])
    {
        cube(size = [boxMiniInnerX, boxMiniInnerY,boxMiniInnerZ], center = false);
    }

}