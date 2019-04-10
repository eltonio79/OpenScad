// Arduino connectors library
//
// Copyright (c) 2013 Kelly Egan
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
// and associated documentation files (the "Software"), to deal in the Software without restriction, 
// including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do 
// so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
// NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

use <../Pins/pins.scad>

//Constructs a roughed out arduino board
//Current only USB, power and headers
module arduino(boardType = UNO)
{
  //The PCB with holes
  difference()
  {
    color("SteelBlue") 
      boardShape( boardType );
    translate([0,0,-pcbHeight * 0.5]) holePlacement(boardType = boardType)
      color("SteelBlue") cylinder(r = mountingHoleRadius, h = pcbHeight * 2, $fn=32);
  }
  
  //Add all components to board
  components( boardType = boardType, component = ALL );
}

//Creates a bumper style enclosure that fits tightly around the edge of the PCB.
module bumper( boardType = UNO, mountingHoles = false )
{
  bumperBaseHeight = 2;
  bumperHeight = bumperBaseHeight + pcbHeight + 0.5;
  dimensions = boardDimensions(boardType);

  difference()
  {
    union()
    {
      //Outer rim of bumper
      difference()
      {
        boardShape(boardType = boardType, offset = 1.4, height = bumperHeight);
        translate([0, 0, -0.1])
          boardShape(boardType = boardType, height = bumperHeight + 0.2);
      }

      //Base of bumper
      difference()
      {
        boardShape(boardType = boardType, offset = 1, height = bumperBaseHeight);
        translate([0, 0, -0.1])
          boardShape(boardType = boardType, offset = -2, height = bumperHeight + 0.2);
      }

      //Board mounting holes
      holePlacement(boardType=boardType)
        cylinder(r = mountingHoleRadius + 1.5, h = bumperBaseHeight, $fn = 32);

      //Bumper mounting holes (exterior)
      if( mountingHoles )
      {
        difference()
        {  
          hull()
          {
            translate([-6, (dimensions[1] - 6) / 2, 0])
              cylinder( r = 6, h = pcbHeight + 2, $fn = 32 );
            translate([ -0.5, dimensions[0] / 2 - 9, 0]) 
              cube([0.5, 12, bumperHeight]);
          }
          translate([-6, (dimensions[0] - 6) / 2, 0])
            mountingHole(holeDepth = bumperHeight);
        }
        difference()
        {  
          hull()
          {
            translate([dimensions[0] + 6, (dimensions[1] - 6) / 2,0])
              cylinder( r = 6, h = pcbHeight + 2, $fn = 32 );
            translate([ dimensions[0], dimensions[1] / 2 - 9, 0]) 
              cube([0.5, 12, bumperHeight]);
          }
          translate([dimensions[0] + 6, (dimensions[1] - 6) / 2,0])
            mountingHole(holeDepth = bumperHeight);
        }
      }
    }
    translate([0, 0, -0.5])
    holePlacement(boardType=boardType)
      cylinder(r = mountingHoleRadius, h = bumperHeight, $fn = 32);  
    translate([0, 0, bumperBaseHeight]) {
      components(boardType = boardType, component = ALL, offset = 1);
    }
    translate([4, (dimensions[1] - dimensions[1] * 0.4)/2, -1])
      cube([dimensions[0] -8, dimensions[1] * 0.4, bumperBaseHeight + 2]);
  }
}

//Setting for enclosure mounting holes (Not Arduino mounting)
NOMOUNTINGHOLES = 0;
INTERIORMOUNTINGHOLES = 1;
EXTERIORMOUNTINGHOLES = 2;

// moje modu³y BEGIN

//DIN rail mount module
module dinMount (height = 6.0, width = 4.1)
{
    #difference()
    {
        cylinder(r1 = 8, r2 = 6, h = height);
        union()
        {
            cylinder(d = width, h = height);
            translate([0, 0, height - 5]) cylinder(h = height - 1, r1 = 0, r2 = 3.5, center = false);
        };
    }
}

