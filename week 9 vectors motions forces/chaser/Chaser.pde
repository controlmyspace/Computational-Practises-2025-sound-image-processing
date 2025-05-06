class Chaser {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float heading;
  
  color col;
  
  Chaser(float x, float y) {
    position = new PVector(x,y);
    velocity = new PVector();
    acceleration = new PVector();
    col = color(random(255),random(255),random(255));
  }
  
  void update() {
    PVector mouse = new PVector(mouseX,mouseY);
    
    PVector direction = PVector.sub(mouse,position);
    
    direction.normalize(); //rescaling vector to length of 1 
    direction.mult(0.2); //always have this length
    
    acceleration = direction; //speed 
    
    
    velocity.add(acceleration);
    velocity.limit(10); //cut off value
    
    // setting heading to velocity gives us something
    // a little like 'steering';
    // setting heading to acceleration gives us something
    // less realistic but snappier.
    heading = velocity.heading() + PI/2;
    
    position.add(velocity);
  }
  
  void display() {
    stroke(64);
    strokeWeight(2);
    fill(col);

    pushMatrix();
    
    translate(position.x,position.y);
    rotate(heading);
    
    // asteroids ship
    beginShape();
    vertex(0,-20);
    vertex(15,10);
    vertex(0,0);
    vertex(-15,10);   
    endShape(CLOSE);
    
    popMatrix();
  }
}
