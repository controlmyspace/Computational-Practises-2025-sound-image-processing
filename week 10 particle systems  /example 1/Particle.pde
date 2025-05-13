class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float decay;
  
  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(random(-1,1),random(-1,1));
    acceleration = new PVector();
    lifespan = 255;
    decay = 3; //how fast particles decay 
  }

  void addForce(PVector f) {
    acceleration.add(f);
  }
  
  boolean expired() {
    return lifespan < 0;
  }
  
  void update() {
    lifespan -= decay; //- makes particles dissapear & fade out, whilst + they increase & stay bold 
    
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);
  }

  void display() {
    pushMatrix();
    
    translate(position.x, position.y);

    stroke(0,lifespan); // stroke fades as lifespan passes 
    fill(128,lifespan); //fill fades as lifespan passes 

    circle(0, 0, 10);

    popMatrix();
  }
}