// logo module
module logo (logoText = "Eltonio Gateway", logoSize = 10, logoHeight = 2)
{
    mirror([1, 0, 0]) 
        // convexity is needed for correct preview
        // since characters can be highly concave
        linear_extrude(height = logoHeight, convexity = 80)
            text(logoText, 
                size = logoSize,
                font = "Consolas:style=Bold",
                halign = "center",
                valign = "center");
}

// moje modu³y END

//Create a board enclosure
module enclosure(boardType = UNO, wall = 3, offsetX = 3, offsetY = 3, liftX = 0, liftY = 0, heightExtension = 10, cornerRadius = 3, mountType = TAPHOLE, standOffHeight = 5, dinMountCount = 0)
{
  //zmienne
  dimensions = boardDimensions(boardType);
  boardDim = boardDimensions(boardType);
  pcbDim = pcbDimensions(boardType);

  enclosureWidth = pcbDim[0] + (wall + offsetX) * 2;
  enclosureDepth = pcbDim[1] + (wall + offsetY) * 2;
  enclosureHeight = boardDim[2] + wall + standOffHeight + heightExtension;

  //Suma:
  union()
  {
    // Surowa obudowa
    difference()
    {
      //Main box shape
      boundingBox(boardType = boardType, height = enclosureHeight, offsetX = wall + offsetX, offsetY = wall + offsetY, include=PCB, cornerRadius = wall);
  	  union()
      {
        translate([ 0, 0, wall])
        {
          //Interior of box
          boundingBox(boardType = boardType, height = enclosureHeight, offsetX = offsetX, offsetY = offsetY, include=PCB, cornerRadius = wall);
  
          //Punch outs for USB and POWER
          translate([liftX, liftY, standOffHeight])
          {
            components(boardType = boardType, offset = 1, extension = wall + offsetY + 10); // 1mm around the strict component size
          }
        
          //Hole(s) in the box for din rail mount(s)
          if (dinMountCount == 1)
          {
            translate([enclosureWidth * 0.5 - (offsetX + wall), enclosureDepth * 0.5 - (offsetY + wall), -wall])
            {
              cylinder(d = 4, h = wall);
            }
          }
          else if (dinMountCount == 2)
          {
            translate([enclosureWidth * 0.5 - (offsetX + wall), enclosureDepth * 0.25 - (offsetY + wall), -wall])
            {
              cylinder(d = 4, h = wall);
            }
            translate([enclosureWidth * 0.5 - (offsetX + wall), enclosureDepth * 0.75 - (offsetY + wall), -wall])
            {
              cylinder(d = 4, h = wall);
            }
          }
        }
      }
      
      //Dziury na zaczepy pokrywy
      translate([0, enclosureDepth * 0.75 - (offsetY + wall), enclosureHeight])
      {
        translate([-offsetX, 0, 0])
          rotate([0, 180, 90]) clipHole(clipHeight = 10, holeDepth = wall + 0.2);
        translate([offsetX + boardDim[0], 0, 0])
          rotate([0, 180, 270]) clipHole(clipHeight = 10, holeDepth = wall + 0.2);
      }
    
      translate([0, enclosureDepth * 0.25 - (offsetY + wall), enclosureHeight])
      {
        translate([-offsetX, 0, 0])
          rotate([0, 180, 90]) clipHole(clipHeight = 10, holeDepth = wall + 0.2);
        translate([offsetX + dimensions[0], 0, 0])
          rotate([0, 180, 270]) clipHole(clipHeight = 10, holeDepth = wall + 0.2);
      }   
    }
    
    //Dystanse do zamocowania Arduino
    translate([0 + liftX, 0 + liftY, wall])
    {
      standoffs(boardType = boardType, height = standOffHeight, mountType = mountType);
    }
    
