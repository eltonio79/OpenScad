// Libraries
include <arduino/arduino.scad>

/////////////////////////////////////////
////////// Box parameters ///////////////
/////////////////////////////////////////

/* [Box dimensions] */
// Length
Length                     = 152;
// Width
Width                      = 113;
// Height
Height                     = 60;
// Wall thickness
Thick                      = 2; // [2:5]

/* [Box options] */
// Filet diameter
Filet                      = 2; // [0.1:12]
// Filet smoothness
Resolution                 = 50; // [1:100]
// Tolerance (Panel/rails gap)
GapRailsToPanelTolerance   = 0.9;

/* [Arduino Mega Clone PCB] */
// All dimensions are from the center foot axis

// X position of the PCB board
PCBPosX                    = 6.1;
// Y position of the PCB board
PCBPosY                    = 61;
// Rotation of the PCB board
PCBRotZ                    = -90;

// Foot height
PCBFootHeight              = 10;
// Foot top radius
PCBFootTopRadius           = 3.2;
// Foot bottom radius
PCBFootBottomRadius        = 5.5;
// Foot hole radius
FootHoleRadius             = 2.1;

/* [STL element to export] */
// Top shell
TShell                     = 0; // [0:No, 1:Yes]
// Bottom shell
BShell                     = 1; // [0:No, 1:Yes]
// Front panel
FPanL                      = 1; // [0:No, 1:Yes]
// Back panel
BPanL                      = 1; // [0:No, 1:Yes]
// PCB board
PCBBoard                   = 1; // [0:No, 1:Yes]
// PCB stands
PCBStands                  = 1; // [0:No, 1:Yes]
// Decorations to ventilation holes
Ventilation                = 1; // [0:No, 1:Yes]
// Decoration-Holes width (in mm)
Ventilation_Width          = 1.5;

/* [Hidden] */
// Bottom Shell color
ColorBottom                = "Yellow";
// Top Shell color
ColorTop                   = "DarkRed";
// Panels color
ColorPanels                = "DeepSkyBlue";
// Top Panel sculpture color
ColorTopSculpture          = "White";

// Thick * 2 - making decorations thicker if it is a vent to make sure they go through shell
Decoration_Thick           = Ventilation ? Thick * 2 : Thick;
// Depth decoration
Decoration_Size            = Ventilation ? Thick * 2 : 0.8;

/////////////////////////////////////////
////////// Modules / classes ////////////
/////////////////////////////////////////

// Generic rounded box
module RoundBox($a = Length, $b = Width, $c = Height) {
    $fn = Resolution;
    translate([0, Filet, Filet]) {
        minkowski () {
            cube ([$a - (Length / 2), $b - (2 * Filet), $c - (2 * Filet)], center = false);
            rotate([0, 90, 0]) {
                cylinder(r = Filet, h = Length / 2, center = false);
            }
        }
    }
}

