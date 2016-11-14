// Mount for  the motor with a shroud for the fan blade

$fn=80;  //20 for development, 80 for printing
delta=0.01;

Blade_Diameter=120;
Blade_Clearance=2;
Motor_Diameter=15.75;
Hub_Body_Thickness=2;
Hub_Body_Diameter=Motor_Diameter+2*Hub_Body_Thickness;
Block_Body=Blade_Diameter+Blade_Clearance+Hub_Body_Thickness;
Block_Body_Height = 50;
Spoke_Diameter = 5;

module motor() {
    intersection() {
        translate([-11.75/2,-20,-3]) cube([11.75,40,60]); // flats on the sides of the body
        union() {
            cylinder(d=Motor_Diameter, h=26.5); // main body
            translate([0,0,-2]) {
                cylinder(d=6, h=30); // bearings
                cylinder(d=1.5, h=40.65);   // shaft
            }
            translate([0,0,33.65]) cylinder(d=3.87, h=5); // gear
        }
    }
    // Add a clearance for the two wires
    translate([0,6.5,-19]) cylinder(d=3, h=20);
    translate([0,-6.5,-19]) cylinder(d=3, h=20);
}



difference() {
// central hub
translate([0,0,-Spoke_Diameter/2]) cylinder(d=Hub_Body_Diameter, h=25);
// use the matrix multiply beause resize is broken
M=[     [1.01,  0,      0,  0],     // 1%
        [0,     1.01,   0,  0],
        [0,     0,      1,  1],     // move the motor up 1mm while we are at it
        [0,     0,      0,  1] ] ;
multmatrix(M)
    motor(); // make it a little fatter so it slides into the hub
}
// color("Magenta", 0.6) translate([0,0,1]) motor(); // test, put the motor into the model
//spokes
rotate([90,0,0]) 
    translate([0,0,Motor_Diameter/2+Hub_Body_Thickness/2]) 
        cylinder(d=Spoke_Diameter,h=Block_Body/2-(Motor_Diameter/2+Hub_Body_Thickness/2)-delta);
rotate([-90,0,0]) 
    translate([0,0,Motor_Diameter/2+Hub_Body_Thickness/2])
        cylinder(d=Spoke_Diameter,h=Block_Body/2-(Motor_Diameter/2+Hub_Body_Thickness/2)-delta);
rotate([0,90,0]) 
    translate([0,0,Motor_Diameter/2+Hub_Body_Thickness/2]) 
        cylinder(d=Spoke_Diameter,h=Block_Body/2-(Motor_Diameter/2+Hub_Body_Thickness/2)-delta);
rotate([0,-90,0]) 
    translate([0,0,Motor_Diameter/2+Hub_Body_Thickness/2])
        cylinder(d=Spoke_Diameter,h=Block_Body/2-(Motor_Diameter/2+Hub_Body_Thickness/2)-delta);

// the block
difference() {
    translate([0,0,Block_Body_Height/2-Spoke_Diameter/2+delta]) 
        cube([Block_Body,Block_Body,Block_Body_Height], center=true);
    translate([0,0,-Spoke_Diameter]) 
        cylinder(d=Blade_Diameter+Blade_Clearance, h=Block_Body_Height+20);
    translate([55,55,-5])
        cylinder(d=6, h=60);
    translate([55,-55,-10])
        cylinder(d=6, h=60);
    translate([-55,55,-10])
        cylinder(d=6, h=60);
    translate([-55,-55,-10])
        cylinder(d=6, h=60);
}