    //Mocowanie œrub dla zaczepów do szyny DIN (0/1/2). Domyœlnie brak (dinMountCount = 0);
    if (dinMountCount == 1)
    {        
      translate([enclosureWidth * 0.5 - (offsetX + wall), enclosureDepth * 0.5 - (offsetY + wall), wall])
      {
        dinMount();
      }
    }
    else if (dinMountCount == 2)
    {
      translate([enclosureWidth * 0.5 - (offsetX + wall), enclosureDepth * 0.25 - (offsetY + wall), wall])
      {
        dinMount();
      }
      translate([enclosureWidth * 0.5 - (offsetX + wall), enclosureDepth * 0.75 - (offsetY + wall), wall])
      {
        dinMount();
      }
    }
  }
}

//Create a snap on lid for enclosure
module enclosureLid( boardType = UNO, wall = 3, offsetX = 3, offsetY = 3, cornerRadius = 3, logo = "")
{
  //zmienne
  dimensions = boardDimensions(boardType);
  boardDim = boardDimensions(boardType);
  pcbDim = pcbDimensions(boardType);

  enclosureWidth = pcbDim[0] + (wall + offsetX) * 2;
  enclosureDepth = pcbDim[1] + (wall + offsetY) * 2;

  difference()
  {
    union()
    {
      // outer slice
      boundingBox(boardType = boardType, height = wall, offsetX = wall + offsetX, offsetY = wall + offsetY, include=PCB, cornerRadius = wall);
      
      // inner slice
      translate([0, 0, -wall * 0.5])
        boundingBox(boardType = boardType, height = wall * 0.5, offsetX = offsetX - 0.5, offsetY = offsetY - 0.5, include=PCB, cornerRadius = wall);
      
      //Zaczepy pokrywy obudowy (on both sides, according to the offsetY parameter)
      //Lid clips
      translate([0, enclosureDepth * 0.25 - (offsetY + wall), 0])
      {
        translate([-offsetX, 0, 0])
          rotate([0, 180, 90]) clip(clipHeight = 10);
        translate([offsetX + boardDim[0], 0, 0])
          rotate([0, 180, 270]) clip(clipHeight = 10);
      }
      //Lid clips
      translate([0, enclosureDepth * 0.75 - (offsetY + wall), 0])
      {
        translate([-offsetX, 0, 0])
          rotate([0, 180, 90]) clip(clipHeight = 10);
        translate([offsetX + boardDim[0], 0, 0])
          rotate([0, 180, 270]) clip(clipHeight = 10);
      }
    }
    
    // cut the logo from the lid
    if (logo != "")
    {
      translate ([enclosureWidth * 0.75 - (offsetX + wall), enclosureDepth * 0.5 - (offsetY + wall), - 2 * wall]) rotate ([0, 0, 90])
      	logo(logo, 8, 4 * wall);  
    }
  }
}

//Offset from board. Negative values are insets
module boardShape( boardType = UNO, offset = 0, height = pcbHeight )
{
  dimensions = boardDimensions(boardType);

  xScale = (dimensions[0] + offset * 2) / dimensions[0];
  yScale = (dimensions[1] + offset * 2) / dimensions[1];

  translate([-offset, -offset, 0])
    scale([xScale, yScale, 1.0])
      linear_extrude(height = height) 
        polygon(points = boardShapes[boardType]);
}

//Create a bounding box around the board
//Offset - will increase the size of the box on each side,
//Height - overides the boardHeight and offset in the z direction

BOARD = 0;        //Includes all components and PCB
PCB = 1;          //Just the PCB
COMPONENTS = 2;   //Just the components

module boundingBox(boardType = UNO, offsetX = 0, offsetY = 0, height = 0, cornerRadius = 0, include = BOARD) {
  //What parts are included? Entire board, pcb or just components.
  pos = ([boardPosition(boardType), pcbPosition(boardType), componentsPosition(boardType)])[include];
  dim = ([boardDimensions(boardType), pcbDimensions(boardType), componentsDimensions(boardType)])[include];

