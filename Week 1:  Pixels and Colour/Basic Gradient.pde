//gradient drawing
void setup() {
  size(400,400); //set size, square
}

void draw() {
  
  loadPixels();
  //nested for loop: for loop within a for loop 
  for(int x = 0;x <width; x++){
  //++ iterating x 
  //x coordinate
    for(int y =0; y<height; y++){
      float normalizedX = map(x, 0, width, 0, 1);
      //normalized value of x: take a range and place between range 0-1 (for any range) 
      //map function to change between ranges
      //float value because working with decimals, handy measure to multiply colors 
        int green = 0;
        int blue = int(255*(1-normalizedX));
        int red = int(255 * normalizedX); //255 is most amoung of red, but multiplication creates gradient: from less to more from left to right

      
        color c = color(red, green, blue);
      
        pixels[x+y * width] = c; //converts from one to two dimensional representation of the pixels
    }
  }
  updatePixels();
  
  
}
