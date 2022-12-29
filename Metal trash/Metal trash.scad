/*
Metal trash

Too much work just for an icon

Goals I had to overcome:
- Calculate the path of the spiral (myself)
- Extruding a geometry along a path (third-party library)
- Manage quality to avoid long rendering times (a little, but important work)
*/
use <../libs/path_extrude.scad>

// Configuration
trash_bottom_diameter=240;
trash_bottom_radius=trash_bottom_diameter/2;
trash_bottom_thickness=2;
trash_bottom_height=20;
trash_top_diameter=300;
trash_top_radius=trash_top_diameter/2;
trash_top_thickness=4;
trash_height=350;
threads=50;
thread_thickness=1;
intermediate_diameter=((trash_top_diameter-trash_bottom_diameter)*trash_bottom_height)/trash_height+trash_bottom_diameter;
trash_color=[0.8,0.8,0.8];

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

// Render a single thread to speed up preview
module trash_thread(clockwise=true){
  render(convexity=10){
    spiral(
      radius=(intermediate_diameter-trash_bottom_thickness)/2,
      radius_min=(trash_top_diameter-trash_bottom_thickness)/2,
      height=trash_height-trash_bottom_height,
      thread_diameter=thread_thickness,
      clockwise=clockwise,
      degrees=90*2,
      $fn=50
    );
  }
}

// Bottom
color(trash_color)
difference(){
  cylinder(d1=trash_bottom_diameter,d2=intermediate_diameter,h=trash_bottom_height,$fn=100);
  translate([0,0,trash_bottom_thickness])
  cylinder(d1=trash_bottom_diameter-trash_bottom_thickness*2,d2=intermediate_diameter-trash_bottom_thickness*2,h=trash_bottom_height,$fn=100);
}

// Threads
color(trash_color)
translate([0,0,trash_bottom_height])
for (i = [0:threads-1]) {
  rotate([0,0,i*(360/threads)])
  trash_thread(true);
  rotate([0,0,i*(360/threads)])
  trash_thread(false);
}

// Top
color(trash_color)
translate([0,0,trash_height])
rotate_extrude(angle=360, convexity=10, $fn=100)
translate([trash_top_radius-thread_thickness*2,0,0])
circle(d=trash_top_thickness, $fn=50);