  //Depending on if height is set position and dimensions will change
  position = [
        pos[0] - offsetX,
        pos[1] - offsetY,
        (height == 0 ? pos[2] - min(offsetX, offsetY) : pos[2] )
        ];

  dimensions = [
        dim[0] + (offsetX * 2), 
        dim[1] + (offsetY * 2), 
        (height == 0 ? dim[2] + min(offsetX, offsetY) * 2 : height)
        ];

  translate( position ) {
    if( cornerRadius == 0 ) {
      cube( dimensions );
    } else {
      roundedCube( dimensions, cornerRadius=cornerRadius );
    }
  }
}

//Creates standoffs for different boards
TAPHOLE = 0;
PIN = 1;

module standoffs( 
  boardType = UNO, 
  height = 10, 
  topRadius = mountingHoleRadius + 1, 
  bottomRadius =  mountingHoleRadius + 2, 
  holeRadius = mountingHoleRadius,
  mountType = TAPHOLE
  )
{
  holePlacement(boardType = boardType)
    union()
    {
      difference()
      {
        cylinder(r1 = bottomRadius, r2 = topRadius, h = height, $fn = 32);
        if ( mountType == TAPHOLE )
        {
          cylinder(r = holeRadius, h = height * 4, center = true, $fn = 32);
        }
      }
      if ( mountType == PIN )
      {
        translate([0, 0, height - 1])
        pintack( h=pcbHeight + 3, r = holeRadius, lh = 3, lt = 1, bh = 1, br = topRadius );
      }
    }  
}

//This is used for placing the mounting holes and for making standoffs
//child elements will be centered on that chosen boards mounting hole centers
module holePlacement( boardType = UNO )
{
  for ( i = boardHoles[boardType] )
  {
    translate(i)
      children(0);
  }
}

//Places components on board
//  compenent - the data set with a particular component (like boardHeaders)
//  extend - the amount to extend the component in the direction of its socket
//  offset - the amount to increase the components other two boundaries

//Component IDs
ALL = -1;
HEADER_F = 0;
HEADER_M = 1;
USB = 2;
POWER = 3;
RJ45 = 4;
OTHER = 5;

module components( boardType = UNO, component = ALL, extension = 0, offset = 0 )
{
  translate([0, 0, pcbHeight])
  {
    for( i = [0:len(components[boardType]) - 1] )
    {
      if( components[boardType][i][3] == component || component == ALL)
      {
          //Calculates position + adjustment for offset and extention  
          position = components[boardType][i][0] 
            - (([1,1,1] - components[boardType][i][2]) * offset)
            + [  min(components[boardType][i][2][0],0), min(components[boardType][i][2][1],0), min(components[boardType][i][2][2],0) ] 
            * extension;
          //Calculates the full box size including offset and extention
          dimensions = components[boardType][i][1] 
            + ((components[boardType][i][2] * [1,1,1]) 
              * components[boardType][i][2]) * extension
            + ([1,1,1] - components[boardType][i][2]) * offset * 2;        
          translate( position ) color( components[boardType][i][4] ) 
            cube( dimensions );
      }
    }  
  }
}

module roundedCube( dimensions = [10, 10, 10], cornerRadius = 1, faces = 32 )
{
  hull() cornerCylinders( dimensions = dimensions, cornerRadius = cornerRadius, faces = faces ); 
}

module cornerCylinders( dimensions = [10, 10, 10], cornerRadius = 1, faces = 32 )
{
  translate([ cornerRadius, cornerRadius, 0])
  {
    cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
    translate([dimensions[0] - cornerRadius * 2, 0, 0]) cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
    translate([0, dimensions[1] - cornerRadius * 2, 0])
    {
      cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
      translate([dimensions[0] - cornerRadius * 2, 0, 0]) cylinder( r = cornerRadius, $fn = faces, h = dimensions[2] );
    }
  }
}

