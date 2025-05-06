class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  color c;
  float mass;
  int radius = 2;

  Ball(float x, float y, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0,0);

    mass = m;
    c = color(random(255),random(255),random(255));
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    checkEdges();
    acceleration.mult(0);
  }

  void display() {
    strokeWeight(2);
    stroke(64);
    fill(c);
    circle(position.x, position.y, mass*radius*2);
  }

  void checkEdges() {
    if ((position.x+radius > width) || (position.x-radius < 0)) {
      velocity.x = velocity.x * -1;
      if (position.x+radius > width) {
        position.x = width-radius;
      } else {
        position.x = radius;
      }
    }
    if ((position.y+radius > height) || (position.y-radius < 0)) {
      velocity.y = velocity.y * -1;
      if (position.y+radius > height) {
        position.y = height-radius;
      } else {
        position.y = radius;
      }
    }
  }
}
