// General
$fn = 128;
$VerticalHoleAdjust = 0.5;
$HorizontalHoleAdjust = 0.4;
$XZSpacing = 4;

// Stepper Motor
$StepperMountHolesDistance = 31;
$StepperMountHole = 3;
$StepperMountHoleSink = 5.5;
$StepperMountHoleSinkDepth = 3.5;

// T8 Lead Screw
$T8BigOuter = 22;
$T8BigDepth = 4;

$T8SmallOuter = 14;
$T8SmallDepth = 28;

$T8ScrewHoleSize = 2.5;
$T8ScrewHeadSize = 4.5;
$T8ScrewHoleDepth = 12;
$T8SpindleHole = 10;

// Z Carriage
$ZBearingOuter = 19;
$ZBearingPadding = 5;
$ZBearingLength = 29;
$ZT8HoleDeepen = 15;
$ZFreedom = 45;
$ZLinearRail = 10;
$ZSpindleBearing = 24;

// X Carriage
$XLinearRailsDistance = 72;
$XWidth = 80;
$XBearingOuter = 19;
$XBearingPadding = 5;
$XTopBottomThickness = 10;
$XT8HoleDeepen = 15;
$XTopStickoutMainHole = 20;
$XTopStickoutRoundedCorner = 15;
$XBottomStickoutRoundedCorner = 15;
$XBearingDepth = 8;

// Spindle
$SpindleHole = 44;
$SpindleMountWallThickness = 10;
$SpindleHoleWallThickness = 6;
$SpindleMountCutoutLowest = 38;
$SpindleMountScrewHoleSize = 3;
$SpindleMountScrewHeadSize = 6;
$SpindleHexHoleSize = 6;
$SpindleClampScrewHoleSize = 3;

// Constants
INFINITY = 10000;
HALF_INFINITY = 5000;

// Calculations
xBearingOuterRadius = $XBearingOuter / 2;
zBearingOuterRadius = $ZBearingOuter / 2;
zHeight = $ZBearingLength * 2;
xHeight = zHeight + $ZFreedom + $XTopBottomThickness;

zDepth = $ZBearingOuter + ($ZBearingPadding * 2);
xDepth = $XBearingOuter + ($XBearingPadding * 2);

