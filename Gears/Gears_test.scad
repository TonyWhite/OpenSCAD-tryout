// Hello
use <gears.scad>


/* Preferences
tooths: number of tooths and diameter of gear
thickness: thickness of the gear
hole: round hole in the center of the gear
hole_cross: Cross-shaped hole in the center of the gear (use with hole parameter)
*/
module flat_gear(tooths=6,thickness=1,hole=0,hole_cross=0){
  difference(){
    translate([0,0,-thickness/2])
    spur_gear (modul=1, tooth_number=tooths, width=thickness, bore=hole, pressure_angle=20, helix_angle=0, optimized=false);
    cube([hole_cross,hole,thickness+1],center=true);
    cube([hole,hole_cross,thickness+1],center=true);
  }
}

module pivot(){
  union()
  {
    cylinder(h=2,r=1,center=true,$fn=100);
    translate([0,0,1.5]) cylinder(h=1,r=2,center=true,$fn=100);
    translate([0,0,-1.5]) cylinder(h=1,r=2,center=true,$fn=100);
  }
}

color("silver")
flat_gear(10,2,2,0);
pivot();
    
color("red")
translate([10/2+30/2,0,0]) // Approach 30 toots gear with 30 tooths gear
rotate([0,0,(360/30)/2]) // Align tooths
flat_gear (30,2,2,0);

translate([10/2+30/2,0,0])
pivot();