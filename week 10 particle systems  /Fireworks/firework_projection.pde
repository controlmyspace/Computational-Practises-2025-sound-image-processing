// Fireworks with Projectors:
//
// click to launch a firework at that X point.
// Projector will be spawned and shoot up
// At top of flight, projector will explode:
//   that is to say, disappear, and leave an Emitter
//   in its wake.

ArrayList<FireworkEmitter> emitters = new ArrayList<FireworkEmitter>();
ArrayList<FireworkProjector> projectors = new ArrayList<FireworkProjector>();

PVector gravity;

int fireworkCount = 60;

void setup() {
  size(800, 800);

  gravity = new PVector(0, 0.05);
}

void draw() {
  background(0);

  for (int i = 0; i < projectors.size(); i++) {
    if (!projectors.get(i).alive) {
      projectors.remove(i);
    }
  }

  for (FireworkProjector p : projectors) {
    p.applyForce(gravity);
    p.run();
  }

  for (FireworkEmitter e : emitters) {
    e.applyForce(gravity);
    e.run();
  }
}

void mousePressed() {
  // fireworks should be bright colours, so lowest RGB value is
  // #888888 and we go up from there.
  color col = color(random(128, 255), random(128, 255), random(128, 255));
  FireworkProjector projector = new FireworkProjector(mouseX, height, col);
  projectors.add(projector);
}
