class Firework {
  PVector position;
  PVector velocity;
  PVector acceleration;
  color col;
  float lifespan;
  FireworkEmitter parent;

  Firework(float x, 
    float y, 
    color c, 
    FireworkEmitter parent
    ) {
    this.position = new PVector(x, y);
    this.velocity = PVector.sub(this.position, parent.origin).normalize().mult(3);
    this.acceleration = new PVector(0, 0);

    this.col = c;
    this.lifespan = 255;
    this.parent = parent;
  }

  void run() {
    this.update();
    this.display();
  }

  void update() {
    // euler integration
    this.velocity.add(this.acceleration);
    this.position.add(this.velocity);

    // reset acceleration
    this.acceleration.mult(0);

    // decay
    this.lifespan -= 2;
  }

  void display() {
    noStroke();
    fill(this.alphaColor());

    pushMatrix();
    translate(position.x-5, position.y-15);
    rotate(this.velocity.heading() + PI/2);

    rect(0, 0, 3, random(10,15));

    //circle(0, 0, 5);

    popMatrix();
  }

  void applyForce(PVector f) {
    this.acceleration.add(f);
  }

  color alphaColor() {
    float r = red(this.col);
    float g = green(this.col);
    float b = blue(this.col);
    float a = this.lifespan;

    return color(r, g, b, a);
  }

  boolean isDead() {
    return lifespan < 0.0;
  }
}
