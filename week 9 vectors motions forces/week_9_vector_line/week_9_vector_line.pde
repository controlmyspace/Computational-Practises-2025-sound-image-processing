 PVector mousePos;
 PVector mouseTranslate;
 
 float centreX;
 float centreY;
 
 //negative sale to mirror objects 
 float lineScale= -1;
 
    
    void setup() {
    size(800, 800);
    mousePos = new PVector(0,0);
    //mouseTranslate = new PVector(50,0);
    centreX = width/2;
    centreY = height/2;
  
  }
  
  void draw() {
    translate(centreX, centreY);
    background(220);
    //line(0,0, mouseX, mouseY);
    //vector 
    mousePos.x=mouseX -centreX;
    mousePos.y=mouseY- centreY;
    
    mousePos.mult(lineScale);
    
    //mousePos.add(mouseTranslate);
    //mousePos is equivalent to mouseTranslate 
    
    //line(width/2,height/2, mousePos.x - 50, mousePos.y);
    //- from X right to cursor 
    //+ from X left to cursor
    //line(centreX, centreY, mousePos.x - 50, mousePos.y);
    line(0, 0, mousePos.x, mousePos.y);
    
  }
