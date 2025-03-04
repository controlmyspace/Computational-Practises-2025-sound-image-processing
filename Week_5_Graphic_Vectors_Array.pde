//angles & speed into an array 
//float is the type of array stored, [] means array

float [] angles = {0, 1, 2, 3, 4 }; //five items with a set value
float [] speeds = {1, 3, 5, 4, 2 };

float xpos = 80;
float xstep = 60;

void setup() {
  size(400, 400);
  rectMode(CENTER);
  

 
}

void draw() {
  background(200, 50, 200);
  
  for(int i = 0; i<angles.length; i ++) {
    pushMatrix();
      fill(255, 255, 255); //white
      translate(xpos + (xstep*i), height/2);
      rotate(radians(angles[i])); //iterates through each bit of the array
      rect(0,0,50,50);
      angles[i]= angles[i] + speeds[i];
    popMatrix();
   }
   
   
}

//Colour challenge
  //colour #1 (245,163,200) pink
  //colour #2 (106,220,172) green
  //colour #3 (255,214,32) yellow
  //colour #4 (150,187,212) blue
  //colour #5 (177,139,203) purple
