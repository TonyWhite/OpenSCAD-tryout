$fn=100;

module half_top(){
  translate([0,0,10])
  difference(){
    scale([10,5,10]) sphere(d=1);
    translate([0,0,-2.5]) cube([10+1,5+1,5],center=true);
  }
}

module half_bottom(){
  translate([0,0,10])    
  scale([1,1,2])
  difference(){
    scale([10,5,10]) sphere(d=1);
    translate([0,0,2.5]) cube([10+1,5+1,5],center=true);
  }
}

module core(){
  render()
  hull(){
    rotate([0,-20,0]) half_bottom();
    rotate([0,20,0]) half_bottom();
  }
}

module top(){
  rotate([0,-20,0]) half_top();
  rotate([0,20,0]) half_top();
}

module heart(){
  color("red")
  render(convexity=5){
    // Top-left
    hull(){
      rotate([0,-20,0]) half_top();
      core();
    }

    // Top-right
    hull(){
      rotate([0,20,0]) half_top();
      core();
    }

    // Bottom
    hull(){
      scale([2,1,2]) sphere(d=1);;
      core();
    }
  }
}
heart();