//angles & speed into an array 
//float is the type of array stored, [] means array
float [] angles = {0, 1, 2, 3, 4}; //five items, each value is set to zero currently
float [] speeds = {1, 3, 5, 4, 2};
// Fixed colors array - proper 2D array syntax
float [][] colors = {{245,163,200}, {106,220,172}, {255,214,32}, {150,187,212}, {177,139,203}};
float xpos = 80;
float xstep = 60;

void setup() {
  size(400, 400);
  rectMode(CENTER);
}

void draw() {
  background(200, 50, 200);
  
  for(int i = 0; i < angles.length; i++) {
    pushMatrix();
      // Use the colors from the array instead of white
      fill(colors[i][0], colors[i][1], colors[i][2]);
      translate(xpos + (xstep*i), height/2);
      rotate(radians(angles[i])); //iterates through each bit of the array
      rect(0,0,50,50);
      angles[i] = angles[i] + speeds[i];
    popMatrix();
  }
}

// If you want to use the switch statement, here's a corrected version:
void keyPressed() {
  switch(key) {
    case '0': 
      println("Zero");
      break;
    case '1': 
      println("One");
      break;
    case '2': 
      println("Two");
      break;
    case '3': 
      println("Three");
      break;
    case '4': 
      println("Four");
      break;
  }
}

//Colour challenge
  //colour #1 (245,163,200) pink
  //colour #2 (106,220,172) green
  //colour #3 (255,214,32) yellow
  //colour #4 (150,187,212) blue
  //colour #5 (177,139,203) purple
