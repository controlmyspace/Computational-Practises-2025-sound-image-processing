import processing.video.*;

Movie movie;

void setup() {
  size(880, 720);
  
  //movie object
  movie= new Movie(this, "hueflip.mp4");
  movie.play();
  movie.volume(0);
  
}

void draw() { //function keeps going, separating each frames & reiterates 
  
  
  if(movie.available()) {
    movie.read();
  }
  
  image(movie, 0, 0);
  
 
}
