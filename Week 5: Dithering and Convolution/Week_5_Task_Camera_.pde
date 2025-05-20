import processing.video.*;

Capture cam;
PImage processed;
int frameCountSaved = 0;
int maxFrames = 10;

color colorA, colorB;

void setup() {
  size(640, 480);
  cam = new Capture(this, width, height);
  cam.start();
  
  processed = createImage(width, height, RGB);
  
  // Duotone colors
  colorA = color(10, 10, 80);     // dark blue
  colorB = color(255, 200, 0);    // warm yellow
}

void draw() {
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
    processed.loadPixels();

    for (int i = 0; i < cam.pixels.length; i++) {
      color c = cam.pixels[i];

     
      float b = brightness(c) / 100.0;
      color filtered = lerpColor(colorA, colorB, b);

      float avg = red(filtered) * 0.299 + green(filtered) * 0.587 + blue(filtered) * 0.114;
      if (avg > 128) {
        processed.pixels[i] = color(255);
      } else {
        processed.pixels[i] = color(0);
      }
    }

    processed.updatePixels();
    image(processed, 0, 0);
  }
}

void keyPressed() {
  if (key == 's' && frameCountSaved < maxFrames) {
    saveFrame("story_reel/frame_####.png");
    println("saved frame " + frameCountSaved);
    frameCountSaved++;
  }
}
