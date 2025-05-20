float scale = 0.05;
float time = 0;
color colorA, colorB;
int cols, rows;
int resolution = 10; // size of each grid cell

void setup() {
  size(800, 600);
  cols = width / resolution;
  rows = height / resolution;
  
  // Sky-inspired colors (from dark to light)
  colorA = color(72, 61, 139);   // Deep sky purple (e.g., dusk)
  colorB = color(135, 206, 250); // Light sky blue (daylight)
  
  noStroke();
}

void draw() {
  background(20);
  
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float xoff = x * scale;
      float yoff = y * scale;
      float height = noise(xoff, yoff, time);
      
      // Duotone sky color blending
      color skyColor = lerpColor(colorA, colorB, height);
      fill(skyColor);
      
      rect(x * resolution, y * resolution, resolution, resolution);
    }
  }
  
  time += 0.01; // animate over time
}
