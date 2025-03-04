float angle = 0; //initial angle
float radius= 200; //radius of orbit
//Inspired by wassily kandinsky, circles in a circle, 1923 
void setup(){
  size(500, 500);
  rectMode(CENTER);
  
  
}

void draw() {
  background(247, 241, 220);
  noStroke();
  fill(152, 255, 152);
  circle(height/2, width/2, 100); 
  
  fill(242, 220, 136);
  triangle(300, 100, 100, 200, 200, 300);
  
  pushMatrix();
    translate(height/2, width/2);
    
    rotate(angle);
    translate(radius, 0); 
    
    fill(0); //light blue
    ellipse(0, 0, 30, 30);
    
   popMatrix();
   
   angle += 0.009;
   
   
 
}
  
