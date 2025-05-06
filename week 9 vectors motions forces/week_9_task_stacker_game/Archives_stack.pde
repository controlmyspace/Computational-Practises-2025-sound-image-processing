PImage bg;
int y;

void setup() {
  size(612, 408);//must be set to same dimension as image
  bg = loadImage("museum.jpg");
}

void draw() {
  background(bg);
}

class Archives {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  color c;
  float mass;
  int radius = 2;

  Archives(float x, float y, float m, float n) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);

    mass = m;
    c = color(random(255),random(255),random(255));
  }

 void display() { //archives themselves 
    strokeWeight(0);
    stroke(1);
    fill(c);
    rect(position.x, position.y, 10, 10);
  }