module xCarriage() {
	topLinearDistance = (xHeight / 2) - ($XBearingOuter / 2) - $XBearingPadding;
	bottomLinearDistance = topLinearDistance - $XLinearRailsDistance;
	t8Distance = (topLinearDistance + bottomLinearDistance) / 2;
	screwDepth = $T8BigDepth + $XT8HoleDeepen + $T8ScrewHoleDepth;
	screwDistance = (($T8BigOuter - $T8ScrewHoleSize) / 2) * sqrt(2);
	topStickout = 40;
	bottomStickout = $XZSpacing + zDepth;
	bearingCutDepth = xHeight / 2 - $XTopBottomThickness + $XBearingDepth;
	difference() {
		// x carriage block
		roundedRect([xHeight, xDepth, $XWidth], xBearingOuterRadius + $XBearingPadding, [true, true, false, false]);
		// top linear guide hole
		translate([topLinearDistance, 0, -HALF_INFINITY])
			cylinder(d=$XBearingOuter + $VerticalHoleAdjust, INFINITY);
		// bottom linear guide hole
		translate([bottomLinearDistance, 0, -HALF_INFINITY])
			cylinder(d=$XBearingOuter + $VerticalHoleAdjust, INFINITY);
		// T8 spindle hole
		translate([t8Distance, 0, -HALF_INFINITY])
			cylinder(d=$T8SpindleHole + $VerticalHoleAdjust, INFINITY);
		// T8 small nut hole
		translate([t8Distance, 0, ($XWidth / 2) - $T8SmallDepth - $XT8HoleDeepen])
			cylinder(d=$T8SmallOuter + $VerticalHoleAdjust, INFINITY);
		// T8 big nut hole
		translate([t8Distance, 0, ($XWidth / 2) - $T8BigDepth - $XT8HoleDeepen])
			cylinder(d=$T8BigOuter + $VerticalHoleAdjust, INFINITY);
		// T8 screw holes
		translate([t8Distance, 0, 0]) {
			// screw holes
			rectangularArray([2, 2, 1], [screwDistance, screwDistance, 0]) {
				translate([0, 0, ($XWidth / 2) - screwDepth])
					cylinder(d=$T8ScrewHoleSize + $VerticalHoleAdjust, INFINITY);
			}
			// screw head recess
			rectangularArray([2, 2, 1], [screwDistance, screwDistance, 0]) {
				translate([0, 0, ($XWidth / 2) - $T8BigDepth - $XT8HoleDeepen])
					cylinder(d=$T8ScrewHeadSize + $VerticalHoleAdjust, INFINITY);
			}
		}
	}
	// top stickout
	difference() {
		// base
		union() {
			translate([(xHeight / 2) - $XTopBottomThickness / 2, (topStickout / 2) + (xDepth / 2), 0])
				centeredCube([$XTopBottomThickness, topStickout, $XWidth]);
			translate([(xHeight / 2) - $XTopBottomThickness, ($XBearingOuter / 2) + $XBearingPadding, -($XWidth / 2)])
				rotate([0, 0, 90])
					roundedCorner($XZSpacing, $XWidth);
		}
		// main hole
		translate([0, (xDepth / 2) + $XZSpacing + (zDepth / 2), 0])
			rotate([0, 90, 0])
				cylinder(d=$XTopStickoutMainHole + $HorizontalHoleAdjust, INFINITY);
		// stepper holes
		rectangularArray([1, 2, 2], [0, $StepperMountHolesDistance, $StepperMountHolesDistance]) {
			translate([0, (xDepth / 2) + $XZSpacing + (zDepth / 2), 0])
				rotate([0, 90, 0])
					cylinder(d=$StepperMountHole + $HorizontalHoleAdjust, INFINITY);
		}
		// stepper sink holes
		rectangularArray([1, 2, 2], [0, $StepperMountHolesDistance, $StepperMountHolesDistance]) {
			translate([0, (xDepth / 2) + $XZSpacing + (zDepth / 2), 0])
				rotate([0, 90, 0])
					cylinder(d=$StepperMountHoleSink + $HorizontalHoleAdjust, (xHeight / 2) - $XTopBottomThickness + $StepperMountHoleSinkDepth);
		}
		// Z rails holes
		rectangularArray([1, 1, 2], [0, 0, $XWidth - $ZBearingOuter - $ZBearingPadding - $ZLinearRail / 2]) {
			translate([0, (xDepth / 2) + $XZSpacing + (zDepth / 2), 0])
				rotate([0, 90, 0])
					cylinder(d=$ZLinearRail + $HorizontalHoleAdjust, INFINITY);
		}
		translate([0, ($XBearingOuter / 2) + $XBearingPadding + topStickout, $XWidth / 2])
			rotate([-90, 0, 0])
				rotate([0, 90, 0])
					roundedCorner($XTopStickoutRoundedCorner, INFINITY);
		translate([0, ($XBearingOuter / 2) + $XBearingPadding + topStickout, -($XWidth / 2)])
			rotate([180, 0, 0])
				rotate([0, 90, 0])
					roundedCorner($XTopStickoutRoundedCorner, INFINITY);
	}
	// bottom stickout
	difference() {
		// base
		union() {
			translate([-(xHeight / 2) + $XTopBottomThickness / 2, (bottomStickout / 2) + (xDepth / 2), 0])
				centeredCube([$XTopBottomThickness, bottomStickout, $XWidth]);
			translate([-(xHeight / 2) + $XTopBottomThickness, ($XBearingOuter / 2) + $XBearingPadding, -($XWidth / 2)])
				rotate([0, 0, 0])
					roundedCorner($XZSpacing, $XWidth);
		}
		// bearing hole
		translate([-bearingCutDepth, (xDepth / 2) + $XZSpacing + (zDepth / 2), 0])
			rotate([0, 90, 0])
				cylinder(d=$ZSpindleBearing + $HorizontalHoleAdjust, bearingCutDepth);
		// spindle hole
		translate([-INFINITY, (xDepth / 2) + $XZSpacing + (zDepth / 2), 0])
			rotate([0, 90, 0])
				cylinder(d=$T8SpindleHole + $HorizontalHoleAdjust, INFINITY);
		
		// Z rails holes
		rectangularArray([1, 1, 2], [0, 0, $XWidth - $ZBearingOuter - $ZBearingPadding - $ZLinearRail / 2]) {
			translate([-INFINITY, (xDepth / 2) + $XZSpacing + (zDepth / 2), 0])
				rotate([0, 90, 0])
					cylinder(d=$ZLinearRail + $HorizontalHoleAdjust, INFINITY);
		}
		translate([-INFINITY, ($XBearingOuter / 2) + $XBearingPadding + bottomStickout, $XWidth / 2])
			rotate([-90, 0, 0])
				rotate([0, 90, 0])
					roundedCorner($XBottomStickoutRoundedCorner, INFINITY);
		translate([-INFINITY, ($XBearingOuter / 2) + $XBearingPadding + bottomStickout, -($XWidth / 2)])
			rotate([180, 0, 0])
				rotate([0, 90, 0])
					roundedCorner($XBottomStickoutRoundedCorner, INFINITY);
	}
}

