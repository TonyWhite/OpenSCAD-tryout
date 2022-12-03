/*
Modular prism with fake blur. Very fake blur. Extremely fake blur.
*/

prism_sides=6;
base_radius=1;
prism_height=2;
tips_height=1;
prism_twist=0;
prism_color=[0,0.5,1];
// Detail of curved surfaces: 1 face per corner
$fa=1;

module regular_polygon(order=4, r=1){
  angles=[ for (i = [0:order-1]) i*(360/order) ];
  coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
  polygon(coords);
}

module prism(fake_blur=false) {
  color(prism_color)
  render(convexity=10){
    // Top tip
    rotate([0,0,-prism_twist])
    translate([0,0,prism_height/2])
    linear_extrude(height=tips_height,center=false,convexity=0,twist=prism_twist*(tips_height/prism_height),slices=100,scale=0)
    regular_polygon(order=prism_sides, r=base_radius);

    // Prism
    if (prism_height > 0){
      linear_extrude(height=prism_height,center=true,convexity=0,twist=prism_twist,slices=100,scale=1)
      regular_polygon(order=prism_sides, r=base_radius);
    }

    // Bottom tip
    translate([0,0,-prism_height/2]) rotate([180,0,0])
    linear_extrude(height=tips_height,center=false,convexity=0,twist=prism_twist*(tips_height/prism_height),slices=100,scale=0)
    regular_polygon(order=prism_sides, r=base_radius);
  }
  
  // Extremely fake blur
  if (fake_blur==true) {
    for(index = [1:1:10]) {
      color(prism_color, alpha=0.040-index/1000) scale([index/10+1,index/10+1,index/10+1]) prism(fake_blur=false);
    }
  }
}

prism(fake_blur=true);
