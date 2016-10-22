// Works in openSCAD 2016.09.18 -- Last updated Oct 2, 2016



// ##################################################
// GLOBALS
// ##################################################

//all units are in mm.
I = 25.4; // <inches>/I

NUMBER_BLADES   = 3;
PITCH_ANGLE     = 20;
BLADE_LEN       = 100;
PROP_DIAMETER   = 115;   // whole thing
SHAFT_DIAMETER  = 1.5;
BLADE_THICKNESS = 4;     // at thickest point
BLADE_WIDTH     = 20;

// No touchie.
BLADE_LENGTH    = PROP_DIAMETER/2 - SHAFT_DIAMETER/2;
HUB_DIAMETER    = BLADE_WIDTH/1.5;
HUB_THICKNESS   = sqrt(BLADE_WIDTH*BLADE_WIDTH + pow(BLADE_THICKNESS,2));
DELTA           = 0.01;

// ##################################################
// PROTOTYPES
// ##################################################


module blade();
module hub();
module main();
	
	
// ##################################################
// DO THINGS
// ##################################################


main();


// ##################################################
// FUNCTIONS
// ##################################################


module blade() {
	  color("yellow")
    intersection() {
        translate([0,0,-HUB_THICKNESS])
					cylinder(d=PROP_DIAMETER, h=HUB_THICKNESS*2);
        union () {
            translate([0,0,BLADE_THICKNESS/2]) rotate([0,90,0]) {
                cylinder(d=BLADE_THICKNESS, h=BLADE_LENGTH);
            }

            difference() {
						echo(str("Fixing zero-width solid with DELTA=",DELTA,"..."));
            translate([DELTA,0,0]){
							cube([BLADE_LENGTH-2*DELTA, BLADE_WIDTH, BLADE_THICKNESS]);
						}
            rotate([atan(-BLADE_THICKNESS/BLADE_WIDTH),0,0])
							translate([0,0,BLADE_THICKNESS])
								cube([BLADE_LENGTH, BLADE_WIDTH, 2*BLADE_THICKNESS]);
            }
        }
    }
}


module hub(){
	color("yellow")
	translate([0,0,0]) {
		difference(){
			cylinder(h=HUB_THICKNESS,r=HUB_DIAMETER); //hub
			translate([0,0,-HUB_THICKNESS/2]){ //hole
				cylinder(h=2*HUB_THICKNESS, d=SHAFT_DIAMETER);
			}
		}
	}
}


module main(){
	translate([-HUB_DIAMETER+5,5,HUB_THICKNESS-DELTA]){
		color("red"){
			linear_extrude(height=1)
				text("CK + LK",size=3); 
		}
	}
	hub();
	for(i=[0:NUMBER_BLADES-1]){
		translate([0,0,HUB_THICKNESS/2]){
			rotate([0,0,(360/NUMBER_BLADES)*i]){
				translate([0,-BLADE_WIDTH/2,0]){
					rotate([PITCH_ANGLE, 0, 0]){
						blade();
					}
				}
			}
		}
	}
}
