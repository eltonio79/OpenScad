// Size of the cube
osize=25.2;
// Size of the fingers
isize=21.8;
// Vein size
vsize=1.5;

offset=(osize-isize)/2;

union() {
 cube([osize,osize,osize]);
 translate([0,osize,0]) { finger(); }
 translate([0,osize,osize]) { rotate([90,0,0])  finger(); }
 translate([osize,osize,osize]) { rotate([90,90,0])  finger(); }
};

// Sizing test
//rotate([90,0,0]) scale([1,0.3,1]) finger();

module finger() {
 translate([vsize+offset,0,vsize+offset]) cube([isize-(2*vsize),isize,isize-(2*vsize)]);
 // bottom
 translate([(osize/2)-(vsize/2),0,offset]) cube([vsize,isize,vsize]);
 translate([(osize/3)-(vsize/2),0,offset]) cube([vsize,isize,vsize]);
 translate([((osize/3)*2)-(vsize/2),0,offset]) cube([vsize,isize,vsize]);
 // top
 translate([(osize/2)-(vsize/2),0,offset+isize-vsize]) cube([vsize,isize,vsize]);
 translate([(osize/3)-(vsize/2),0,offset+isize-vsize]) cube([vsize,isize,vsize]);
 translate([((osize/3)*2)-(vsize/2),0,offset+isize-vsize]) cube([vsize,isize,vsize]);
 // left
 translate([offset,0,(osize/2)-(vsize/2)]) cube([vsize,isize,vsize]);
 translate([offset,0,(osize/3)-(vsize/2)]) cube([vsize,isize,vsize]);
 translate([offset,0,((osize/3)*2)-(vsize/2)]) cube([vsize,isize,vsize]);
 // right
 translate([offset+isize-vsize,0,(osize/2)-(vsize/2)]) cube([vsize,isize,vsize]);
 translate([offset+isize-vsize,0,(osize/3)-(vsize/2)]) cube([vsize,isize,vsize]);
 translate([offset+isize-vsize,0,((osize/3)*2)-(vsize/2)]) cube([vsize,isize,vsize]);
}