//Create a clip that snapps into a clipHole
module clip(clipWidth = 5, clipDepth = 5, clipHeight = 5, lipDepth = 1.5, lipHeight = 3)
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

//Hole for clip
module clipHole(clipWidth = 5, clipDepth = 5, clipHeight = 5, lipDepth = 1.5, lipHeight = 3, holeDepth = 5)
{
  offset = 0.1;
  translate([-clipWidth/2,-(clipDepth-lipDepth),0])
  translate([-offset, clipDepth - lipDepth-offset, clipHeight - lipHeight - offset])
    cube( [clipWidth + offset * 2, holeDepth, lipHeight + offset * 2] );
}

module mountingHole(screwHeadRad = woodscrewHeadRad, screwThreadRad = woodscrewThreadRad, screwHeadHeight = woodscrewHeadHeight, holeDepth = 10)
{
  union()
  {
    translate([0, 0, -0.01])
      cylinder( r = screwThreadRad, h = 1.02, $fn = 32 );
    translate([0, 0, 1])
      cylinder( r1 = screwThreadRad, r2 = screwHeadRad, h = screwHeadHeight, $fn = 32 );
    translate([0, 0, screwHeadHeight - 0.01 + 1])
      cylinder( r = screwHeadRad, h = holeDepth - screwHeadHeight + 0.02, $fn = 32 );
  }
}

/******************************** UTILITY FUNCTIONS *******************************/

//Return the length side of a square given its diagonal
function sides( diagonal ) = sqrt(diagonal * diagonal  / 2);

//Return the minimum values between two vectors of either length 2 or 3. 2D Vectors are treated as 3D vectors who final value is 0.
function minVec( vector1, vector2 ) =
  [min(vector1[0], vector2[0]), min(vector1[1], vector2[1]), min((vector1[2] == undef ? 0 : vector1[2]), (vector2[2] == undef ? 0 : vector2[2]) )];

//Return the maximum values between two vectors of either length 2 or 3. 2D Vectors are treated as 3D vectors who final value is 0.
function maxVec( vector1, vector2 ) =
  [max(vector1[0], vector2[0]), max(vector1[1], vector2[1]), max((vector1[2] == undef ? 0 : vector1[2]), (vector2[2] == undef ? 0 : vector2[2]) )];

//Determine the minimum point on a component in a list of components
function minCompPoint( list, index = 0, minimum = [10000000, 10000000, 10000000] ) = 
  index >= len(list) ? minimum : minCompPoint( list, index + 1, minVec( minimum, list[index][0] ));

//Determine the maximum point on a component in a list of components
function maxCompPoint( list, index = 0, maximum = [-10000000, -10000000, -10000000] ) = 
  index >= len(list) ? maximum : maxCompPoint( list, index + 1, maxVec( maximum, list[index][0] + list[index][1]));

//Determine the minimum point in a list of points
function minPoint( list, index = 0, minimum = [10000000, 10000000, 10000000] ) = 
  index >= len(list) ? minimum : minPoint( list, index + 1, minVec( minimum, list[index] ));

//Determine the maximum point in a list of points
function maxPoint( list, index = 0, maximum = [-10000000, -10000000, -10000000] ) = 
  index >= len(list) ? maximum : maxPoint( list, index + 1, maxVec( maximum, list[index] ));

//Returns the pcb position and dimensions
function pcbPosition(boardType = UNO) = minPoint(boardShapes[boardType]);
function pcbDimensions(boardType = UNO) = maxPoint(boardShapes[boardType]) - minPoint(boardShapes[boardType]) + [0, 0, pcbHeight];

//Returns the position of the box containing all components and its dimensions
function componentsPosition(boardType = UNO) = minCompPoint(components[boardType]) + [0, 0, pcbHeight];
function componentsDimensions(boardType = UNO) = maxCompPoint(components[boardType]) - minCompPoint(components[boardType]);

