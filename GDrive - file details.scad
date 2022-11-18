/*
Original image from Google Drive (file details)
*/

$fn=100;
green=1;
blue=2;
red=3;
yellow=3.3;

module big_cut(){
  translate([-yellow/2,-yellow,0])
  cube(yellow);
}

module big_slice(){
  translate([0,-yellow,-yellow/2])
  cube(yellow);
}

module little_slice(){
  linear_extrude(height=yellow,center=true)
  polygon(points=[[0,0],[yellow,0],[yellow,-(yellow*2)]]);
}

module green_layer(){
  color("green")
  sphere(d=green);
}

module blue_layer(){
  color("blue")
  render(convexity=10)
  difference(){
    sphere(d=blue);
    sphere(d=green);
    big_cut();
  }
}

module red_layer(){
  color("red")
  render(convexity=10)
  difference(){
    sphere(d=red);
    sphere(d=blue);
    big_cut();
    little_slice();
  }
}

module yellow_layer(){
  color("yellow")
  render(convexity=10)
  difference(){
    sphere(d=yellow);
    sphere(d=red);
    big_cut();
    big_slice();
  }
}

// The object
translate([0,0,yellow]){
  green_layer();
  blue_layer();
  red_layer();
  yellow_layer();
}

// The shadow
color("lightgray")
linear_extrude(height=0.0001,center=true,convexity=10)
projection(cut=true)
union(){
  cylinder(d=blue,h=1,center=true);
  difference(){
    cylinder(d=red,h=1,center=true);
    little_slice();
  }
  difference(){
    cylinder(d=yellow,h=1,center=true);
    big_slice();
  }
}
