void setup() {
  size(400, 400);
  noLoop();
}

void draw() {
  background(255);
  
  // Create gradient from center
  for (int i = 0; i <= width; i++) {
    for (int j = 0; j <= height; j++) {
      float distance = dist(width/2, height/2, i, j);
      float maxDistance = dist(0, 0, width/2, height/2);
      float ratio = distance/maxDistance;
      color c = lerpColor(color(0, 255, 0), color(255,0,0), ratio);
      stroke(c);
      point(i, j);
      
      //float decimal value 
    }
  }
}
