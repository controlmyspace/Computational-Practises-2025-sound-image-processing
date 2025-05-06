Chaser[] chasers;
int chaserCount = 100;

void setup() {
  size(800, 600);

  chasers = new Chaser[chaserCount];

  for (int i = 0; i < chasers.length; i++) {
    chasers[i] = new Chaser(random(width), 1); //chasers move more synchronised vertically 
  }
}

void draw() {
  background(255);

  for (Chaser chaser : chasers) {
    chaser.update();
    chaser.display();
  }
}

void mousePressed() {
  setup();
}