//Returns the position and dimensions of the box containing the pcb board
function boardPosition(boardType = UNO) = 
  minCompPoint([[pcbPosition(boardType), pcbDimensions(boardType)], [componentsPosition(boardType), componentsDimensions(boardType)]]);
function boardDimensions(boardType = UNO) = 
  maxCompPoint([[pcbPosition(boardType), pcbDimensions(boardType)], [componentsPosition(boardType), componentsDimensions(boardType)]]) 
  - minCompPoint([[pcbPosition(boardType), pcbDimensions(boardType)], [componentsPosition(boardType), componentsDimensions(boardType)]]);

/******************************* BOARD SPECIFIC DATA ******************************/
//Board IDs
NG = 0;
DIECIMILA = 1;
DUEMILANOVE = 2;
UNO = 3;
LEONARDO = 4;
MEGA = 5;
MEGA2560 = 6;
MEGA2560_CLONE = 7;
DUE = 8;
YUN = 9; 
INTELGALILEO = 10;
TRE = 11;
ETHERNET = 12;
ETHERNET_SHIELD = 13;
ALLINONE_SHIELD = 14;

/********************************** MEASUREMENTS **********************************/
pcbHeight = 1.7;
headerWidth = 2.54;
headerHeight = 9;
mountingHoleRadius = 3.2 / 2;

ngWidth = 53.34;
leonardoDepth = 68.58 + 1.1;           //PCB depth plus offset of USB jack (1.1)
ngDepth = 68.58 + 6.5;
megaDepth = 101.6 + 6.5;               //Coding is my business and business is good!
dueDepth = 101.6 + 1.1;

arduinoHeight = 11 + pcbHeight + 0;

/********************************* MOUNTING HOLES *********************************/

//Duemilanove, Diecimila, NG and earlier
ngHoles = [
  [  2.54, 15.24 ],
  [  17.78, 66.04 ],
  [  45.72, 66.04 ]
  ];

//Uno, Leonardo holes
unoHoles = [
  [  2.54, 15.24 ],
  [  17.78, 66.04 ],
  [  45.72, 66.04 ],
  [  50.8, 13.97 ]
  ];

//Due and Mega 2560
dueHoles = [
  [  2.54, 15.24 ],
  [  17.78, 66.04 ],
  [  45.72, 66.04 ],
  [  50.8, 13.97 ],
  [  2.54, 90.17 ],
  [  50.8, 96.52 ]
  ];
  
//Due and Mega 2560 CHINA CLONE
mega2560CloneHoles = [
  [  2.54, 15.9 ],
  [  17.78, 66.04 ],
  [  45.72, 66.04 ],
  [  50.8, 14.3 ],
  [  2.54, 90.54 ],
  [  50.8, 96.52 ]
  ];

// Original Mega holes
megaHoles = [
  [  2.54, 15.24 ],
  [  50.8, 13.97 ],
  [  2.54, 90.17 ],
  [  50.8, 96.52 ]
  ];

boardHoles = [ 
  ngHoles,             //NG
  ngHoles,             //Diecimila
  ngHoles,             //Duemilanove
  unoHoles,            //Uno
  unoHoles,            //Leonardo
  megaHoles,           //Mega
  dueHoles,            //Mega 2560
  mega2560CloneHoles,  //Mega 2560 Clone
  dueHoles,            //Due
  0,                   //Yun
  0,                   //Intel Galileo
  0,                   //Tre
  unoHoles,            //Ethernet
  unoHoles,            //Ethernet Shield
  dueHoles             //All in one Elotonio Shield (Stairs / Mysensors Gateway..)
  ];

/********************************** BOARD SHAPES **********************************/

// offset to the arduino board origin
allinoneBoardShapeOffset = [-15.1, 1.0];

ngBoardShape = [ 
  [  0.0, 0.0 ],
  [  53.34, 0.0 ],
  [  53.34, 66.04 ],
  [  50.8, 66.04 ],
  [  48.26, 68.58 ],
  [  15.24, 68.58 ],
  [  12.7, 66.04 ],
  [  1.27, 66.04 ],
  [  0.0, 64.77 ]
  ];

