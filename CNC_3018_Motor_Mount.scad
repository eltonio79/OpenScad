$fn=75;

x = 50;
y = 66;
z = 16;

MotorMount();

module MotorMount()
{
    translate([x, 0, 0]) rotate ([0, 0, 90]) translate ([y / 2, x / 2, 0]) import("Stepper_mount_-_ver_1.0.1.stl");
    
    translate([0, 0, -15]) cube([x, 27, 15]);
}