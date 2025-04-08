module molex(pins) {
	union() {
		cube([pins * 2.54, 3.15, 5.7]);
		translate([2.54/2, 0, 0])
		cube([(pins-1) * 2.54, 11.5, 0.75]);	
		for (z = [1 : pins]) {
			union() {
				translate([2.54 * (z-0.5),-2.54,2.2])
					cube([0.6, 13, 0.6]);

				translate([2.54 * (z-0.5),-2.54,-3])
					cube([0.6,0.6,5.2]);
				
			}
		}
	}
}

module driver () {
	union( ){
		cube([20.3, 15.23, 12]);
		translate([5, 3,,12]) cube([10,10, 10]);
	}
}

module to220() {
	
	translate([0, 4.5, 0])
	rotate([90,0,0])
	union() {
		cube([10, 15, 0.6]);
		cube([10, 9, 4.5]);
		
		for (z = [1:3]) {
			translate([5 + (2-z) * 2.54, 	-12.8, 2.53])
				cube([0.62, 12.8, 0.57]);
		}
	}
}

module sangoinololu() {
	union() {
		// Board 
		cube([101, 51, 1.6]);
		// USB connector
		translate([12, -4, 1.6])
		cube([12, 15.6, 11]);
		
		translate([0,48,1.6]) {
			translate ([17.7,0,0]) molex(4);
			translate ([31,0,0]) molex(2);
			translate ([39,0,0]) molex(4);
			translate ([52,0,0]) molex(2);
			translate ([60,0,0]) molex(4);
			translate ([73,0,0]) molex(2);
			translate ([81,0,0]) molex(4);
		}
	
		translate([0,0,1.6]) rotate([0,0,90]) {
			translate ([20,0,0]) molex(4);
			translate ([33,0,0]) molex(4);

		}

		translate([0,0,1.6]) rotate([0,0,180]) {
			translate ([-39,0,0]) molex(3);
			translate ([-49,0,0]) molex(3);
			translate ([-59,0,0]) molex(3);

		}

		translate([101,0,1.6]) rotate([0,0,270]) {
			translate ([-18,0,0]) molex(2);
			translate ([-25.6,0,0]) molex(2);

		}

		translate([31,8,0]) cube([52.3, 17.5, 11]);

		translate([18.5,20,1.6]) cylinder(25.8 ,6.4 , 6.4);
		translate([11.37 + 20.3 * 0, 28, 1.6]) driver();
		translate([11.37 + 20.3 * 1, 28, 1.6]) driver();
		translate([11.37 + 20.3 * 2, 28, 1.6]) driver();
		translate([11.37 + 20.3 * 3, 28, 1.6]) driver();

				
		translate([12, 21, 6])
		rotate([0,0,90])
		to220();

		translate([12, 21 + 12.5, 6])
		rotate([0,0,90])
		to220();

		translate([94, 41 , 6])
		rotate([0,0,-90])
		to220();
	}

}

sangoinololu();