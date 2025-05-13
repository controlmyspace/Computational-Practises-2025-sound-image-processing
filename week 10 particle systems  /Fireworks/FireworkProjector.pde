class FireworkProjector {
  PVector position;
  PVector velocity;
  PVector acceleration;

  float maxAcceleration = 0.2;
  float maxSpeed = 10;

  color col;
  boolean alive;

  FireworkProjector(float x, float y, color c) {
    this.position = new PVector(x, y);
    this.velocity = new PVector();
    this.acceleration = new PVector();

    // projectile flies up fast, and possibly a bit to either side
    this.velocity = new PVector (random(-1, 1), random(-9, -6));

    this.col = c;
    this.alive = true;
  }

  void applyForce(PVector f) {
    this.acceleration.add(f);
  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration).limit(maxSpeed);
    position.add(velocity);

    // explode as projectile starts to fall to earth,
    // ie, top of its arc
    if (velocity.y > 0 && alive) {
      explode();
    }

    acceleration.mult(0);
  }

  void display() {
    if (!this.alive) {
      return;
    }
    pushMatrix();
    translate(position.x, position.y);
    fill(col);
    circle(0, 0, 5);
    popMatrix();
  }

  void explode() {
    // make an emitter at the point of explosion
    // end this projector
    FireworkEmitter emitter = new FireworkEmitter(
      position.x, 
      position.y, 
      int(random(60, 180)), 
      int(random(1,15)),
      col
     );
    emitters.add(emitter);
    this.alive = false;
  }
}
