/* [Diamond] */

edges = 6;
radious = 1;

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
  Give the length of the edge of a regular polygon
  Requires at least two parameters
  TO DO
*/
function polygon_edge(edges=undef, radious=undef, apothem=undef, /*edge=undef,*/ perimeter=undef, area=undef) = [
  if (edges!=undef)
    if (radious!=undef) undef
    else if (apothem!=undef) 2*apothem*tan(PI/edges)
    else if (perimeter!=undef) undef
    else if (area!=undef) undef
  else if(radious!=undef)
    if (apothem!=undef) undef
    else if (perimeter!=undef) undef
    else if (area!=undef) undef
  else if(apothem!=undef)
    if (perimeter!=undef) undef
    else if (area!=undef) undef
  else if(perimeter!=undef)
    if (area!=undef) undef
];

// SOME WARNING AND UNDEFINED RESULTS
function rad_to_deg(rad=undef) = [
  rad * (180/PI)
];

function sin_RAD(n=undef) = sin(rad_to_deg(n));

color("#ffff99")
translate([0,0,radious])
union() {
  // Bottom
  rotate([0,180,0])
  linear_extrude(height=1,scale=0)
  regular_polygon(order=edges,r=radious);

  // Top
  hull() {
    // Big hexagon
    polyhedron(points=regular_polygon_coords(order=edges,r=radious),faces=[[0,1,2,3,4,5]]);
    
    // Little hexagon
    apothem = 2 * radious * sin_RAD(PI/edges);
    echo(apothem);
    edge = 2 * apothem * tan(PI/edges);
    little_radious = edge / (2 * sin(PI/edges));
    translate([0,0,0.5])
    rotate([0,0,360/12])
    polyhedron(points=regular_polygon_coords(order=edges,r=little_radious),faces=[[0,1,2,3,4,5]]);
  }
}