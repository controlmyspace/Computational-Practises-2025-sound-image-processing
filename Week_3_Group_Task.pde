//Inspired by wassily kandinsky, circles in a circle, 1923 

float angle = 0; //initial angle
float radius= 200; //radius of orbit

void setup(){
  size(400, 400);
  rectMode(CENTER);
  background(247, 241, 220); //black circle orbits with shadowed path
  
}

void draw() {
  //background(247, 241, 220); //orbits without path

  line(120, 80, 340, 300);
  
  line(400, 200, 10, 30);
 
  fill(152, 255, 152);
  circle(height/2, width/2, 100); 
  
  //yellow circle
  fill(255, 255, 152);
  circle(150, 50, 30);
  
  //red circle
  fill(255, 0, 0);
  circle(150, 50, 100);
  
  //black circle
  fill(0);
  circle(height/2, width/2, 50);
  
  //yellow triangle
  fill(242, 220, 136);
  triangle(100, 100, 0, 200, 200, 300);
  
  //green circle
  fill(116, 196, 139);
  triangle(0, 400, 0, 200, 200, 300);
  
  //orbiting black circle 
  pushMatrix();
    translate(height/2, width/2);
    
    rotate(angle);
    translate(radius, 0); 
    
    fill(0); 
    ellipse(0, 0, 30, 30);
    
   popMatrix();
   
   pushMatrix();
     fill(250, 229, 147);
     noStroke();
     beginShape();
     vertex(0,300);
     vertex(0,400);
     vertex(400, 10);
     vertex(400, 0);
     endShape(CLOSE);
   popMatrix();
   
    pushMatrix();
     fill(29, 184, 137);
     noStroke();
     beginShape();
     vertex(400,250);
     vertex(400, 250);
     vertex(250, 400);
     vertex(0, 400);
     endShape(CLOSE);
   popMatrix();
   
     
   
  
   
   angle += 0.009;
  
}

  