module zCarriage() {
	screwDepth = $T8ScrewHoleDepth + $T8BigDepth + $ZT8HoleDeepen;
	screwDistance = (($T8BigOuter - $T8ScrewHoleSize) / 2) * sqrt(2);
	difference() {
		// z carriage block
		roundedRect([$XWidth, zDepth, $ZBearingLength * 2], zBearingOuterRadius + $ZBearingPadding, [true, true, false, false]);
		// left linear guide hole
		translate([($XWidth / 2) - zBearingOuterRadius - $ZBearingPadding, 0, -HALF_INFINITY])
			cylinder(d=$ZBearingOuter + $VerticalHoleAdjust, INFINITY);
		// right linear guide hole
		translate([-($XWidth / 2) + zBearingOuterRadius + $ZBearingPadding, 0, -HALF_INFINITY])
			cylinder(d=$ZBearingOuter + $VerticalHoleAdjust, INFINITY);
		// T8 spindle hole
		translate([0, 0, -HALF_INFINITY])
			cylinder(d=$T8SpindleHole + $VerticalHoleAdjust, INFINITY);
		// T8 small nut hole
		translate([0, 0, (zHeight / 2) - $T8SmallDepth - $ZT8HoleDeepen])
			cylinder(d=$T8SmallOuter + $VerticalHoleAdjust, INFINITY);
		// T8 big nut hole
		translate([0, 0, (zHeight / 2) - $T8BigDepth - $ZT8HoleDeepen])
			cylinder(d=$T8BigOuter + $VerticalHoleAdjust, INFINITY);
		// T8 screw holes
		// screw holes
		rectangularArray([2, 2, 1], [screwDistance, screwDistance, 0]) {
			translate([0, 0, (zHeight / 2) - screwDepth])
				cylinder(d=$T8ScrewHoleSize + $VerticalHoleAdjust, INFINITY);
		}
		// screw head recess
		rectangularArray([2, 2, 1], [screwDistance, screwDistance, 0]) {
			translate([0, 0, (zHeight / 2) - $T8BigDepth - $ZT8HoleDeepen])
				cylinder(d=$T8ScrewHeadSize + $VerticalHoleAdjust, INFINITY);
		}
		// mount holes
		translate([0, $SpindleMountWallThickness + $SpindleHoleWallThickness + ($SpindleHole / 2), 0])
			rotate([90, 0, 0])
				rectangularArray([2, 3, 1], [$XWidth / 3, zHeight / 4, 0])
					cylinder(d=$SpindleMountScrewHoleSize + $HorizontalHoleAdjust, INFINITY);
		// mount hole heads
		translate([0, -($ZBearingOuter / 2) - ($ZBearingPadding) + 4, 0])
			rotate([90, 0, 0])
				rectangularArray([2, 3, 1], [$XWidth / 3, zHeight / 4, 0])
					cylinder(d=$SpindleMountScrewHeadSize + $HorizontalHoleAdjust, INFINITY);
	}
}

