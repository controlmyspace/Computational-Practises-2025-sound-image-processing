PImage sample;

void setup() {
  size(517,686);
  sample = loadImage("sample1.jpg");
 
}

void draw(){
  loadPixels();
  
  int[] histogram = new int[256];
  //histogram is the array, int declares size, arrays cant be resized that's why size has to be assigned, always 256 (otherwise math error) 
  
  for(int i =0; i <sample.pixels.length; i++) { //loop
  
    int pixelShade = int(red(sample.pixels[i]));
    //grayscale channel set 
    pixels[i] = color(pixelShade);
    //if you only use one color in argument it becomes gray (black & white) 
    
    histogram[pixelShade]++; 
}
  updatePixels();
  
  for (int i = 0; i<histogram.length; i++) { 
    stroke(255,0,0);
    float startHeight = map(histogram[i], 0, max(histogram), height, height-(height/3)); //why divided by 3 
    line(i, startHeight, i, height);
   }
}
  
  
  
  
