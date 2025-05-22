//green channel image
PImage img;

void setup() {
  size(656, 1280);
   img = loadImage("flocktogetherwalk.jpg");
   
   img.loadPixels();
   for (int i = 0; i< img.pixels.length; i++) {
     color c = img.pixels[i]; //to access pixel color
     float r = red(c);
     float g = green(c);
     float b = blue(c); 
     
     //swap color channels (RGB--> BGR) 
     img.pixels[i]= color(b,g,r);
   }
   img.updatePixels();
     

   image(img, 0, 0);
   
}
