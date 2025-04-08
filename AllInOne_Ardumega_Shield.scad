// użyte biblioteki
include <arduino/arduino.scad>

$fn=64;
//$fn=10;

// stałe
megaEnclosureDimensions = boardDimensions( MEGA2560_CLONE );
megaPCBDimensions = pcbDimensions( MEGA2560_CLONE );

// dystans między górą a dołem obudowy
printDistance = 50;

//logo on the lid (on / off)
useLogo = true;

// zmienne
enclosureWall = 2;
enclosureStand = 9;
enclosureStandType = TAPHOLE;//TAPHOLE;//PIN;
enclosureOffsetX = 16;
enclosureOffsetY = 7;
enclosureHeightExtension = 42;
enclosureCornerRadius = 3;
enclosureNumberOfDinMounts = 1; // 0 = min (default), 2 = max

//pomocnicze
distanceAllInOneShield = 16.4; // zmierzone
distanceEthernetShield = 17.5; // zmierzone
arduinoMegaOffset = enclosureWall + enclosureStand;
arduinoAllInOneShieldOffset = arduinoMegaOffset + distanceAllInOneShield;
arduinoEthernetShieldOffset = arduinoAllInOneShieldOffset + distanceEthernetShield;
boardLiftX = 0;
boardLiftY = -(enclosureOffsetY - 1); // 1mm from the inner left side of the box to pcb

// baza
difference()
{
    color([0,1,0,1]) translate([0, 0, 0])
    {
        enclosure(MEGA2560_CLONE, enclosureWall, enclosureOffsetX, enclosureOffsetY, boardLiftX, boardLiftY, enclosureHeightExtension, enclosureCornerRadius, enclosureStandType, enclosureStand, enclosureNumberOfDinMounts);
    }
    
    // bez otworów innych płytek (shieldów)
    union()
    {
        // mój shield po środku
        translate([boardLiftX, boardLiftY, arduinoAllInOneShieldOffset - 1]) //  minus 1.... wtf?
        {
            components(boardType = ALLINONE_SHIELD, offset = 1, extension = enclosureWall + 5);
        }
        // ethernet sield na górze
        translate([boardLiftX, boardLiftY, arduinoEthernetShieldOffset])
        {
            components(boardType = ETHERNET_SHIELD, offset = 1, extension = enclosureWall + 5);
        }
    }
}

/*

// arduino board  
color([0,0,1,0.8]) translate([boardLiftX, boardLiftY, arduinoMegaOffset])
{
	arduino(MEGA2560_CLONE);
}

// all in one eltonio shield  
color([0,0,1,0.8]) translate([boardLiftX, boardLiftY, arduinoAllInOneShieldOffset])
{
	arduino(ALLINONE_SHIELD);
}

// arduino board  
color([0,0,1,0.8]) translate([boardLiftX, boardLiftY, arduinoEthernetShieldOffset])
{
	arduino(ETHERNET_SHIELD);
}
*/

// pokrywa obudowy (odwrócona, przesunięta o printDistance od bazy)
color([1,0,0,0.5]) translate([megaEnclosureDimensions[0] + printDistance, 0, enclosureWall]) mirror ([0, 0, 1])
{
    // różnica
    difference()
    {
        // pokrywy (z logiem)
      enclosureLid(MEGA, enclosureWall, enclosureOffsetX, enclosureOffsetY, enclosureCornerRadius, "E.L.T. IB GATEWAY");
        // i otworów pod diody
        ledMounts(5.0);
    }
}

// moduł otworów pod diody ( z podpisami)
module ledMounts(size = 5.0)
{
    union()
    {
        ledMount(0, 90, size, "ERROR");
        ledMount(0, 80, size, "SEND");
        ledMount(0, 70, size, "RECEIVE");
        ledMount(0, 10, size, "POWER");
    }
}


// moduł diody z podpisem (grawerka)
module ledMount(x = 0, y = 0, hole = 5, desc = "")
{
    textDepth = 1; // wcięcie napisu w obudowę
    translate ([x, y, -2 * enclosureWall])
    {
        // otwór
        cylinder(d = hole, h = 4 * enclosureWall);
        // podpis
        rotate (180, 90, 90) translate ([-6, 0, (3 * enclosureWall) - textDepth]) podpis(desc, hole, 2 * enclosureWall);
    } 
}

// logo module
module podpis (text = "Napis", size = 10, height = 2)
{
    mirror([1, 0, 0]) 
        // convexity is needed for correct preview
        // since characters can be highly concave
        linear_extrude(height = height, convexity = 80)
            text(text, 
                size = size,
                font = "Consolas:style=Bold",
                halign = "left",
                valign = "center");
}
