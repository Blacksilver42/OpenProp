// ##################################################
// VARS
// ##################################################


// Blade Mount
$fn=200;
delta = 0.01;
Gear_Diameter = 3.87;   // press fit
Gear_Height = 5;
Blade_Hub_Diameter=22;
Blade_Hub_Height=Gear_Height/2+1;
Screw_440_clear=25.4*0.112;
Screw_440_thread=25.4*0.0813;


// ##################################################
// DO STUFF
// ##################################################

module blade_hub(master,SD,HD) {
    difference() {
      union() {
        cylinder(d=HD, h=Blade_Hub_Height);
        cylinder(d=HD/2, h=2*Blade_Hub_Height);
      }
      if (master) {
          // a hole to press-fit the gear
          translate([0,0,-delta])
            cylinder(d=Gear_Diameter, h=Gear_Height);

          // 3 holes for the screws
          rotate([0,0,0])
            translate([0,2*Blade_Hub_Diameter/5,-delta])
              cylinder(d=SD, h=3*Blade_Hub_Height);
          rotate([0,0,120])
            translate([0,2*Blade_Hub_Diameter/5,-delta])
              cylinder(d=SD, h=3*Blade_Hub_Height);
          rotate([0,0,-120])
            translate([0,2*Blade_Hub_Diameter/5,-delta])
              cylinder(d=SD, h=3*Blade_Hub_Height);
          }
     } 
     if (!master){
          // 3 pillars to cut out holes for the screws
          rotate([0,0,0])
            translate([0,2*Blade_Hub_Diameter/5,+delta])
              cylinder(d=SD, h=20*Blade_Hub_Height);
          rotate([0,0,120])
            translate([0,2*Blade_Hub_Diameter/5,+delta])
              cylinder(d=SD, h=20*Blade_Hub_Height);
          rotate([0,0,-120])
            translate([0,2*Blade_Hub_Diameter/5,+delta])
              cylinder(d=SD, h=20*Blade_Hub_Height);
     }
}


//blade_hub(true,Screw_440_clear, Blade_Hub_Diameter);
//blade_hub(false,Screw_440_thread, Blade_Hub_Diameter+0.5);