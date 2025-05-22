PImage img;

void setup() {
  size(517, 686);
   img = loadImage("sample.jpg");
   
   img.loadPixels();
   for (int i = 0; i< img.pixels.length; i++) {
     color c = img.pixels[i]; //to access pixel color
     float r = red(c);
     float g = green(c);
     float b = blue(c); 
     
     //swap color channels (RGB--> GBR) 
     img.pixels[i]= color(g,b,r);
   }
   img.updatePixels();
     

   image(img, 0, 0);
   
}
  
 
