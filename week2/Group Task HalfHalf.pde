PImage img;  // Declare a variable 'img' of type PImage to store our image
void setup() {
  size(576, 720);  // Set the size of the display window to match your image dimensions
  img = loadImage("halfhalf.jpg");  // Load the image file "sample.jpg" into the 'img' variable
  img.loadPixels();  // Load the pixel data of the image into the pixels[] array so we can access and modify it
  int imgWidth = img.width;  // Store the width of the image in a variable for easier reference and better performance
  // Nested loops to go through each pixel in the image
  // The outer loop (y) goes through each row from top to bottom
  for (int y = 0; y < img.height; y++) {
    // The inner loop (x) goes through each pixel in the current row from left to right
    for (int x = 0; x < imgWidth; x++) {
      // Calculate the 1D array position for the current (x,y) pixel
      // This formula converts 2D coordinates (x,y) to a 1D index
      int i = x + y * imgWidth;
      // Get the current color of the pixel at position i
      color c = img.pixels[i];
      // Check if the current pixel is in the left half of the image
      if (x < imgWidth / 2) {
        // For the left half: convert the pixel to grayscale
        // Extract the red, green, and blue values from the current color
        float r = red(c);
        float g = green(c);
        float b = blue(c);
        // Calculate grayscale value by averaging the RGB channels
        // This is a simple grayscale conversion - equal weights for R, G, and B
        // More accurate grayscale conversion would use different weights for each channel
        float gray = (r + g + b) / 3;
        // Set the pixel to the new grayscale color (all RGB values are the same)
        img.pixels[i] = color(gray, gray, gray);
      }
      // For pixels in the right half (x >= imgWidth/2):
      // We don't need to do anything because we want to keep the original colors
      // This is an implied "else" block that's empty
    }
  }
  // After modifying the pixels, we need to call updatePixels() to apply the changes
  img.updatePixels();
  // Draw the modified image to the display window, starting at position (0,0)
  image(img, 0, 0);
}
