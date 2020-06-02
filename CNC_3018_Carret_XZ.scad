$fn=75;

x = 50;
y = 66;
z = 16;

color("blue") MotorMount();
color("red") translate([0, -30, 29.4]) rotate([-90, 0, 0]) MotorMountCypel();
color("red") translate([0, -17.8, 29.4]) rotate([-90, 0, 0]) MotorMountCypel();

module MotorMount()
{
difference() {
import("c:/Users/joann/Downloads/SSChain-cable_input-v1.0.stl");
    union() {
        translate([-5, -15, 14.00]) cube([10, 10, 5]);
        translate([-8, 5.5, 14.00]) cube([16, 10, 20]);
    }

}

}

module MotorMountCypel() {
intersection() { 
import("c:/Users/joann/Downloads/SSChain-cable_input-v1.0.stl");
        translate([-8, 5.5, 14.01]) cube([16, 10, 20]);
}
}