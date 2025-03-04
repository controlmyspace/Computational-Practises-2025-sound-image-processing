//necessary in order to have different speeds 
float angleOne = 0; 
float angleTwo = 20;
float angleThree = 50;
float angleFour = 100;
float angleFive = 2000;

//short for position of X
float xpos = 80;
float xstep = 60; //space between squares 

void setup () {
  size (400, 400);
  //origin at center 
  rectMode(CENTER);
  
}

void draw() {
  background(20, 220, 40); //green 
  
  //first square 
  pushMatrix(); //indent for readability
    stroke(0); //white stroke
    fill(153, 50 , 204); //purple
    translate(xpos + (xstep*0),height/2); //to draw more squares 
    rotate(radians(angleOne)); //processing doesn't have degrees mode 
    rect(0, 0, 50, 50);
    angleOne = angleOne + 1; //or ++ for similar iteration
  popMatrix();
  
  //second square 
  pushMatrix(); //indent for readability
    stroke(255, 255, 255);
    fill(100, 50 , 100); //dark purple
    translate(xpos + (xstep*1),height/2); //to draw more squares 
    rotate(radians(angleTwo)); //processing doesn't have degrees mode 
    rect(0, 0, 50, 50);
    angleTwo = angleTwo + 1; //or ++ for similar iteration
  popMatrix();
  
   //third square 
  pushMatrix(); //indent for readability
    stroke(0);
    fill(200, 50 , 200); //pink
    translate(xpos + (xstep*2),height/2); //to draw more squares 
    rotate(radians(angleThree)); //processing doesn't have degrees mode 
    rect(0, 0, 25, 25);
    angleThree = angleThree + 5; //or ++ for similar iteration
  popMatrix();
  
   //fourth square 
  pushMatrix(); //indent for readability
    stroke(255, 255, 255);
    fill(50, 50 , 255); //blue
    translate(xpos + (xstep*3),height/2); //to draw more squares 
    rotate(radians(angleFour)); //processing doesn't have degrees mode 
    rect(0, 0, 50, 50);
    angleFour = angleFour + 1.5; //or ++ for similar iteration
  popMatrix();
  
   //fifth square 
  pushMatrix(); //indent for readability
    stroke(0);
    fill(50, 255 , 150); //mint green
    translate(xpos + (xstep*4),height/2); //to draw more squares 
    rotate(radians(angleFive)); //processing doesn't have degrees mode 
    rect(0, 0, 50, 50);
    angleFive = angleFive + 2; //or ++ for similar iteration
  popMatrix();
    
    
    //to reduce repition: for loop 
    
}
