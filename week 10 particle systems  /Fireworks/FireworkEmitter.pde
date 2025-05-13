class FireworkEmitter {
  ArrayList<Firework> fireworks = new ArrayList<Firework>();
  PVector origin;
  int count;
  int bursts;
  color col;

  FireworkEmitter(float x, float y, int count, int bursts, color col) {
    this.origin = new PVector(x, y);
    this.count = count / bursts;
    this.col = col;
    this.bursts = bursts;
  }

  void run() {
    if (bursts  > 0 ) {
      for (int i = 0; i < count; i++) {
        addFirework();
      }
      bursts--;
    }
    
    for (int i = 0; i < fireworks.size(); i++) {
      Firework f = fireworks.get(i);
      f.run();
      if (f.isDead()) {
        fireworks.remove(i);
      }
    }
  }

  void addFirework() {
    // firework begins at random point in a small circle
    // around the origin - avoids clashing trails
    float angle = degrees(random(360));
    float x = random(5, 20)*cos(angle) + this.origin.x;
    float y = random(5, 20)*sin(angle) + this.origin.y;

    Firework f = new Firework(
      x, y, this.col, this
    );
    fireworks.add(f);
  }

  void applyForce(PVector force) {
    for ( Firework f : this.fireworks) {
      f.applyForce(force);
    }
  }
}
