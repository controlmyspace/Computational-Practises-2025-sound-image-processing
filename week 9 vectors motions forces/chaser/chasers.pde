Chaser[] chasers;
int chaserCount = 10;

void setup() {
  size(800, 600);

  chasers = new Chaser[chaserCount];

  for (int i = 0; i < chasers.length; i++) {
    chasers[i] = new Chaser(random(width), random(height));
  }
}

void draw() {
  background(128);

  for (Chaser chaser : chasers) {
    chaser.update();
    chaser.display();
  }
}

void mousePressed() {
  setup();
}
