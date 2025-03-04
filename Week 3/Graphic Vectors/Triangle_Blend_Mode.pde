void setup() {
  size(400, 400);
  blendMode(BLEND);
  rectMode(CENTER);
  background(0); //black
  
  noStroke();
  
  blendMode(DIFFERENCE);
  fill(255); //white
  
  rect(width/2, height/2, 100, 100);
  
  pushMatrix();
    translate((width/2)-75, (height/2) -75);
    drawTriangle();
  
  pushMatrix();
     translate((width/2)-75, (height/2) -75);
     drawCircle();
    

}

//custom function
void drawTriangle()  {
  
  triangle(
      0, 100,
      100, 100,
      50, 0
      );
}

//custom function
void drawCircle()  {
  fill(255);
  
  circle(0, 0, 100);
}
