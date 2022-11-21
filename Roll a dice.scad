/*
Random number generator with a dice.
An expensive (CPU, memory and overheating) method to roll a dice.
Press F5 to roll the dice (without animation).
You can also customize the dice with size, bevel and colors.
*/

dice_size=10;
dice_bevel=2;
dice_color=[0.5,0,0];
numbers_color=[0,0,0];

module dice_edge(){
  render(convexity=10){
    hull(){
      translate([(dice_size-dice_bevel)/2,0,0]) sphere(d=dice_bevel);
      translate([-(dice_size-dice_bevel)/2,0,0]) sphere(d=dice_bevel);
    }
  }
}

module dice_numbers(){
  // 1 hole: +Z
  translate([0,0,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  // 5 holes: -Y
  rotate([90,0,0]) translate([-dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([90,0,0]) translate([dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([90,0,0]) translate([0,0,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([90,0,0]) translate([-dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([90,0,0]) translate([dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  // 6 holes: -Z
  rotate([180,0,0]) translate([-dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([180,0,0]) translate([0,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([180,0,0]) translate([dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([180,0,0]) translate([-dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([180,0,0]) translate([0,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([180,0,0]) translate([dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  // 4 holes: +X
  rotate([0,90,0]) translate([-dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([0,90,0]) translate([dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([0,90,0]) translate([-dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([0,90,0]) translate([dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  // 3 holes: -X
  rotate([0,-90,0]) translate([-dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([0,-90,0]) translate([0,0,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([0,-90,0]) translate([dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  // 2 holes: +Y
  rotate([-90,0,0]) translate([-dice_bevel*1.2,dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
  rotate([-90,0,0]) translate([dice_bevel*1.2,-dice_bevel*1.2,dice_size/2-dice_bevel/8]) cylinder(h=dice_bevel/8,d=dice_bevel);
}

module dice(){
  color(dice_color)
  union(){
    // Top edges
    translate([0,0,(dice_size-dice_bevel)/2]){
      translate([0,(dice_size-dice_bevel)/2,0]) dice_edge();
      translate([0,-(dice_size-dice_bevel)/2,0]) dice_edge();
      rotate([0,0,90]) translate([0,(dice_size-dice_bevel)/2,0]) dice_edge();
      rotate([0,0,90]) translate([0,-(dice_size-dice_bevel)/2,0]) dice_edge();
    }
    // Bottom edges
    translate([0,0,-(dice_size-dice_bevel)/2]){
      translate([0,(dice_size-dice_bevel)/2,0]) dice_edge();
      translate([0,-(dice_size-dice_bevel)/2,0]) dice_edge();
      rotate([0,0,90]) translate([0,(dice_size-dice_bevel)/2,0]) dice_edge();
      rotate([0,0,90]) translate([0,-(dice_size-dice_bevel)/2,0]) dice_edge();
    }
    // Side edges
    translate([(dice_size-dice_bevel)/2,(dice_size-dice_bevel)/2,0]) rotate([0,90,0]) dice_edge();
    translate([(dice_size-dice_bevel)/2,-(dice_size-dice_bevel)/2,0]) rotate([0,90,0]) dice_edge();
    translate([-(dice_size-dice_bevel)/2,-(dice_size-dice_bevel)/2,0]) rotate([0,90,0]) dice_edge();
    translate([-(dice_size-dice_bevel)/2,(dice_size-dice_bevel)/2,0]) rotate([0,90,0]) dice_edge();
    
    // Faces
    render(convexity=10){
      difference(){
        union(){
          // Faces on Z
          linear_extrude(dice_size, center=true) square((dice_size-dice_bevel), center=true);
          // Faces on Y
          rotate([90,0,0]) linear_extrude(dice_size, center=true) square((dice_size-dice_bevel), center=true);
          // Faces on X
          rotate([0,90,0]) linear_extrude(dice_size, center=true) square((dice_size-dice_bevel), center=true);
        }
        
        // Holes for numbers
        dice_numbers();
      }
    }
  }
  color(numbers_color) dice_numbers();
}

module roll_dice(){
  rotate_x = round(rands(0,3,1)[0])*90;
  rotate_y = round(rands(0,3,1)[0])*90;
  rotate_z = round(rands(0,3,1)[0])*90;
  rotate([rotate_x,rotate_y,rotate_z])
  dice();
}

$fn=100;
roll_dice();