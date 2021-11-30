difference() {
  difference() {
    color([0.500, 0.000, 0.200, 0.600]) {
      translate(v=[0.000, 65.000, 30.000]) {
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
                        cube(size=[90.000, 7.000, 8.000], center=false);
                      } // End mirror
                    } // End union
                    translate(v=[0.000, 7.142, -7.000]) {
                    rotate([-135.000,-180.000,-180.000]){
                      mirror(v=[0.000, 1.000, 0.000]) {
                        cube(size=[90.000, 20.000, 20.000], center=false);
                      } // End mirror
                    } // End rotate
                    } // End translate
                  } // End difference
                  translate(v=[21.000, 15.000, 0.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    cylinder(h=48.000, r1=7.550, r2=7.550, $fn=60, center=false);
                  } // End rotate
                  } // End translate
                } // End difference
                translate(v=[69.000, 15.000, 0.000]) {
                rotate([-180.000,-180.000,-180.000]){
                  cylinder(h=48.000, r1=7.550, r2=7.550, $fn=60, center=false);
                } // End rotate
                } // End translate
              } // End difference
              translate(v=[45.000, 15.000, 0.000]) {
              rotate([-180.000,-180.000,-180.000]){
                union() {
                  cylinder(h=48.000, r1=4.750, r2=4.750, $fn=60, center=false);
                  translate(v=[0.000, 0.000, 21.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    cylinder(h=37.000, r1=11.200, r2=11.200, $fn=60, center=false);
                  } // End rotate
                  } // End translate
                  translate(v=[-5.750, -5.750, 0.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    union() {
                      cylinder(h=47.000, r1=1.600, r2=1.600, $fn=60, center=false);
                      cylinder(h=13.000, r1=2.900, r2=2.900, $fn=60, center=false);
                    } // End union
                  } // End rotate
                  } // End translate
                  translate(v=[-5.750, 5.750, 0.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    union() {
                      cylinder(h=47.000, r1=1.600, r2=1.600, $fn=60, center=false);
                      cylinder(h=13.000, r1=2.900, r2=2.900, $fn=60, center=false);
                    } // End union
                  } // End rotate
                  } // End translate
                  translate(v=[5.750, -5.750, 0.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    union() {
                      cylinder(h=47.000, r1=1.600, r2=1.600, $fn=60, center=false);
                      cylinder(h=13.000, r1=2.900, r2=2.900, $fn=60, center=false);
                    } // End union
                  } // End rotate
                  } // End translate
                  translate(v=[5.750, 5.750, 0.000]) {
                  rotate([-180.000,-180.000,-180.000]){
                    union() {
                      cylinder(h=47.000, r1=1.600, r2=1.600, $fn=60, center=false);
                      cylinder(h=13.000, r1=2.900, r2=2.900, $fn=60, center=false);
                    } // End union
                  } // End rotate
                  } // End translate
                } // End union
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
                        cylinder(h=36.700, r1=3.100, r2=3.100, $fn=60, center=false);
                        translate(v=[0.000, 0.000, -2.475]) {
                        rotate([-180.000,-180.000,-180.000]){
                          union() {
                            translate(v=[0.000, 0.000, 28.500]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                            } // End rotate
                            } // End translate
                            translate(v=[0.000, 0.000, 32.000]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=2.000, r1=7.000, r2=7.000, $fn=100, center=true);
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
                        cylinder(h=36.700, r1=3.100, r2=3.100, $fn=60, center=false);
                        translate(v=[0.000, 0.000, -2.475]) {
                        rotate([-180.000,-180.000,-180.000]){
                          union() {
                            translate(v=[0.000, 0.000, 28.500]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                            } // End rotate
                            } // End translate
                            translate(v=[0.000, 0.000, 32.000]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=2.000, r1=7.000, r2=7.000, $fn=100, center=true);
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
                        cylinder(h=36.700, r1=3.100, r2=3.100, $fn=60, center=false);
                        translate(v=[0.000, 0.000, -2.475]) {
                        rotate([-180.000,-180.000,-180.000]){
                          union() {
                            translate(v=[0.000, 0.000, 28.500]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                            } // End rotate
                            } // End translate
                            translate(v=[0.000, 0.000, 32.000]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=2.000, r1=7.000, r2=7.000, $fn=100, center=true);
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
                        cylinder(h=36.700, r1=3.100, r2=3.100, $fn=60, center=false);
                        translate(v=[0.000, 0.000, -2.475]) {
                        rotate([-180.000,-180.000,-180.000]){
                          union() {
                            translate(v=[0.000, 0.000, 28.500]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=5.020, r1=6.025, r2=6.025, $fn=6, center=true);
                            } // End rotate
                            } // End translate
                            translate(v=[0.000, 0.000, 32.000]) {
                            rotate([-180.000,-180.000,-180.000]){
                              cylinder(h=2.000, r1=7.000, r2=7.000, $fn=100, center=true);
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
    translate(v=[35.000, 36.000, 56.000]) {
    rotate([-90.000,-180.000,-180.000]){
      union() {
        scale(v=[0.049, 0.049, 0.049]) {
          translate(v=[0.000, 0.000, 25.000]) {
          rotate([-180.000,-180.000,-180.000]){
            linear_extrude(height=50.000, twist=0, $fn=100, convexity=10, center=true){import ("c:/Projekty/OOML/OOML/data/dxf/E.dxf");}
          } // End rotate
          } // End translate
        } // End scale
        translate(v=[10.000, 0.000, 0.000]) {
        rotate([-180.000,-180.000,-180.000]){
          scale(v=[0.049, 0.049, 0.049]) {
            translate(v=[0.000, 0.000, 25.000]) {
            rotate([-180.000,-180.000,-180.000]){
              linear_extrude(height=50.000, twist=0, $fn=100, convexity=10, center=true){import ("c:/Projekty/OOML/OOML/data/dxf/L.dxf");}
            } // End rotate
            } // End translate
          } // End scale
        } // End rotate
        } // End translate
        translate(v=[20.000, 0.000, 0.000]) {
        rotate([-180.000,-180.000,-180.000]){
          scale(v=[0.049, 0.049, 0.049]) {
            translate(v=[0.000, 0.000, 25.000]) {
            rotate([-180.000,-180.000,-180.000]){
              linear_extrude(height=50.000, twist=0, $fn=100, convexity=10, center=true){import ("c:/Projekty/OOML/OOML/data/dxf/T.dxf");}
            } // End rotate
            } // End translate
          } // End scale
        } // End rotate
        } // End translate
      } // End union
    } // End rotate
    } // End translate
  } // End difference
  translate(v=[35.000, 37.000, 42.000]) {
  rotate([-90.000,-180.000,-180.000]){
    union() {
      scale(v=[0.049, 0.049, 0.049]) {
        translate(v=[0.000, 0.000, 25.000]) {
        rotate([-180.000,-180.000,-180.000]){
          linear_extrude(height=50.000, twist=0, $fn=100, convexity=10, center=true){import ("c:/Projekty/OOML/OOML/data/dxf/C.dxf");}
        } // End rotate
        } // End translate
      } // End scale
      translate(v=[10.000, 0.000, 0.000]) {
      rotate([-180.000,-180.000,-180.000]){
        scale(v=[0.049, 0.049, 0.049]) {
          translate(v=[0.000, 0.000, 25.000]) {
          rotate([-180.000,-180.000,-180.000]){
            linear_extrude(height=50.000, twist=0, $fn=100, convexity=10, center=true){import ("c:/Projekty/OOML/OOML/data/dxf/N.dxf");}
          } // End rotate
          } // End translate
        } // End scale
      } // End rotate
      } // End translate
      translate(v=[20.000, 0.000, 0.000]) {
      rotate([-180.000,-180.000,-180.000]){
        scale(v=[0.049, 0.049, 0.049]) {
          translate(v=[0.000, 0.000, 25.000]) {
          rotate([-180.000,-180.000,-180.000]){
            linear_extrude(height=50.000, twist=0, $fn=100, convexity=10, center=true){import ("c:/Projekty/OOML/OOML/data/dxf/C.dxf");}
          } // End rotate
          } // End translate
        } // End scale
      } // End rotate
      } // End translate
    } // End union
  } // End rotate
  } // End translate
} // End difference
