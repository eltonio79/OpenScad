board_x = 52.8;
board_y = 37.7;
board_z = 25; // 25 - bottom, 35 = top

holes_x = 45.8;
holes_y = 30.9;

trimpot_x = 3.2;      //from center
trimpot_y = 12.3;

thickness = 2;
rfillet = 4;


int_x = board_x;// + 10;
$fn=64;
//$fn=15;


//---------------------


bottom();
//translate([0, board_y + 10, 0]) top();

//top();


//---------------------


module bottom() 
{
    //dwires = 3.5;
    boardOffsetX = 0;
    boardOffsetY = 0;

    difference()
    {  
        union()
        {
            base();  
            
            //ziptie mounts
            /*difference()
            {
                #union() {
                    translate([-int_x/2, -(dwires+1)/2, -board_z/2]) cube([4.5, dwires+1, board_z/2-dwires/2.5]);
                    translate([int_x/2-4.5, -(dwires+1)/2, -board_z/2]) cube([4.5, dwires+1, board_z/2-dwires/2.5]);
                }
                translate([-int_x/2, -(dwires+1)/2, -board_z/2+1]) cube([3.2, dwires+1, board_z/2-dwires/2-3]);
                translate([int_x/2-3.2, -(dwires+1)/2, -board_z/2+1]) cube([3.2, dwires+1, board_z/2-dwires/2-3]);
            }*/
            
            // mounting din rail hole outer

            color ("blue") translate([0, 0, -board_z/2-thickness]) cylinder(r1 = 8, r2 = 6, h = 6);
        }

        
        components(4);
        translate([0,0,board_z+2])cube([board_x*2, board_y*2, board_z*2], center = true);       

        difference() {
                translate([0,0,2])cube([board_x*2, board_y*2, 4], center = true);
                rcube([int_x + thickness, board_y + thickness, board_z + thickness], rfillet - thickness/2, center = true);  

        }   
 
        // mounting din rail hole inner (with cone)

            translate([0, 0, -board_z/2-thickness]) cylinder(d = 4, h = 6 + thickness);
            translate([0, 0, -board_z/2-thickness+1]) cylinder(h = 5, r1 = 0, r2 = 3.5, center = false);
        
        // logo
        translate([0, boardOffsetY, 0])
        {
            logo();    
            mirror ([1,0,0])
                logo();
        }  
            
    }
    
    boardStands(boardOffsetX = boardOffsetX, boardOffsetY = boardOffsetY, tips = false);
    
}



module top() 
{
    difference()
    {    
        base();
        components(10);
        translate([0,0,board_z])cube([board_x*2, board_y*2, board_z*2], center = true);    
        intersection() {
            rcube([int_x + thickness, board_y + thickness, board_z + thickness], rfillet - thickness/2, center = true);
            translate([0,0,0])cube([board_x*2, board_y*2, 4], center = true);
        }
        
        //pot hole
        #translate([trimpot_x, -trimpot_y, -board_z/2-thickness]) cylinder(d = 3.5 , h = thickness+1);
        //wentilation holes
        #wentilation();
    }
}



module base () 
{
    difference()
    {
        rcube([int_x + thickness*2, board_y + thickness*2, board_z + thickness*2], rfillet, center = true);
        rcube([int_x, board_y, board_z], rfillet-thickness, center = true);
    }
}


module components(height = 4) 
{
    #translate([-int_x/2-thickness, 0, 0])
        cube([10, 10, height], center = true);
    #translate([int_x/2-thickness, 0, 0])
        cube([10, 10, height], center = true);
}

module wentilation()
{
    offsetX = 1;
    
        //wentilation holes
        for(variable = [-25 + offsetX : 5 : -5 + offsetX])
        {   
            translate([variable,-board_y/3 - thickness,-board_z/2-thickness]) cube([3,board_y/2 + (5.3 * thickness),board_z/3]);
        }
        translate([offsetX,-board_y / 5.4 - thickness,-board_z/2-thickness]) cube([3,board_y/2 - 5.6 + (5.3 * thickness),board_z/3]);
        for(variable = [5 + offsetX : 5 : 20 + offsetX])
        {
            translate([variable,-board_y/3 - thickness,-board_z/2-thickness]) cube([3,board_y/2 + (5.3 * thickness),board_z/3]);
        }
}

