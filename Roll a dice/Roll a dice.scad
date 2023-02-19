/*
Random number generator with a dice.
An expensive (CPU, memory and overheating) method to roll a dice.
Press F5 to roll the dice (without animation).
You can also customize the dice with size, bevel and colors.
*/

dice_size=10;
dice_dot=2;
dice_color=[0.5,0,0];
numbers_color=[0,0,0];

module dice_numbers(){
  // 1 hole: +Z
  translate([0,0,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  // 5 holes: -Y
  rotate([90,0,0]) translate([-dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([90,0,0]) translate([dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([90,0,0]) translate([0,0,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([90,0,0]) translate([-dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([90,0,0]) translate([dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  // 6 holes: -Z
  rotate([180,0,0]) translate([-dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([180,0,0]) translate([0,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([180,0,0]) translate([dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([180,0,0]) translate([-dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([180,0,0]) translate([0,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([180,0,0]) translate([dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  // 4 holes: +X
  rotate([0,90,0]) translate([-dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([0,90,0]) translate([dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([0,90,0]) translate([-dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([0,90,0]) translate([dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  // 3 holes: -X
  rotate([0,-90,0]) translate([-dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([0,-90,0]) translate([0,0,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([0,-90,0]) translate([dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  // 2 holes: +Y
  rotate([-90,0,0]) translate([-dice_dot*1.2,dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
  rotate([-90,0,0]) translate([dice_dot*1.2,-dice_dot*1.2,dice_size/2-dice_dot/8]) cylinder(h=dice_dot/8,d=dice_dot);
}

module dice(){
  color(dice_color)
  render(convexity=5)
  difference(){
    intersection(){
      cube(dice_size,center=true);
      sphere(d=dice_size*1.4);
    }
    dice_numbers();
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