megaBoardShape = [ 
  [  0.0, 0.0 ],
  [  53.34, 0.0 ],
  [  53.34, 99.06 ],
  [  52.07, 99.06 ],
  [  49.53, 101.6 ],
  [  15.24, 101.6 ],
  [  12.7, 99.06 ],
  [  2.54, 99.06 ],
  [  0.0, 96.52 ]
  ];

  
  // uwzglednienie przesuniecia wzgledem rogu arduino
allinoneBoardShape = [ 
  [  7.68, 0.0 ] + allinoneBoardShapeOffset,
  [  75.68, 0.0 ] + allinoneBoardShapeOffset,
  [  75.68, 4.76 ] + allinoneBoardShapeOffset,
  [  83.36, 4.76 ] + allinoneBoardShapeOffset,
  [  83.36, 94.74 ] + allinoneBoardShapeOffset,
  [  75.68, 94.74 ] + allinoneBoardShapeOffset,
  [  75.68, 99.5 ] + allinoneBoardShapeOffset,
  [  7.68, 99.5 ] + allinoneBoardShapeOffset,
  [  7.68, 94.74 ] + allinoneBoardShapeOffset,
  [  0, 94.74 ] + allinoneBoardShapeOffset,
  [  0, 4.76 ] + allinoneBoardShapeOffset,
  [  7.68, 4.76 ] + allinoneBoardShapeOffset
  ];

boardShapes = [   
  ngBoardShape,       //NG
  ngBoardShape,       //Diecimila
  ngBoardShape,       //Duemilanove
  ngBoardShape,       //Uno
  ngBoardShape,       //Leonardo
  megaBoardShape,     //Mega
  megaBoardShape,     //Mega 2560
  megaBoardShape,     //Mega 2560 Clone
  megaBoardShape,     //Due
  0,                  //Yun
  0,                  //Intel Galileo
  0,                  //Tre
  ngBoardShape,       //Ethernet
  ngBoardShape,       //Ethernet Shield
  allinoneBoardShape  //All in one Elotonio Shield (Stairs / Mysensors Gateway..)
  ];  

/*********************************** COMPONENTS ***********************************/

//Component data. 
//[position, dimensions, direction(which way would a cable attach), type(header, usb, etc.), color]
ngComponents = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 6, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[9.34, -6.5, 0],[12, 16, 11],[0, -1, 0], USB, "LightGray" ],
  [[40.7, -1.8, 0], [9.0, 13.2, 10.9], [0, -1, 0], POWER, "Black" ]
  ];

etherComponents = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 6, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[7.20, -4.4, 0],[16, 22, 13],[0, -1, 0], RJ45, "Green" ],
  [[40.7, -1.8, 0], [9.0, 13.2, 10.9], [0, -1, 0], POWER, "Black" ]
  ];
  
etherShieldComponents = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 6, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[7.20, -4.4, 0],[16, 22, 13],[0, -1, 0], RJ45, "Green" ]
  ];
  
allinoneShieldComponents = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 67.31, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 72.39, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 92.71, 0], [headerWidth * 18, headerWidth * 2, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[13.5, -5.0, 0.0] + allinoneBoardShapeOffset, [40.9, 9.0, 9.0], [0, -1, 0], OTHER, "Sienna" ],  // DSUB's
  [[55.6, -5.0, 0.0] + allinoneBoardShapeOffset, [14.0, 9.0, 5.0], [0, -1, 0], OTHER, "Sienna" ],  // ARK's front
  [[-5.0, 14.75, 0.0] + allinoneBoardShapeOffset, [9.0, 70.0, 5.0], [-1, 0, 0], OTHER, "Sienna" ], //, // ARK's side 1 PINS
  [[79.36, 9.0, 0.0] + allinoneBoardShapeOffset, [9.0, 7.0, 5.0], [1, 0, 0], OTHER, "Sienna" ],    // ARK's side 2 PINS
  [[79.36, 20.0, 0.0] + allinoneBoardShapeOffset, [9.0, 70.0, 5.0], [1, 0, 0], OTHER, "Sienna" ]  // ARK's side 2 POWER
  ];

