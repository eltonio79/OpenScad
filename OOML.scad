difference() {
  color([0.000, 0.400, 0.000, 0.200]) {
    translate(v=[0.000, 64.100, 30.000]) {
    rotate([-180.000,-180.000,-180.000]){
      mirror(v=[0.000, 1.000, 0.000]) {
        difference() {
          difference() {
            difference() {
              difference() {
                difference() {
                  union() {
                    translate(v=[45.000, 15.000, 24.000]) {
                    rotate([-180.000,-180.000,-180.000]){
                      union() {
                        cube(size=[82.050, 22.050, 48.000], center=true);
                        translate(v=[41.000, 11.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cylinder(h=48.000, r1=4.000, r2=4.000, $fn=100, center=true);
                        } // End rotate
                        } // End translate
                        translate(v=[-41.000, 11.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cylinder(h=48.000, r1=4.000, r2=4.000, $fn=100, center=true);
                        } // End rotate
                        } // End translate
                        translate(v=[-41.000, -11.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cube(size=[8.000, 8.000, 48.000], center=true);
                        } // End rotate
                        } // End translate
                        translate(v=[41.000, -11.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cube(size=[8.000, 8.000, 48.000], center=true);
                        } // End rotate
                        } // End translate
                        translate(v=[0.000, 13.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cube(size=[82.000, 4.000, 48.000], center=true);
                        } // End rotate
                        } // End translate
                        translate(v=[0.000, -13.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cube(size=[82.000, 4.000, 48.000], center=true);
                        } // End rotate
                        } // End translate
                        translate(v=[43.000, 0.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cube(size=[4.000, 22.000, 48.000], center=true);
                        } // End rotate
                        } // End translate
                        translate(v=[-43.000, 0.000, 0.000]) {
                        rotate([-180.000,-180.000,-180.000]){
                          cube(size=[4.000, 22.000, 48.000], center=true);
                        } // End rotate
                        } // End translate
                      } // End union
                    } // End rotate
                    } // End translate
                    mirror(v=[0.000, 1.000, 0.000]) {
                      translate(v=[21.000, 0.000, 8.000]) {
                      rotate([-180.000,-180.000,-180.000]){
                        linear_extrude(height=40.000, twist=0, $fn=100, convexity=10, center=false) {
                          polygon(points=[[0.000, 0.000], [16.000, 0.000], [14.000, 2.000], [2.000, 2.000]], path=[0, 1, 2, 3]);
                        } // End linear_extrude
                      } // End rotate
                      } // End translate
                    } // End mirror
                    mirror(v=[0.000, 1.000, 0.000]) {
                      translate(v=[53.000, 0.000, 8.000]) {
                      rotate([-180.000,-180.000,-180.000]){
                        linear_extrude(height=40.000, twist=0, $fn=100, convexity=10, center=false) {
                          polygon(points=[[0.000, 0.000], [16.000, 0.000], [14.000, 2.000], [2.000, 2.000]], path=[0, 1, 2, 3]);
                        } // End linear_extrude
                      } // End rotate
                      } // End translate
                    } // End mirror
                    mirror(v=[0.000, 1.000, 0.000]) {
                      cube(size=[90.000, 2.000, 8.000], center=false);
                    } // End mirror
                  } // End union
                  translate(v=[0.000, 10.062, -4.080]) {
                  rotate([-135.000,-180.000,-180.000]){
                    mirror(v=[0.000, 1.000, 0.000]) {
                      cube(size=[90.000, 20.000, 20.000], center=false);
                    } // End mirror
                  } // End rotate
                  } // End translate
                } // End difference
                translate(v=[45.000, 15.000, 0.000]) {
                rotate([-180.000,-180.000,-180.000]){
                  union() {
                    cylinder(h=48.000, r1=4.750, r2=4.750, $fn=100, center=false);
                    translate(v=[0.000, 0.000, 11.000]) {
                    rotate([-180.000,-180.000,-180.000]){
                      cylinder(h=37.000, r1=11.200, r2=11.200, $fn=100, center=false);
                    } // End rotate
                    } // End translate
                    translate(v=[-5.750, -5.750, 0.000]) {
                    rotate([-180.000,-180.000,-180.000]){
                      union() {
                        cylinder(h=37.000, r1=1.600, r2=1.600, $fn=100, center=false);
                        cylinder(h=3.000, r1=2.900, r2=2.900, $fn=100, center=false);
                      } // End union
                    } // End rotate
                    } // End translate
                    translate(v=[-5.750, 5.750, 0.000]) {
                    rotate([-180.000,-180.000,-180.000]){
                      union() {
                        cylinder(h=37.000, r1=1.600, r2=1.600, $fn=100, center=false);
                        cylinder(h=3.000, r1=2.900, r2=2.900, $fn=100, center=false);
                      } // End union
                    } // End rotate
                    } // End translate
                    translate(v=[5.750, -5.750, 0.000]) {
                    rotate([-180.000,-180.000,-180.000]){
                      union() {
                        cylinder(h=37.000, r1=1.600, r2=1.600, $fn=100, center=false);
                        cylinder(h=3.000, r1=2.900, r2=2.900, $fn=100, center=false);
                      } // End union
                    } // End rotate
                    } // End translate
                    translate(v=[5.750, 5.750, 0.000]) {
                    rotate([-180.000,-180.000,-180.000]){
                      union() {
                        cylinder(h=37.000, r1=1.600, r2=1.600, $fn=100, center=false);
                        cylinder(h=3.000, r1=2.900, r2=2.900, $fn=100, center=false);
                      } // End union
                    } // End rotate
                    } // End translate
                  } // End union
                } // End rotate
                } // End translate
              } // End difference
              translate(v=[15.000, 18.000, 0.000]) {
              rotate([-180.000,-180.000,-180.000]){
                cylinder(h=48.000, r1=7.550, r2=7.550, $fn=100, center=false);
              } // End rotate
              } // End translate
            } // End difference
            translate(v=[75.000, 18.000, 0.000]) {
            rotate([-180.000,-180.000,-180.000]){
              cylinder(h=48.000, r1=7.550, r2=7.550, $fn=100, center=false);
            } // End rotate
            } // End translate
          } // End difference
          translate(v=[0.000, 0.000, 8.000]) {
          rotate([-180.000,-180.000,-180.000]){
            mirror(v=[0.000, 0.000, 1.000]) {
              translate(v=[0.000, 0.000, 0.000]) {
              rotate([90.000,-180.000,-180.000]){
                union() {
                  translate(v=[10.000, 10.000, 0.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    union() {
                      cylinder(h=10.000, r1=3.100, r2=3.100, $fn=100, center=false);
                      translate(v=[0.000, 0.000, -22.500]) {
                      rotate([-180.000,-180.000,-180.000]){
                        union() {
                          translate(v=[0.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-5.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-7.500, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                        } // End union
                      } // End rotate
                      } // End translate
                    } // End union
                  } // End rotate
                  } // End translate
                  translate(v=[80.000, 10.000, 0.000]) {
                  rotate([-180.000,-180.000,-0.000]){
                    union() {
                      cylinder(h=10.000, r1=3.100, r2=3.100, $fn=100, center=false);
                      translate(v=[0.000, 0.000, -22.500]) {
                      rotate([-180.000,-180.000,-180.000]){
                        union() {
                          translate(v=[0.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-5.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-7.500, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                        } // End union
                      } // End rotate
                      } // End translate
                    } // End union
                  } // End rotate
                  } // End translate
                  translate(v=[80.000, 30.000, 0.000]) {
                  rotate([-180.000,-180.000,-0.000]){
                    union() {
                      cylinder(h=10.000, r1=3.100, r2=3.100, $fn=100, center=false);
                      translate(v=[0.000, 0.000, -22.500]) {
                      rotate([-180.000,-180.000,-180.000]){
                        union() {
                          translate(v=[0.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-5.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-7.500, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                        } // End union
                      } // End rotate
                      } // End translate
                    } // End union
                  } // End rotate
                  } // End translate
                  translate(v=[10.000, 30.000, 0.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    union() {
                      cylinder(h=10.000, r1=3.100, r2=3.100, $fn=100, center=false);
                      translate(v=[0.000, 0.000, -22.500]) {
                      rotate([-180.000,-180.000,-180.000]){
                        union() {
                          translate(v=[0.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-5.000, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                          translate(v=[-7.500, 0.000, 30.000]) {
                          rotate([-180.000,-180.000,-180.000]){
                            cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                          } // End rotate
                          } // End translate
                        } // End union
                      } // End rotate
                      } // End translate
                    } // End union
                  } // End rotate
                  } // End translate
                } // End union
              } // End rotate
              } // End translate
            } // End mirror
          } // End rotate
          } // End translate
        } // End difference
      } // End mirror
    } // End rotate
    } // End translate
  } // End color
  translate(v=[76.000, 28.500, 15.000]) {
  rotate([-90.000,180.000,-0.000]){
    union() {
    } // End union
  } // End rotate
  } // End translate
} // End difference
