$fn = 64;

smallHolePos = 15.0;
width = 23.7;
height = 29.0;
bearingDiameterOuter = 15.75;
bearingDiameterInner = 8.2;
bearingPos = 39;

difference()
{
  union()
  {
    cube ([bearingPos, width, height]);
      
    translate ([bearingPos, width / 2, 0])
      cylinder (r = width / 2, h = height, center = false);
  }
  
  union()
  {
    //ciach
    translate ([5, 0, 9])
      cube ([20.5, width, height]);
      
    translate ([30.5, 0, 9])
      cube ([50, width, height]);
      
    translate ([smallHolePos, width / 2, 0])
      cylinder (r = 5.2 / 2, h = 10, center = false);
      
    //bearing cut
    translate ([bearingPos, width / 2, 0])
      cylinder (r = bearingDiameterInner / 2, h = 10, center = false); // center
      
    translate ([bearingPos, width / 2, 3.4])
      cylinder (r = bearingDiameterOuter / 2, h = 10, center = false); // outer
  }
}