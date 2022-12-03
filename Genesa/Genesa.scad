/*
I feel like drawing an ornament
*/

//╭─────────────────╮
//│ PERSONALIZATION │
//╰─────────────────╯
unit=1;                   // The scale of the genesa
ring_color="#AAAAAAFF";   // The color of the ring
ring_thickness=0.01;      // The thickness of the ring
ring_height=0.1;          // The height of the cylinder
pin_color="#555555FF";    // Color of pins
pin_protrude=3;           // The protrusion of the pin
show_holes=false;         // Show holes?
show_pins=false;          // Show pins?

//╭─────────────╮
//│ DRAW GENESA │
//╰─────────────╯
if($preview){
  $fn=100;
  genesa();
}
else{
  $fn=360;
  //rotate([-90,0,0]) // Enable if you want to save STL on Nextcloud
  genesa();
}

module genesa(){
  scale(unit){
    union(){
      tri_angle=54.7355; // Achieved empirically.

      // Ring Front Down "\"
      rotate([0,tri_angle,0]) ring();

      // Ring Front Up "/"
      rotate([0,-tri_angle,0]) ring();

      // Ring Left Down"\"
      rotate([tri_angle,0,0]) rotate([0,0,30]) ring();

      // Ring Left Up "/"
      rotate([-tri_angle,0,0]) rotate([0,0,30]) ring();
    }
  }
}

module ring(){
  color(ring_color)
  difference(){
    cylinder(h=ring_height, r=1, center=true);
    cylinder(h=ring_height*2, r=1-ring_thickness, center=true);
    if(show_holes) pins();
  }
  if(show_pins) pins();
}

module pins(){
  pin_height=(ring_thickness*1.2)*pin_protrude;
  color(pin_color)
  for(angle = [0 : 60 : 360]){
    rotate([0,0,angle])
    translate([0,(ring_thickness/2)-1,0])
    rotate([90,0,0])
    cylinder(h=pin_height, r=0.025, center=true);
  }
}