leonardoComponents = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 6, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[11.5, -1.1, 0],[7.5, 5.9, 3],[0, -1, 0], USB, "LightGray" ],
  [[40.7, -1.8, 0], [9.0, 13.2, 10.9], [0, -1, 0], POWER, "Black" ]
  ];

megaComponents = [
  [[1.27, 22.86, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[1.27, 67.31, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[49.53, 31.75, 0], [headerWidth, headerWidth * 6, headerHeight ], [0, 0, 1], HEADER_F, "Black"],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[49.53, 72.39, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[1.27, 92.71, 0], [headerWidth * 18, headerWidth * 2, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[9.34, -6.5, 0],[12, 16, 11],[0, -1, 0], USB, "LightGray"],
  [[40.7, -1.8, 0], [9.0, 13.2, 10.9], [0, -1, 0], POWER, "Black" ]
  ];

mega2560Components = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 67.31, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 72.39, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 92.71, 0], [headerWidth * 18, headerWidth * 2, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[9.34, -6.5, 0],[12, 16, 11],[0, -1, 0], USB, "LightGray" ],
  [[40.7, -1.8, 0], [9.0, 13.2, 10.9], [0, -1, 0], POWER, "Black" ]
  ];

  // ró¿nice sa co do orygina³u ... mega...
mega2560CloneComponents = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 67.31, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[49.53, 72.39, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[1.27, 92.71, 0], [headerWidth * 18, headerWidth * 2, headerHeight], [0, 0, 1], HEADER_F, "Black" ],
  [[7.2, -8.0, 0],[12, 16, 11],[0, -1, 0], USB, "LightGray" ],
  [[37.6, -5.0, 0], [9.0, 13.2, 10.9], [0, -1, 0], POWER, "Black" ]
  ];

dueComponents = [
  [[1.27, 17.526, 0], [headerWidth, headerWidth * 10, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[1.27, 44.45, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[1.27, 67.31, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[49.53, 26.67, 0], [headerWidth, headerWidth * 8, headerHeight ], [0, 0, 1], HEADER_F, "Black"],
  [[49.53, 49.53, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[49.53, 72.39, 0], [headerWidth, headerWidth * 8, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[1.27, 92.71, 0], [headerWidth * 18, headerWidth * 2, headerHeight], [0, 0, 1], HEADER_F, "Black"],
  [[11.5, -1.1, 0], [7.5, 5.9, 3], [0, -1, 0], USB, "LightGray" ],
  [[27.365, -1.1, 0], [7.5, 5.9, 3], [0, -1, 0], USB, "LightGray" ],
  [[40.7, -1.8, 0], [9.0, 13.2, 10.9], [0, -1, 0], POWER, "Black" ]
  ];
  
components = [
  ngComponents,             //NG
  ngComponents,             //Diecimila
  ngComponents,             //Duemilanove
  ngComponents,             //Uno
  leonardoComponents,       //Leonardo
  megaComponents,           //Mega
  mega2560Components,       //Mega 2560
  mega2560CloneComponents,  //Mega 2560 Clone
  dueComponents,            //Due
  0,                        //Yun
  0,                        //Intel Galileo
  0,                        //Tre
  etherComponents,          //Ethernet
  etherShieldComponents,    //Ethernet Shield
  allinoneShieldComponents  //All in one Eltonio Shield
  ];

/****************************** NON-BOARD PARAMETERS ******************************/

//Mounting holes
woodscrewHeadRad = 4.6228;  //Number 8 wood screw head radius
woodscrewThreadRad = 2.1336;    //Number 8 wood screw thread radius
woodscrewHeadHeight = 2.8448;  //Number 8 wood screw head height