module spindleMount() {
	// manually aligning it into a nice position
	spindleClampHoleFiddle = 1.3;
	difference() {
		// base
		union() {
			hull() {
				translate([0, $SpindleMountWallThickness / 2, 0])
					centeredCube([$XWidth, $SpindleMountWallThickness, zHeight]);
				translate([0, $SpindleHole / 2 + $SpindleMountWallThickness, -(zHeight / 2)])
					cylinder(d=$SpindleHole + ($SpindleHoleWallThickness * 2) + $VerticalHoleAdjust, zHeight);
			}
			translate([-($SpindleHole / 2) - ($SpindleHoleWallThickness / 2) - spindleClampHoleFiddle, $SpindleMountWallThickness, -(zHeight / 2) + ($SpindleMountCutoutLowest / 2)])
				rotate([-90, 90, 0])
					cylinder(d=$SpindleHoleWallThickness + $HorizontalHoleAdjust, 40);
		}
		// spindle hole
		translate([0, $SpindleHole / 2 + $SpindleMountWallThickness, -HALF_INFINITY])
			cylinder(d=$SpindleHole + $VerticalHoleAdjust, INFINITY);
		// spindle holder top cutout
		translate([-($XWidth / 2), $SpindleHole + $SpindleHoleWallThickness + $SpindleMountWallThickness, zHeight / 2])
			rotate([-90, 0, -90])
				linear_extrude(height=$XWidth)
					polygon(points=[
						[-1-$VerticalHoleAdjust, -1-$VerticalHoleAdjust],
						[-1-$VerticalHoleAdjust, zHeight - $SpindleMountCutoutLowest],
						[($SpindleHole / 2) + $SpindleHoleWallThickness, zHeight - $SpindleMountCutoutLowest],
						[$SpindleHole + $SpindleHoleWallThickness, 0]
					]);
		// nut hole
		translate([-HALF_INFINITY - ($SpindleHole / 2) + 4, (($SpindleHole / 2) + $SpindleMountWallThickness) / 2, -(zHeight / 2) + ($SpindleMountCutoutLowest / 2)])
			centeredCube([INFINITY, 3.2, 10.3]);
		// crack
		translate([-HALF_INFINITY, ($SpindleHole / 2) + $SpindleMountWallThickness, 0])
			centeredCube([INFINITY, 2, INFINITY]);
		// spindle clamp hole
		translate([-($SpindleHole / 2) - ($SpindleHoleWallThickness / 2) - spindleClampHoleFiddle, $SpindleMountWallThickness, -(zHeight / 2) + ($SpindleMountCutoutLowest / 2)])
			rotate([-90, 90, 0])
				cylinder(d=$SpindleClampScrewHoleSize + $HorizontalHoleAdjust, 50);
		// mount holes
		translate([0, $SpindleMountWallThickness + $SpindleHoleWallThickness + ($SpindleHole / 2), 0])
			rotate([90, 0, 0])
				rectangularArray([2, 3, 1], [$XWidth / 3, zHeight / 4, 0])
					cylinder(d=$SpindleMountScrewHoleSize + $HorizontalHoleAdjust, INFINITY);
		// hex holes
		translate([0, $SpindleMountWallThickness + ($SpindleHole / 2), 0])
			rotate([90, 0, 0])
				rectangularArray([2, 3, 1], [$XWidth / 3, zHeight / 4, 0])
					cylinder(d=$SpindleHexHoleSize + $HorizontalHoleAdjust, ($SpindleHole / 2) + 3, $fn=8);
	}
}

module roundedRect(size, radius, corners = [true, true, true, true])
{
	x = size[0];
	y = size[1];
	z = size[2];
	halfX = x / 2;
	halfY = y / 2;
	translate([0, 0, -z / 2]) {
		linear_extrude(height=z)
			hull() {
				if (corners[0] == true) {
					translate([-halfX + radius, -halfY + radius, 0])
						circle(r=radius);
				} else {
					translate([-halfX, -halfY])
						square(radius);
				}
				if (corners[1] == true) {
			    	translate([halfX - radius, -halfY + radius, 0])
			    		circle(r=radius);
			    } else {
			    	translate([halfX - radius, -halfY])
						square(radius);
			    }
			    if (corners[2] == true) {
			    	translate([-halfX + radius, halfY - radius, 0])
			    		circle(r=radius);
			    } else {
			    	translate([-halfX, halfY - radius, 0])
			    		square(radius);
			    }
			    if (corners[3] == true) {
			    	translate([halfX - radius, halfY - radius, 0])
			    		circle(r=radius);
			    } else {
			    	translate([halfX - radius, halfY - radius, 0])
			    		square(radius);
			    }
			}
	}
}

module centeredCube(dimensions) {
	translate(
		[
			-dimensions[0] / 2,
			-dimensions[1] / 2,
			-dimensions[2] / 2
		]
	)
		cube(dimensions);
}

module rectangularArray(amounts = [1, 1, 1], distances) {
	xMax = (amounts[0] - 1) * distances[0];
	yMax = (amounts[1] - 1) * distances[1];
	zMax = (amounts[2] - 1) * distances[2];
	for (x = [0:1:amounts[0] - 1]) {
		for (y = [0:1:amounts[1] - 1]) {
			for (z = [0:1:amounts[2] - 1]) {
				translate(
					[
						(distances[0] * x) - (xMax / 2),
						(distances[1] * y) - (yMax / 2),
						(distances[2] * z) - (zMax / 2)
					]
				)
					children();
			}
		}
	}
}

module roundedCorner(radius, height) {
	difference() {
		translate([-1, -1, 0])
			cube([radius + 1, radius + 1, height]);
		translate([radius, radius, -5])
			cylinder(r=radius, height + 10);
	}
}

module ruler(length) {
    mark_width = 0.125;
    mark_depth = 0.05;

