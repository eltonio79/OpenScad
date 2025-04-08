logo="Slub-0342.png"; 

wid=58; 
logox = 537; 
logoy = 432; 

difference(){ 
    cube([wid,wid,2]); 
    translate([wid/4,wid/4,3]) 
        scale([.5*wid/logox,.5*wid/logoy,.02]) 
            surface(file=logo,invert=true); 

} 