// Top shell
module Shell() {
    Thick = Thick * 2;
    difference() {
        difference() { // sides decoration
            union() { // inbox sides decoration
                difference() { // Substraction Fileted box
                    difference() { // Median cube slicer
                        union() { // Union of Shell and Rails
                            difference() { // Shell
                                RoundBox();
                                translate([Thick / 2, Thick / 2, Thick / 2]) {
                                    RoundBox($a = Length - Thick, $b = Width - Thick, $c = Height - Thick);
                                }
                            }
                            difference() { // Rails
                                translate([Thick + GapRailsToPanelTolerance, Thick / 2, Thick / 2]) {
                                    RoundBox($a = Length - ((2 * Thick) + (2 * GapRailsToPanelTolerance)), $b = Width - Thick, $c = Height - (Thick * 2));
                                }
                                translate([((Thick + GapRailsToPanelTolerance / 2) * 1.55), Thick / 2, Thick / 2 + 0.1]) { // +0.1 added to avoid the artefact
                                    RoundBox($a = Length - ((Thick * 3) + 2 * GapRailsToPanelTolerance), $b = Width - Thick, $c = Height - Thick);
                                }
                            }
                        }
                        translate([-Thick, -Thick, Height / 2]) { // Cube
                            cube([Length + 100, Width + 100, Height], center = false);
                        }
                    }
                    translate([-Thick / 2, Thick, Thick]) {
                        RoundBox($a = Length + Thick, $b = Width - Thick * 2, $c = Height - Thick);
                    }
                }
                difference() { // wall fixation box legs
                    union() {
                        translate([3 * Thick + 5, Thick, Height / 2]) {
                            rotate([90, 0, 0]) {
                                $fn = 6;
                                cylinder(d = 16, Thick / 2);
                            }
                        }
                        translate([Length - ((3 * Thick) + 5), Thick, Height / 2]) {
                            rotate([90, 0, 0]) {
                                $fn = 6;
                                cylinder(d = 16, Thick / 2);
                            }
                        }
                    }
                    translate([4, Thick + Filet, Height / 2 - 57]) {
                        rotate([45, 0, 0]) {
                            cube([Length, 40, 40]);
                        }
                    }
                    translate([0, -(Thick * 1.46), Height / 2]) {
                        cube([Length, Thick * 2, 10]);
                    }
                }
            }
            union() { // outbox sides decorations
                for(i = [0 : Thick : Length / 4]) {
                    // Ventilation holes
                    translate([10 + i, -Decoration_Thick + Decoration_Size, 1]) {
                        cube([Ventilation_Width, Decoration_Thick, Height / 4]);
                    }
                    translate([(Length - 10) - i, -Decoration_Thick + Decoration_Size, 1]) {
                        cube([Ventilation_Width, Decoration_Thick, Height / 4]);
                    }
                    translate([(Length - 10) - i, Width - Decoration_Size, 1]) {
                        cube([Ventilation_Width, Decoration_Thick, Height / 4]);
                    }
                    translate([10 + i, Width - Decoration_Size, 1]) {
                        cube([Ventilation_Width, Decoration_Thick, Height / 4]);
                    }
                }
            }
        }

        union() { // sides holes
            $fn = 50;
            translate([3 * Thick + 5, 20, Height / 2 + 4]) {
                rotate([90, 0, 0]) {
                    cylinder(d = 2, 20);
                }
            }
            translate([Length - ((3 * Thick) + 5), 20, Height / 2 + 4]) {
                rotate([90, 0, 0]) {
                    cylinder(d = 2, 20);
                }
            }
            translate([3 * Thick + 5, Width + 5, Height / 2 - 4]) {
                rotate([90, 0, 0]) {
                    cylinder(d = 2, 20);
                }
            }
            translate([Length - ((3 * Thick) + 5), Width + 5, Height / 2 - 4]) {
                rotate([90, 0, 0]) {
                    cylinder(d = 2, 20);
                }
            }
        }
    }
}

// Panel
module Panel(Length, Width, Thick, Filet) {
    scale([0.5, 1, 1]) {
        minkowski() {
            cube([Thick, Width - (Thick * 2 + Filet * 2 + GapRailsToPanelTolerance), Height - (Thick * 2 + Filet * 2 + GapRailsToPanelTolerance)]);
            translate([0, Filet, Filet]) {
                rotate([0, 90, 0]) {
                    cylinder(r = Filet, h = Thick, $fn = 100);
                }
            }
        }
    }
}

// Circle hole
// Cx=Cylinder X position | Cy=Cylinder Y position | Cdia= Cylinder dia | Cheight=Cyl height
module CylinderHole(OnOff, Cx, Cy, Cdia) {
    if(OnOff == 1) {
        translate([Cx, Cy, -1]) {
            cylinder(d = Cdia, 10, $fn = 50);
        }
    }
}

// Square hole
// Sx=Square X position | Sy=Square Y position | Sl= Square Length | Sw=Square Width | Filet = Round corner
module SquareHole(OnOff, Sx, Sy, Sl, Sw, Filet) {
    if(OnOff == 1) {
        minkowski() {
            translate([Sx + Filet / 2, Sy + Filet / 2, -1]) {
                cube([Sl - Filet, Sw - Filet, 10]);
            }
            cylinder(d = Filet, h = 10, $fn = 100);
        }
    }
}

// Linear text panel
module TextLinear(OnOff, Tx, Ty, Font, Size, Content) {
    if(OnOff == 1) {
        translate([Tx, Ty, Thick + .5]) {
            linear_extrude(height = 0.5) {
                text(Content, size = Size, font = Font);
            }
        }
    }
}

// Circular text panel
module TextCircular(OnOff, Tx, Ty, Font, Size, TxtRadius, Angl, Turn, Content) {
    if(OnOff == 1) {
        Angle = -Angl / len(Content);
        translate([Tx, Ty ,Thick + .5]) {
            for (i= [0 : len(Content) - 1]) {
                rotate([0, 0, i * Angle + 90 + Turn]) {
                    translate([0, TxtRadius, 0]) {
                        linear_extrude(height = 0.5) {
                            text(Content[i], font = Font, size = Size,  valign = "baseline", halign = "center");
                        }
                    }
                }
            }
        }
    }
}

// New Panel
module FPanL() {
    color(ColorPanels) {
        Panel(Length, Width, Thick, Filet);
    }
}

// PCB placement module
module PlacePCB(_PCBPosX = 0,_PCBPosY = 0,_PCBPosZ = 0,
                _PCBRotX = 0,_PCBRotY = 0,_PCBRotZ = 0) {
    translate([PCBPosX, PCBPosY, _PCBPosZ]) {
        rotate([_PCBRotX, _PCBRotY, _PCBRotZ]) {
            children();
        }
    }
}

