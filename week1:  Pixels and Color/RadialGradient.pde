int dim;

void setup() {
  size(1000,1000);
  dim = width/2;
  background(255, 255, 255);
  colorMode(HSB, 360, 10, 20);
  noStroke();
  ellipseMode(RADIUS);
  frameRate(2);
}

void draw() {
  for (int x = 0; x <= width; x+=dim) {
    drawGradient(x, height/2);//positions circle in middle of canvas 
  }
}
  
void drawGradient(float x, float y) {
  int radius = dim/3;
  float h = random(0,360); //colour range of gradient
  for (int r = radius; r >0; --r) { //-- means iterating loop, + 1
    fill(h, 360,360);
    circle(x,y,r);
    h= (h+1)% 330; // %  is the remainder operator: returns remainder of a division operation.
    //above line: gradient intensity, 0 is no gradient, 360 is seamless 
  }
}