module boardStands(tips = true, boardOffsetX = 0, boardOffsetY = 0)
{
    if(tips == true)
    {
        union()
        {
            boardStandsFillets(boardOffsetX, boardOffsetY);
            boardStandsTips(boardOffsetX, boardOffsetY);
        }
    }
    else
    {
        difference()
        {
            boardStandsFillets(boardOffsetX, boardOffsetY);
            boardStandsTips(boardOffsetX, boardOffsetY);
        }
    }
}

module boardStandsFillets(boardOffsetX = 0, boardOffsetY = 0)
{
    //board mounts stands
    color ("red") 
    {
        translate([-holes_x/2 + boardOffsetX, holes_y/2 + boardOffsetY, -board_z/2]) 
        {
            cylinder(d = 5, h = 7);
            cylinder(h = 2, r1 = 3.5, r2 = 2, center = false);
        }
        translate([holes_x/2 + boardOffsetX, -holes_y/2 + boardOffsetY, -board_z/2]) 
        {
            cylinder(d = 5, h = 7);
            cylinder(h = 2, r1 = 3.5, r2 = 2, center = false);
        }
        translate([holes_x/2 + boardOffsetX, holes_y/2 + boardOffsetY, -board_z/2])
        {
            cylinder(d = 5, h = 7);
            cylinder(h = 2, r1 = 3.5, r2 = 2, center = false);
        }
        translate([-holes_x/2 + boardOffsetX, -holes_y/2 + boardOffsetY, -board_z/2])
        {
            cylinder(d = 5, h = 7); 
            cylinder(h = 2, r1 = 3.5, r2 = 2, center = false);
        }
    } 
}

module boardStandsTips(boardOffsetX = 0, boardOffsetY = 0)
{
    //board mounts tips
    color ("yellow") 
    {
        translate([holes_x/2 + boardOffsetX, holes_y/2 + boardOffsetY, -board_z/2]) cylinder(d = 3, h = 10);
        translate([-holes_x/2 + boardOffsetX, -holes_y/2 + boardOffsetY, -board_z/2]) cylinder(d = 3, h = 10);
        translate([holes_x/2 + boardOffsetX, -holes_y/2 + boardOffsetY, -board_z/2]) cylinder(d = 3, h = 10);
        translate([-holes_x/2 + boardOffsetX, holes_y/2 + boardOffsetY, -board_z/2]) cylinder(d = 3, h = 10);
    }
}

module rcube (size, rfillet=1, center=false) 
{ 
    sx = size[0] - rfillet*2;
    sy = size[1] - rfillet*2;
    sz = size[2] - rfillet*2;
    
    tx = center ? -size[0]/2 + rfillet : rfillet;
    ty = center ? -size[1]/2 + rfillet : rfillet;
    tz = center ? -size[2]/2 + rfillet : rfillet;

    translate([tx, ty, tz]) hull()
    {        
        translate([ 0, 0, 0 ]) sphere (r = rfillet);
        translate([sx, 0, 0 ]) sphere (r = rfillet);
        translate([ 0,sy, 0 ]) sphere (r = rfillet);
        translate([sx,sy, 0 ]) sphere (r = rfillet);
        translate([ 0, 0,sz ]) sphere (r = rfillet);
        translate([sx, 0,sz ]) sphere (r = rfillet);   
        translate([ 0,sy,sz ]) sphere (r = rfillet);
        translate([sx,sy,sz ]) sphere (r = rfillet);                
    }
}

module logo ()
{
    mirror([1,0,0]) 
    translate([-15,0,-board_z/2-thickness])
    {
            // convexity is needed for correct preview
            // since characters can be highly concave
            linear_extrude(height=2.5, convexity=50)
                text("E.L.T.", 
                    size=3,
                    font="Bitstream Vera Sans:style=Bold",
                    halign="center",
                    valign="center");
    }
}