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
    else if (apothem!=undef) 2*apothem*TAN(PI/edges)
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

/* Trigonometry and radians */
function RAD_TO_DEG(radians=undef) = radians * (180/PI);
function SIN(n=undef) = sin(RAD_TO_DEG(n));
function COS(n=undef) = cos(RAD_TO_DEG(n));
function TAN(n=undef) = tan(RAD_TO_DEG(n));
function ACOS(n=undef) = acos(RAD_TO_DEG(n));
function ASIN(n=undef) = asin(RAD_TO_DEG(n));
function ATAN(n=undef) = atan(RAD_TO_DEG(n));
function ATAN2(n=undef) = atan2(RAD_TO_DEG(n));


color("#ffff99")
translate([0,0,radious])
union() {
  // Bottom
  rotate([0,180,0])
  linear_extrude(height=radious,scale=0)
  regular_polygon(order=edges,r=radious);

  // Top
  hull() {
    // Big hexagon
    polyhedron(points=regular_polygon_coords(order=edges,r=radious),faces=[[0,1,2,3,4,5]]);
    
    // Little hexagon
    apothem = 2 * radious * SIN(PI/edges);
    edge = 2 * apothem * TAN(PI/edges);
    little_radious = (edge / (2 * SIN(PI/edges))) / 2;
    translate([0,0,radious/2])
    rotate([0,0,360/12])
    polyhedron(points=regular_polygon_coords(order=edges,r=little_radious),faces=[[0,1,2,3,4,5]]);
  }
}