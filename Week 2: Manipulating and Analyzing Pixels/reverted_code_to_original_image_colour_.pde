PImage sample;

void setup() {
  size(428, 640);
  sample = loadImage("flocktogetherwalk.jpg");
  sample.loadPixels(); 
}

void draw() {
  loadPixels();

  // separate histograms for each color channel
  //histogram is the array, int declares size, arrays cant be resized that's why size has to be assigned, always 256 (otherwise math error) 
  int[] redHist = new int[256];
  int[] greenHist = new int[256];
  int[] blueHist = new int[256];
  
  //GRAYSCALE CODE
  //for (int i = 0; i < sample.pixels.length; i++) {
  //  int pixelShade = int(red(sample.pixels[i])); //order matters, definition of pixelshade must go first, otherwise code error
  //  pixels[i] = color(pixelShade);
  //  histogram[pixelShade]++;
 
  
  //REVERTED TO ORIGINAL COLOUR CODE
  // copied image pixels and calculated histogram values
  for (int i = 0; i < sample.pixels.length; i++) { // copied original color pixels directly
    color c = sample.pixels[i];
    pixels[i] = c;
  

    redHist[int(red(c))]++;
    greenHist[int(green(c))]++;
    blueHist[int(blue(c))]++;
  }

  updatePixels();

  //  maximum histogram value (in order to scale)
  int maxRed = max(redHist);
  int maxGreen = max(greenHist);
  int maxBlue = max(blueHist);

  // red histogram
  for (int i = 0; i < 256; i++) {
    stroke(255, 0, 0, 100);
    float h = map(redHist[i], 0, maxRed, 0, height/2);
    line(i, height, i, height - h);
  }

  // green histogram (positioned a bit further to right so not all completely overlapping)
  for (int i = 0; i < 256; i++) {
    stroke(0, 255, 0, 100);
    float h = map(greenHist[i], 0, maxGreen, 0, height/2);
    line(i+200, height, i+200, height - h);
  }

  //blue histogram (positioned a bit to the right)
  for (int i = 0; i < 256; i++) {
    stroke(0, 0, 255, 100);
    float h = map(blueHist[i], 0, maxBlue, 0, height/2);
    line(i+100, height, i+100, height - h);
  }

  
}
