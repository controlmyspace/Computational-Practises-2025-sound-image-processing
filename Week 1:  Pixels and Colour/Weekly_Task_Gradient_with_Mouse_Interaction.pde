//gradient drawing with mouse interaction
void setup() {
  size(400, 400); 
}

void draw() {
  // mouse position to color 
  float mouseNormalizedX = map(mouseX, 0, width, 0, 1);
  float mouseNormalizedY = map(mouseY, 0, height, 0, 1);
  
  //  mouse influences gradient colors
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      float normalizedX = map(x, 0, width, 0, 1);
      float normalizedY = map(y, 0, height, 0, 1);
      
      //colors based on mouse position
      int red = int(255 * normalizedX * mouseNormalizedX);
      int green = int(255 * normalizedY * mouseNormalizedY);
      int blue = int(255 * (1 - normalizedX) * (1 - mouseNormalizedX));
      
      stroke(red, green, blue);
      point(x, y);
    }
  }
}
