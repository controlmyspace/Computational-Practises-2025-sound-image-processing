PVector position;
PVector velocity;
PVector acceleration;
float bounciness = 0.8;

int radius = 20;

void setup() {
  size(800, 600);
  
  position = new PVector(50,50);
  velocity = new PVector(3,2);
  acceleration = new PVector(0,0.5);
}

void draw() {
  background(50);
  
  // move the ball
  
  velocity.add(acceleration);
  position.add(velocity);
  
  // bounce it if it goes off screen
  if(position.y+radius > height) {
    velocity.x *= bounciness;
    velocity.y *= -bounciness;
    position.y = height-radius;
  }
 
  circle(position.x,position.y,radius*2);
}
void keyPressed() {
  if (key == ' ') {  // spacebar resets ball
    //position = new PVector(0, 0); //from origin, but sometimes bounces off screen
    position= new PVector(width/2, height/2);
    velocity = new PVector(random(-5,5), random(-5,5));
  }
}
