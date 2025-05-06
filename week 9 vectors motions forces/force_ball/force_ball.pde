Ball[] balls;
int ballCount = 10;

PVector gravity;
PVector wind;

void setup() {
  size(800, 400);
  balls = new Ball[ballCount];
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(random(width), 100, random(1,20));
  }

  gravity = new PVector(0, 0.5);
  wind = new PVector(0.04, 0);
}

void draw() {
  background(230);

  for (Ball b : balls) {
    PVector g = gravity.copy().mult(b.mass);
    b.applyForce(g);
    b.applyForce(wind);
    if (mousePressed) {
      b.applyForce(wind);
    }

    b.update();
    b.display();
  }
}

void keyPressed() {
  if (key == 'r') {
    setup();
  }
}
