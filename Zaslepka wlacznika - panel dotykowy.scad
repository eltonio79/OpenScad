wymiarZewX = 54.5;
wymiarZewY = 54.5;
wymiarZewZ = 9.5; // czubek kuli
wymiarPomZ = 6.2; // "kant" kuli
wymiarWewX = 51.7;
wymiarWewY = 51.7;
gruboscScianki = 2.4;
gruboscPizdryka = 1.25;
dlugoscPizdryka = 7.7;
offsetPidryka = 4.6;
sphereRadius = 475;

//$fn=256;
$fn=50;

     

zaslepka();

module roundedPanel()
{
    difference()
    {
        spherePosZ = -sphereRadius + wymiarZewZ - wymiarPomZ;
        
        intersection()
        {
            translate([0,0,spherePosZ])
            {
                sphere(r = sphereRadius);
            }
            cube(size = [wymiarZewX,wymiarZewY,wymiarZewZ], center = true);
        }

        intersection()
        {
            translate([0,0,spherePosZ - gruboscScianki])
            {
                sphere(r = sphereRadius);
            }
            translate([0,0,-gruboscScianki])
            {
                cube(size = [wymiarZewX - gruboscScianki,wymiarZewY - gruboscScianki,wymiarZewZ], center = true);
            }
        }
    }
}

module zaslepka()
{
    wnekaSzerokoscDuza = 19.65;
    wnekaSzerokoscMala = 1.75;
    wnekaWysokoscA = 3.70; // wneka B (pod zaczep) x 2
    wnekaWysokoscB = 3.20; // wneka A x 2 
    wnekaWysokoscC = wnekaWysokoscB; // mini wneka x 8
    
    boxMiniOuterX = 2.6;
    boxMiniOuterY = 7.7;
    boxMiniOuterZ = 4.0;
    boxMiniInnerX = 1.4;
    boxMiniInnerY = 4.9;
    boxMiniInnerZ = 3.18;
    
    offsetWnekaMini = 20.8;
    offsetWypustMini = 15.0;
    
    union()
    {
        difference()
        {
            difference()
            {
                union ()
                {
                    //baza
                    translate([0,0,wymiarZewZ/2])
                    {
                        roundedPanel();
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
                union()
                {
                    // bloczki wew
                    translate([-wymiarZewX/2,-boxMiniInnerY/2,boxMiniOuterZ - 1])
                    {
                        cube(size = [boxMiniInnerX, boxMiniInnerY,boxMiniInnerZ], center = false);
                    }
                    translate([wymiarZewX/2 - boxMiniInnerX, -boxMiniInnerY/2,boxMiniOuterZ - 1])
                    {
                        cube(size = [boxMiniInnerX, boxMiniInnerY,boxMiniInnerZ], center = false);
                    }
                }
            }
            union ()
            {
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
            }
        }
       /*
          //Lid clips
          translate([-wymiarZewX / 2 + (1.5 * gruboscScianki), offsetPidryka, dlugoscPizdryka - (0.5 * gruboscScianki)])
              rotate([0, 180, 90]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);
          translate([wymiarZewX / 2 - (1.5 * gruboscScianki), -offsetPidryka, dlugoscPizdryka - (0.5 *  gruboscScianki)])
              rotate([0, 180, 270]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);
          translate([-wymiarZewX / 2 + (1.5 * gruboscScianki), -offsetPidryka, dlugoscPizdryka - (0.5 *  gruboscScianki)])
              rotate([0, 180, 90]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);
          translate([wymiarZewX / 2 - (1.5 * gruboscScianki), offsetPidryka, dlugoscPizdryka - (0.5 *  gruboscScianki)])
              rotate([0, 180, 270]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);*/
        
        // mikro pizdryki
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
}


//Create a clip that snapps into a clipHole
module clip(clipWidth = 5, clipDepth = 5, clipHeight = 5, lipDepth = 1.5, lipHeight = 2.4)
{
  translate([-clipWidth/2, -(clipDepth-lipDepth), 0]) rotate([90, 0, 90])
  linear_extrude(height = clipWidth, convexity = 10)
    polygon(  points=[  [0, 0], 
            [clipDepth - lipDepth, 0],
            [clipDepth - lipDepth, clipHeight - lipHeight],
            [clipDepth - 0.25, clipHeight - lipHeight],
            [clipDepth, clipHeight - lipHeight + 0.25],
            [clipDepth - lipDepth * 0.8, clipHeight],
            [(clipDepth - lipDepth) * 0.3, clipHeight] 
            ], 
        paths=[[0,1,2,3,4,5,6,7]]
      );
}

