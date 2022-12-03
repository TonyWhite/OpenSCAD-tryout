/*
Superman (work in progress)
*/

use <unicode.timesu.ttf>

module shape_diamond(){
  translate([0,-3.1,0])
  polygon([[0,0],[4,4],[3,5],[-3,5],[-4,4]]);
}

module shape_red(){
  union(){
    difference(){
      shape_diamond();
      offset(delta=-0.25)
      shape_diamond();
    }
    translate([0.15,0.05,0])
    scale([1,0.55,1])
    text("S", size=6.1, halign="center", valign="center", font="Times");
  }
}


color("red") shape_red();

color("yellow")
render(convexity=10)
difference(){
  shape_diamond();
  shape_red();
}