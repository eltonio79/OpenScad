wymiarZewX = 54.5;
wymiarZewY = 54.5;
wymiarZewZ = 9.5; // czubek kuli
wymiarPomZ = 6.2; // "kant" kuli
wymiarWewX = 51.7;
wymiarWewY = 51.7;
gruboscScianki = 2.5;
gruboscPizdryka = 1.5;
dlugoscPizdryka = 6.5;
offsetPidryka = 6.0;
sphereRadius = 475;

//$fn=256;
//$fn=128;
$fn=128;

     

zaslepka();

module roundedPanel()
{
    PromienKuli = 22;
    GruboscSciankiKuli = 0.15;

    difference()
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
    
        union() {
            translate([0,0,0])
            {
                sphere(r = PromienKuli - GruboscSciankiKuli);
            }
            rotate([0,0,0])
                logo("♥ Kocham Cię ♥", 2);
            rotate([0,0,180])
                logo("♥ Bursztynku ♥ ", 2);
        }
    }

    difference() { // logo wryte w kulę
        RozmiarTopLogo = 15;
        GruboscTopLogo = 10;
        // kula
        difference() { // odcięcie polowy kuli
            difference() { // kula
                sphere(r = PromienKuli);
                sphere(r = PromienKuli - GruboscSciankiKuli);
            }

            translate([0,0,-PromienKuli - (wymiarZewZ - wymiarPomZ) + 5]) { // część odcięta kuli
                cube(size = 2 * PromienKuli, center = true);
            }
        }
        
        /*
        // logo's
        translate([0, 0, PromienKuli - (GruboscTopLogo / 2)]) { // logo
            wzorLogo("\u267B", GruboscTopLogo, RozmiarTopLogo - 3);
        }
        
        LogoObrot("\u263A", 35, PromienKuli, GruboscTopLogo, RozmiarTopLogo);
        
        rotate([0, 0, 45]) {
            LogoObrot("\u263A", 55, PromienKuli, GruboscTopLogo, RozmiarTopLogo);
        }

        LogoObrot("\u266A", 67, PromienKuli, GruboscTopLogo, RozmiarTopLogo);

        rotate([0, 0, 45]) {
            LogoObrot("♥", 77, PromienKuli, GruboscTopLogo, 5);
        }
        */
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
       
          // Klipsy
          wypustKlipsa = 0.5;
        
          translate([-wymiarZewX / 2 + 2, offsetPidryka, dlugoscPizdryka - (wypustKlipsa * gruboscScianki)])
              rotate([0, 180, 90]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);
          translate([wymiarZewX / 2 - 2, -offsetPidryka, dlugoscPizdryka - (wypustKlipsa *  gruboscScianki)])
              rotate([0, 180, 270]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);
          translate([-wymiarZewX / 2 + 2, -offsetPidryka, dlugoscPizdryka - (wypustKlipsa *  gruboscScianki)])
              rotate([0, 180, 90]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);
          translate([wymiarZewX / 2 - 2, offsetPidryka, dlugoscPizdryka - (wypustKlipsa *  gruboscScianki)])
              rotate([0, 180, 270]) clip(clipWidth = gruboscPizdryka, clipHeight = dlugoscPizdryka);
        
        // mikro pizdryki
        xWypustMini = 2.5;
        yWypustMini = 1.25;
        zWypustMini = 0.6;
          translate([-wymiarZewX / 2, offsetWypustMini, zWypustMini])
              rotate([0, 180, 90]) cube (size = [xWypustMini, yWypustMini, zWypustMini * 2], center = true);
          translate([-wymiarZewX / 2, -offsetWypustMini, zWypustMini])
              rotate([0, 180, 90]) cube (size = [xWypustMini, yWypustMini, zWypustMini * 2], center = true);
          translate([wymiarZewX / 2, offsetWypustMini, zWypustMini])
              rotate([0, 180, 90]) cube (size = [xWypustMini, yWypustMini, zWypustMini * 2], center = true);
          translate([wymiarZewX / 2, -offsetWypustMini, zWypustMini])
              rotate([0, 180, 90]) cube (size = [xWypustMini, yWypustMini, zWypustMini * 2], center = true);
          translate([-offsetWypustMini, -wymiarZewY / 2, zWypustMini])
              rotate([0, 180, 270]) cube (size = [yWypustMini, xWypustMini, zWypustMini * 2], center = true);
          translate([offsetWypustMini, -wymiarZewY / 2, zWypustMini])
              rotate([0, 180, 270]) cube (size = [yWypustMini, xWypustMini, zWypustMini * 2], center = true);
          translate([-offsetWypustMini, wymiarZewY / 2, zWypustMini])
              rotate([0, 180, 270]) cube (size = [yWypustMini, xWypustMini, zWypustMini * 2], center = true);
          translate([offsetWypustMini, wymiarZewY / 2, zWypustMini])
              rotate([0, 180, 270]) cube (size = [yWypustMini, xWypustMini, zWypustMini * 2], center = true);
    }
}