// Arduino Mega Clone Placement module
module PlacePCB_ArduinoMegaClone() {
    PlacePCB(_PCBPosX = PCBPosX,
             _PCBPosY = PCBPosY,
             _PCBPosZ = PCBFootHeight + 0.5,
             _PCBRotZ = PCBRotZ) {
        children();
    }
}

// Top panel interface holes
module TopPanelHoles(_PanelPosX = 0, _PanelPosY = 0) {
    translate([_PanelPosX, _PanelPosY, Height - Thick]) {
        // Cutting shapes from here
        SquareHole  (1, 20,  20, 15, 10, 1); // (On/Off, Xpos,Ypos,Length,Width,Filet)
        SquareHole  (1, 40,  20, 15, 10, 1);
        SquareHole  (1, 60,  20, 15, 10, 1);
        CylinderHole(1, 27,  40, 8); // (On/Off, Xpos, Ypos, Diameter)
        CylinderHole(1, 47,  40, 8);
        CylinderHole(1, 67,  40, 8);
        SquareHole  (1, 20,  50, 80, 30, 3);
        CylinderHole(1, 98,  25, 10);
        SquareHole  (1, 120, 20, 30, 60, 3);
        // To here
    }
}

// Top panel interface sculptures (e.g. UI legend)
module TopPanelSculpture(_PanelPosX = 0, _PanelPosY = 0) {
    translate([_PanelPosX, _PanelPosY, Height - Thick]) {
        translate ([-0.5, 0, 0]) {
            // Adding text from here
            TextLinear  (1, 20,  83, "Arial Black", 8, "Digital Screen"); // (On/Off, Xpos, Ypos, "Font", Size, "Text")
            TextLinear  (1, 120, 83, "Arial Black", 8, "Level");
            TextLinear  (1, 20,  11, "Arial Black", 6, "  1     2      3");
            TextCircular(1, 98,  25, "Arial Black", 4, 15, 353, 20, "1 . 2 . 3 . 4 . 5 . 6 . 7 . 8 . 9 . 0 ."); // (On/Off, Xpos, Ypos, "Font", Size, Diameter, Arc(Deg), Starting Angle(Deg),"Text")
            // To here
        }
    }
}

/////////////////////////////////////////
//////////// PROGRAM BEGIN //////////////
/////////////////////////////////////////

// Top Shell
if (TShell == 1) {
    union () {
        difference() {
            color(ColorTop, 1) {
                translate([0, Width, Height + 0.2]) {
                    rotate([0, 180, 180]) {
                        Shell();
                    }
                }
            }
            // Top Panel Holes
            TopPanelHoles(-9, 5);
        }
        // Top Panel
        color(ColorTopSculpture) {
            TopPanelSculpture(-9, 5);
        }
    }
}

// Bottom shell
if (BShell == 1) {
    color(ColorBottom) {
        Shell();
    }
}

// Front panel
//rotate([0,-90,-90])
if (FPanL == 1) {
    translate([Length - (Thick * 2 + GapRailsToPanelTolerance / 2), Thick + GapRailsToPanelTolerance / 2, Thick + GapRailsToPanelTolerance / 2]) {
        FPanL();
    }
}

// Back panel
if (BPanL == 1) {
    color(ColorPanels) {
        difference() {
            translate([Thick + GapRailsToPanelTolerance / 2, Thick + GapRailsToPanelTolerance / 2, Thick + GapRailsToPanelTolerance / 2]) {
                Panel(Length, Width, Thick, Filet);
            }
            // PCB Component Holes
            PlacePCB_ArduinoMegaClone() {
                components(boardType = MEGA2560_CLONE, component = ALL, extension = 0, offset = 1);
            }
        }
    }
}

// PCB Board
if (PCBBoard == 1) {
    PlacePCB_ArduinoMegaClone() {
        // PCB Board
        arduino(MEGA2560_CLONE);
    }
}

// PCB Stands
if (PCBStands == 1) {
    PlacePCB_ArduinoMegaClone() {
        // PCB Stands
        translate([0, 0, -PCBFootHeight])
            standoffs(MEGA2560_CLONE, PCBFootHeight, PCBFootTopRadius, PCBFootBottomRadius,FootHoleRadius);
    }
}

// TODO
//assert(!"<h1>Heading</h1>");
//echo("<b>Bold</b> <i>italic</i> <big>big</big>");
//echo("<font color='red'><b>red</b></font> <font color='green'><b>green</b></font> <font color='blue'><b><u>blue underlined</u></b></font>");

/////////////////////////////////////////
///////////// PROGRAM END ///////////////
/////////////////////////////////////////