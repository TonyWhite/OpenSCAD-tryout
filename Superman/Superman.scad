/*
Superman logo

Iport DXF with layer
*/

module logo_foreground(){
  color("red")
  render(convexity=5){
    linear_extrude(5,convexity=5,scale=0.95)
    import("Superman-logo.dxf", convexity=5);
  }
}


module logo_background(){
  color("yellow")
  render(convexity=5){
    difference(){
      linear_extrude(5/2,convexity=5)
      scale([0.92,0.92,1])
      import("Superman-logo.dxf",layer="Extern");
      logo_foreground();
    }
  }
}

$fn=100;
rotate([90,0,0]){
  // Front
  logo_foreground();
  logo_background();
  // Back
  rotate([0,180,0]) {
    logo_foreground();
    logo_background();
  }
}