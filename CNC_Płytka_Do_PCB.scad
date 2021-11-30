$fn=25;

module m4() {
    translate([0,6,0]) {
        rotate([90,0,0]) {
            translate([0,0,2]) cylinder(h=4,r=3.5,center=true);
            translate([0,0,7]) cylinder(h=14,r=2,center=true);
        }
    }
}

module plate() {
    difference() {
        cube([150,6,100]);
        translate([7.5,0,87.5]) m4();
        translate([75,0,87.5]) m4();
        translate([142.5,0,87.5]) m4();
        translate([7.5,0,12.5]) m4();
        translate([75,0,12.5]) m4();
        translate([142.5,0,12.5]) m4();
        translate([7.5,0,50]) m4();
        translate([75,0,50]) m4();
        translate([142.5,0,50]) m4();
        
        for ( i = [5 : 5 : 145] ){
            for ( j = [5 : 5 : 95] ){
                if ((abs(i-7.5)>5&&abs(i-75)>5&&abs(i-142.5)>5)||(abs(j-12.5)>5&&abs(j-50)>5&&abs(j-87.5)>5)) {
                    translate([i,4,j])  rotate([90,0,0]) cylinder(h=4,r=0.75,center=true);
                }
            }
        }
    }
}

rotate([0,0,180]) plate();