    difference()
    {
        cube( [1, length, 8 ] );
        for ( i = [1:length-1] )
        {
            translate( [mark_depth, i, 0] ) cube( [1, mark_width, 3 ] );
            translate( [-mark_depth, i, 0] ) cube( [1, mark_width, 3 ] );
            if (i % 5 == 0)
            {
                translate( [mark_depth, i, 0] ) cube( [5, mark_width, 5 ] );
                translate( [-mark_depth, i, 0] ) cube( [5, mark_width, 5 ] );
            }
            if (i % 10 == 0)
            {
                translate( [mark_depth, i, 0] ) cube( [10, mark_width, 7 ] );
                translate( [-mark_depth, i, 0] ) cube( [10, mark_width, 7 ] );
            }
        }
    }
}

module yCage() {
	holeOffset = 22;
	wallThickness = 4.5;
	length = 33;
	lipSize = 14;
	width = $T8BigOuter + (wallThickness * 2) + (lipSize * 2);
	screwDistance = (($T8BigOuter - $T8ScrewHoleSize) / 2) * sqrt(2);
	screwDepth = $T8BigDepth + $T8ScrewHoleDepth;
	difference() {
		// base
		union() {
			translate([0, (length / 2), -holeOffset])
				rotate([90, 0, 0])
					cylinder(d=$T8BigOuter + (wallThickness * 2), length);
			translate([0, 0, -(wallThickness / 2)])
				centeredCube([width, length, wallThickness]);
			translate([0, 0, -(holeOffset / 2)])
				centeredCube([$T8BigOuter + (wallThickness * 2), length, holeOffset]);
		}
		// T8 hole
		translate([0, 0, -holeOffset])
			rotate([90, 90, 180]) {
				// T8 spindle hole
				translate([0, 0, -HALF_INFINITY])
					cylinder(d=$T8SpindleHole + $VerticalHoleAdjust, INFINITY);
				// T8 small nut hole
				translate([0, 0, (length / 2) - $T8SmallDepth])
					cylinder(d=$T8SmallOuter + $VerticalHoleAdjust, INFINITY);
				// T8 big nut hole
				translate([0, 0, (length / 2) - $T8BigDepth])
					cylinder(d=$T8BigOuter + $VerticalHoleAdjust, INFINITY);
				// T8 screw holes
				translate([0, 0, 0]) {
					// screw holes
					rectangularArray([2, 2, 1], [screwDistance, screwDistance, 0]) {
						translate([0, 0, (length / 2) - screwDepth])
							cylinder(d=$T8ScrewHoleSize + $VerticalHoleAdjust, INFINITY);
					}
				}
			}
		// mount holes
		translate([(width / 2) - (lipSize / 2), 0, -HALF_INFINITY])
			cylinder(d=5 + $HorizontalHoleAdjust, INFINITY);
		translate([-(width / 2) + (lipSize / 2), 0, -HALF_INFINITY])
			cylinder(d=5 + $HorizontalHoleAdjust, INFINITY);
		// mount hole sink
		translate([(width / 2) - (lipSize / 2), 0, -INFINITY - wallThickness + wallThickness / 2])
			cylinder(d=7.5 + $HorizontalHoleAdjust, INFINITY);
		translate([-(width / 2) + (lipSize / 2), 0, -INFINITY - wallThickness + wallThickness / 2])
			cylinder(d=7.5 + $HorizontalHoleAdjust, INFINITY);
	}
}

module assembly() {
	color("purple")
		rotate([0, -90, 0])
			translate([0, -($XBearingOuter / 2) - $XBearingPadding, 0])
				xCarriage();
	color("purple")
		translate([0, ($ZBearingOuter / 2) + $ZBearingPadding + $XZSpacing, 0])
			zCarriage();
	color("purple")
		translate([0, ($ZBearingOuter / 2) + $ZBearingPadding + $XZSpacing + ($ZBearingOuter / 2) + $ZBearingPadding, 0])
			spindleMount();	
	color("purple")
		translate([0, 0, -80])
			yCage();
}

// uncomment the next line to show the model assembled together
assembly();

module print() {
	color("purple")
		translate([0, -($XBearingOuter / 2) - $XBearingPadding, $XWidth / 2])
			xCarriage();
	// color("purple")
	// 	translate([0, 0, zHeight / 2])
	// 		zCarriage();
	// color("purple")
	// 	translate([0, 0, zHeight / 2])
	// 		spindleMount();
	// color("purple")
	// 	translate([0, 0, 33 / 2])
	// 		rotate([90, 0, 0])
	// 			yCage();
}
// print();