ArrayList<Petal> petals;
float wind = 0;           // Current wind strength
float windTarget = 0;     // Target wind (changes with key presses)

void setup() {
  size(800, 600);
  petals = new ArrayList<Petal>();
  frameRate(60);
}

void draw() {
  background(255, 230, 240); // soft pink background

  // Smooth wind transition
  wind += (windTarget - wind) * 0.05;

  // Generate new petals
  if (frameCount % 5 == 0) {
    petals.add(new Petal(random(width), random(-50, -10)));
  }

  // Update and display all petals
  for (int i = petals.size() - 1; i >= 0; i--) {
    Petal p = petals.get(i);
    p.update();
    p.display();
    if (p.isOffScreen()) {
      petals.remove(i);
    }
  }
}

void keyPressed() {
  if (keyCode == LEFT) {
    windTarget = -0.5;
  } else if (keyCode == RIGHT) {
    windTarget = 0.5;
  }
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    windTarget = 0; // stop wind
  }
}

class Petal {
  PVector pos;
  PVector vel;
  float angle;
  float angularVelocity;
  float size;
  color c;

  Petal(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(-0.5, 0.5), random(1, 2));
    angle = random(TWO_PI);
    angularVelocity = random(-0.02, 0.02);
    size = random(10, 20);
    c = color(255, random(150, 180), random(200, 220), 200); // soft pink with alpha
  }

  void update() {
    // Apply wind and random flutter
    vel.x += wind + random(-0.02, 0.02);
    pos.add(vel);
    angle += angularVelocity;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    noStroke();
    fill(c);
    ellipse(0, 0, size * 0.8, size); // petal shape
    popMatrix();
  }

  boolean isOffScreen() {
    return (pos.y > height + size);
  }
}
