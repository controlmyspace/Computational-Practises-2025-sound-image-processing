// click mouse to trigger particle system
// hold w to add wind
// press r to reset sketch

PVector gravity, wind;

ArrayList<ParticleSystem> systems;

void setup() {
  size(960, 540);

  gravity = new PVector(0, 0.05);
  wind = new PVector(-0.2, 0);

  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(255);

  for (ParticleSystem ps : systems) {
    ps.addForce(gravity);
    ps.update();
    ps.display();
  }
}

void mousePressed() {
  systems.add(new ParticleSystem(mouseX, mouseY,60));
}

void keyPressed() {
  if (key == 'r') {
    setup();
  }
  if (key == 'w') {
    for (ParticleSystem ps : systems) {
      ps.addForce(wind);
    }
  }
}
