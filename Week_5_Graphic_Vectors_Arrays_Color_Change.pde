// Angles, speeds, and colors arrays
float[] angles = {0, 0, 0, 0, 0}; // Five items, each value is set to zero
float[] speeds = {1, 3, 5, 4, 2};
color[] colours = {color(245, 163, 200), color(106, 220, 172), color(255, 214, 32), color(150, 187, 212), color(177, 139, 203)};

float xpos = 80;
float xstep = 60;

void setup() {
  size(400, 400);
  rectMode(CENTER);
}

void draw() {
  background(255, 255, 255); // white
  noStroke();

  for (int i = 0; i < angles.length; i++) {
    pushMatrix();
    
    // Set color based on index
    fill(colours[i]);

    translate(xpos + (xstep * i), height / 2);
    rotate(radians(angles[i])); // Rotate based on angles array
    rect(0, 0, 50, 50); // Draw rectangle
    angles[i] += speeds[i]; // Update angles based on speed

    popMatrix();
  }
}

//Colour challenge
  //colour #1 (245,163,200) pink
  //colour #2 (106,220,172) green
  //colour #3 (255,214,32) yellow
  //colour #4 (150,187,212) blue
  //colour #5 (177,139,203) purple
