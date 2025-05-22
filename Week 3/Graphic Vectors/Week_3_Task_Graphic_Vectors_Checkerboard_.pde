//Week 3 Task, Graphic Vectors, Checkerboard Circle 
// grid 
int cols = 6;  // columns
int rows = 6;   // rows
float cellSize;  // cell size 

void setup() {
  size(600, 600);
  cellSize = 100; 
  frameRate(2); //smaller means slower 
  noStroke();
}

void draw() {
  background(0);  // black background
  
  // loop through each cell 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      
      // calculate center position of current cell
      float x = i * cellSize + cellSize/2;
      float y = j * cellSize + cellSize/2;
      
      //  modulo creates checkerboard grid
      if ((i + j) % 2 == 0) { //alternates between 0 and 1, every other circle on grid alternates 
        // even squares: random colors
        fill(random(255), random(255), random(255));
      } else {
        // odd squares: fixed color (blue)
        fill(100, 150, 255);
      }
      
      // draw circle with diameter slightly smaller than cell size
      circle(x, y, 25);
    }
  }
  
}
