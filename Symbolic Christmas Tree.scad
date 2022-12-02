/*
Symbolic Christmas Tree
*/
use <path_extrude.scad>

// Configuration
tree_base=10;
tree_height=30;
tree_turns=4;
star_height=3;

/*
Names of coordinate variables for the star
T: Top
B: Bottom
L: Left
R: Right
C: Center
*/
penthagon=regular_polygon_coords(order=5, r=star_height);
star_TR=penthagon[0];
star_TC=penthagon[1];
star_TL=penthagon[2];
star_BL=penthagon[3];
star_BR=penthagon[4];
big_triangle_TR=[star_TR, star_TL, star_BL];
big_triangle_TC=[star_TC, star_BL, star_BR];
big_triangle_TL=[star_TL, star_BR, star_TR];
big_triangle_BL=[star_BL, star_TR, star_TC];
big_triangle_BR=[star_BR, star_TC, star_TL];

// The star
color("yellow")
translate([0,0,tree_height+star_height])
rotate([90,0,0]) star();

// The Tree
color("green")
spiral(radius=tree_base, height=tree_height, degrees=360*tree_turns, thread_diameter=1, thread_fn=50, thread_close=true, clockwise=true, $fn=100);

module star(){
  linear_extrude(0.5, center=false, scale=0) star_2D();
  rotate([0,180,0])
  linear_extrude(0.5, center=false, scale=0) star_2D();
}

module star_2D(){
  rotate([0,0,360/(5*4)]) // Put the head of the star at the top
  union(){
    star_center();
    star_tip();
    rotate([0,0,360/5]) star_tip();
    rotate([0,0,360/5*2]) star_tip();
    rotate([0,0,360/5*3]) star_tip();
    rotate([0,0,360/5*4]) star_tip();
  }
}

module star_tip(){
  render()
  difference(){
    polygon(big_triangle_TR);
    polygon([star_TC, star_BR, star_BL, star_TL]);
  }
}

// The center of the star
module star_center(){
  intersection(){
    polygon(big_triangle_TR);
    polygon(big_triangle_TC);
    polygon(big_triangle_TL);
    polygon(big_triangle_BL);
    polygon(big_triangle_BR);
  }
}

// Draw a regular polygon
module regular_polygon(order=4, r=1){
  angles=[ for (i = [0:order-1]) i*(360/order) ];
  coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
  polygon(coords);
}

// Give the coordinates of a regular polygon
function regular_polygon_coords(order=4, r=1) =
  [ for (th=[ for (i = [0:order-1]) i*(360/order) ]) [r*cos(th), r*sin(th)] ];

/*
Make a spiral
radius: the max radius
radius_min: the minimum radius (default 0)
height: do you want a thread around a cone?
degrees: default 1440 (4 turns)
thread_diameter: is self-explanatory
thread_fn: number of fragments in 360 degrees for thread
thread_close: close the thread with a sphere (default false)
clockwise: spiral direction (default true)
$fn: number of fragments in 360 degrees
*/
module spiral(radius, radius_min=0, height=0, degrees=360*4, thread_diameter, thread_fn=8, thread_close=false, clockwise=true, $fn=10){
  // Manage input values
  degrees=abs(degrees);
  clockwise_direction = clockwise ? -1 : 1;
  $fn=max($fn, 3);
  
  turns=degrees/360; // Calculate turns (may not be an integer)
  steps=ceil(turns*$fn); // Calculate number of steps (must be an integer)
  
  // Define the angles
  angles=[
    for (i = [0:steps-1])
      clockwise_direction*i*(360/$fn)
  ];
  
  // Define the radii
  radii =
    radius > radius_min ?
    [
      for (i = radius; i >= radius_min; i = i - (radius-radius_min)/steps)
        i
    ]
    :
      radius < radius_min ?
        [
          for (i = radius; i <= radius_min; i = i + (radius_min-radius)/steps)
            i
        ]
      :
        [
          for (i = [0:steps])
            radius
        ]
    ;
  
  // Define coordinates
  coords=[
    for (i = [0:steps-1])
      [radii[i]*cos(angles[i]), radii[i]*sin(angles[i]), i*(height/(steps-1)) ]
  ];
  
  // Draw with path_extrude
  path_extrude(coords, regular_polygon_coords(order=thread_fn, r=thread_diameter/2));
  
  // Close the thread with a sphere
  if (thread_close) {
    translate(coords[0])
    sphere(d=thread_diameter, $fn=thread_fn);
    translate(coords[steps-1])
    sphere(d=thread_diameter, $fn=thread_fn);
  }
}