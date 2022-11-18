/*
I see it in one dream
*/

if($preview){
  $fn=32;
  main();
}
else{
  $fn=32;
  //rotate([-90,0,0]) // Enable for STL export for Nextcloud
  main();
}

module main(){
  color("gray")
  scale(2)
  union(){
    // Arm parameters
    a_start=0;
    a_end=54.1043;
    a_step=1;
    r_start=0.018;
    r_end=0.0722;
    r_master=0.4165;
    
    arm(a_start, a_end, a_step, r_start, r_end, r_master);
    rotate([0,0,360/3])
    arm(a_start, a_end, a_step, r_start, r_end, r_master);
    rotate([0,0,360/3*2])
    arm(a_start, a_end, a_step, r_start, r_end, r_master);
    sphere(r=r_end);
  }
}

module arm(a_start, a_end, a_step, r_start, r_end, r_master){
  r_step = (r_end-r_start)/(a_end-a_start)*a_step;
  translate([0,r_end*2+r_start*2,0])
  rotate([0,0,a_end/2])
  rotate([0,0,180])
  translate([-r_master,0,0])
  rotate([0,0,-a_end])
  union(){
    for(angle = [a_start : a_step : a_end]){
      hull(){
        // Draw the current sphere
        rotate([0,0,angle])
        translate([r_master,0,0])
        sphere(r=(angle*r_step)+r_start);
        
        // Draw the next sphere
        angle_next=angle+a_step;
        if(a_end-angle < a_step) {angle_next=a_end;}
        rotate([0,0,angle_next])
        translate([r_master,0,0])
        sphere(r=(angle_next*r_step)+r_start);
      }
    }
  }
}