//Create a clip that snapps into a clipHole
module clip(clipWidth = 5, clipDepth = 5, clipHeight = 5, lipDepth = 1.5, lipHeight = 2.4)
{
      translate([-clipWidth/2, -(clipDepth-lipDepth), 0]) rotate([90, 0, 90])
      {
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
      translate([-clipWidth/2 + lipHeight/2, -(clipDepth-lipDepth) + lipDepth + 0.5, 0]) rotate([0, 0, 90])
      {
          cylinder(r1 = clipWidth / 2 + 1.9, r2 = clipWidth / 2 + 1, h = 2.5);
          translate([0, 0, 2.5])
              cylinder(r1 = clipWidth / 2 + 1, r2 = 0, h = 2.5);
      }
}

module logo (_text, _size)
{
    #mirror([1,0,0]) {
        translate([0,-24.4,0.5])
        {
            // convexity is needed for correct preview
            // since characters can be highly concave
            linear_extrude(height=1, convexity=50)
                text(_text, 
                    size=_size,
                    font="Bitstream Vera Sans:style=Bold",
                    halign="center",
                    valign="center");
        }
    }
}

module topLogo (_text, _height, _fontSize)
{
    linear_extrude(height = _height) {
        text(_text,
            size=_fontSize,
            font="Liberation Sans",
            halign="center",
            valign="center",
            $fn = 16);
    }
}

module wzorLogo (_Text, _GruboscTopLogo, _RozmiarTopLogo)
{
    difference() {
        topLogo(_Text, _GruboscTopLogo, _RozmiarTopLogo);
        
        a = 3;
        b = 1.5;
        c = 8;
        d = 6.5;
        union() {
            translate([d, 0, 2]) {
                cube([a,b,c], center = true);
            }
            translate([-d, 0, 2]) {
                cube([a,b,c], center = true);
            }
            translate([0, d, 2]) {
                cube([b,a,c], center = true);
            }
            translate([0, -d, 2]) {
                cube([b,a,c], center = true);
            }
        }
    }
}

module LogoObrot(_Text, _KatNachylenia, _PromienKuli, _GruboscTopLogo, _RozmiarTopLogo) {
    rotate([0, _KatNachylenia, 0]) {
        translate([0, 0, _PromienKuli - (_GruboscTopLogo / 2)]) { // logo
            wzorLogo(_Text, _GruboscTopLogo, _RozmiarTopLogo);
        }
    }

    rotate([_KatNachylenia, 0, 0]) {
        translate([0, 0, _PromienKuli - (_GruboscTopLogo / 2)]) { // logo
            wzorLogo(_Text, _GruboscTopLogo, _RozmiarTopLogo);
        }
    }
    rotate([0, -_KatNachylenia, 0]) {
        translate([0, 0, _PromienKuli - (_GruboscTopLogo / 2)]) { // logo
            wzorLogo(_Text, _GruboscTopLogo, _RozmiarTopLogo);
        }
    }
    rotate([-_KatNachylenia, 0, 0]) {
        translate([0, 0, _PromienKuli - (_GruboscTopLogo / 2)]) { // logo
            wzorLogo(_Text, _GruboscTopLogo, _RozmiarTopLogo);
        }
    }
}