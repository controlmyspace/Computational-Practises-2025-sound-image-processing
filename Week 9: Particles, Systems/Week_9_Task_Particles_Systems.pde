// Museum Archives Preservation Game
// Classes for game objects
class Archivist {
  float x, y;
  float w, h;
  float speed;
  
  Archivist(float startX, float startY) {
    x = startX;
    y = startY;
    w = 60;
    h = 80;
    speed = 5;
  }
  
  void update() {
    // Move left and right with arrow keys
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == LEFT && x > w/2) {
          x -= speed;
        } else if (keyCode == RIGHT && x < width - w/2) {
          x += speed;
        }
      }
    }
  }
  
  void display() {
    // Draw archivist as a simple character
    fill(100, 150, 200);
    rectMode(CENTER);
    rect(x, y, w, h);
    
    // Head
    fill(255, 220, 177);
    ellipse(x, y - h/2 - 15, 30, 30);
    
    // Arms
    fill(100, 150, 200);
    rect(x - w/2 - 10, y - 10, 8, 30);
    rect(x + w/2 + 10, y - 10, 8, 30);
    
    // Eyes
    fill(0);
    ellipse(x - 5, y - h/2 - 18, 3, 3);
    ellipse(x + 5, y - h/2 - 18, 3, 3);
    
    // Display stacked archives on head
    displayStack();
  }
  
  void displayStack() {
    float stackY = y - h/2 - 30; // Start above the head
    
    for (int i = 0; i < stackedArchives.size(); i++) {
      String archiveType = stackedArchives.get(i);
      float itemY = stackY - (i * 25); // Stack items with 25 pixel spacing
      
      rectMode(CENTER);
      
      if (archiveType.equals("archive")) {
        // Draw archive
        fill(139, 69, 19);
        rect(x, itemY, 30, 20);
        fill(255);
        for (int j = 0; j < 2; j++) {
          line(x - 12, itemY - 8 + j*4, x + 12, itemY - 8 + j*4);
        }
      }
    }
  }
  
  // Check if object hits the stack or archivist
  boolean catches(FallingObject obj) {
    // Check collision with archivist body
    boolean hitsBody = (obj.x > x - w/2 && obj.x < x + w/2 && 
                       obj.y > y - h/2 && obj.y < y + h/2);
    
    // Check collision with stack (if there are stacked items)
    boolean hitsStack = false;
    if (stackedArchives.size() > 0) {
      float stackTop = y - h/2 - 30 - (stackedArchives.size() - 1) * 25;
      hitsStack = (obj.x > x - 20 && obj.x < x + 20 && 
                   obj.y > stackTop - 15 && obj.y < stackTop + 15);
    }
    
    return hitsBody || hitsStack;
  }
}

class FallingObject {
  float x, y;
  float vx, vy; // velocity components (2 forces: gravity + wind)
  float w, h;
  String type;
  color objColor;
  float windForce;
  float gravity;
  
  FallingObject(float startX, String objType) {
    x = startX;
    y = -20;
    type = objType;
    w = 40;
    h = 30;
    
    // Two forces influencing movement:
    gravity = 0.2; // Gravity force pulling down
    windForce = random(-0.1, 0.1); // Wind force affecting horizontal movement
    vx = windForce;
    vy = 1;
    
    // Set colors based on type
    if (type.equals("archive")) {
      objColor = color(139, 69, 19);
    } else if (type.equals("water")) {
      objColor = color(64, 164, 223);
    }
  }
  
  void update() {
    // Apply forces
    vy += gravity * 0.02; // Gravity increases downward velocity
    vx += windForce * 0.01; // Wind affects horizontal movement
    
    // Update position
    x += vx;
    y += vy;
    
    // Keep objects within screen bounds horizontally
    if (x < 0 || x > width) {
      vx *= -0.5; // Bounce off walls with energy loss
    }
  }
  
  void display() {
    fill(objColor);
    rectMode(CENTER);
    
    if (type.equals("archive")) {
      // Draw as archive
      rect(x, y, w, h);
      fill(255);
      for (int i = 0; i < 3; i++) {
        line(x - w/2 + 5, y - h/2 + 5 + i*5, x + w/2 - 5, y - h/2 + 5 + i*5);
      }
    } else if (type.equals("water")) {
      // Draw as multiple water droplets
      fill(objColor, 180);
      
      // Main large droplet
      ellipse(x, y, w*0.8, h*0.8);
      // Add teardrop shape
    
      
      // Smaller droplets around it
      fill(objColor, 120);
      ellipse(x - w*0.4, y + h*0.2, w*0.3, h*0.3);
      ellipse(x + w*0.3, y + h*0.3, w*0.25, h*0.25);
      ellipse(x - w*0.2, y - h*0.5, w*0.2, h*0.2);
      ellipse(x + w*0.4, y - h*0.3, w*0.2, h*0.2);
     
   
    }
  }
  
  boolean isOffScreen() {
    return y > height + 50;
  }
}

// Game variables
Archivist archivist;
ArrayList<FallingObject> fallingObjects;
ArrayList<String> stackedArchives; // Stack of archives on head
int score;
boolean gameOver;
int lastSpawnTime;
int spawnInterval;
String[] archiveTypes = {"archive"};
String[] destroyerTypes = {"water"};
float stackHeight = 0; // Current height of the stack

void setup() {
  size(800, 600);
  
  // Initialize game
  archivist = new Archivist(width/2, height - 100);
  fallingObjects = new ArrayList<FallingObject>();
  stackedArchives = new ArrayList<String>();
  score = 0;
  gameOver = false;
  lastSpawnTime = millis();
  spawnInterval = 2000; // Spawn every 2 seconds initially
  stackHeight = 0;
}

void draw() {
  background(240, 230, 210); // Museum background color
  
  if (!gameOver) {
    // Update and display archivist
    archivist.update();
    archivist.display();
    
    // Spawn new objects
    if (millis() - lastSpawnTime > spawnInterval) {
      spawnObject();
      lastSpawnTime = millis();
      
      // Gradually increase difficulty
      if (spawnInterval > 800) {
        spawnInterval -= 10;
      }
    }
    
    // Update and display falling objects
    for (int i = fallingObjects.size() - 1; i >= 0; i--) {
      FallingObject obj = fallingObjects.get(i);
      obj.update();
      obj.display();
      
      // Check for interactions (catching objects)
      if (archivist.catches(obj)) {
        if (isArchive(obj.type)) {
          // Add archive to stack on head
          stackedArchives.add(obj.type);
          score++;
          stackHeight += 25; // Each item adds 25 pixels to stack height
          fallingObjects.remove(i);
        } else if (isDestroyer(obj.type)) {
          // Game over if destroyer lands on archivist or stack
          gameOver = true;
        }
      } else if (obj.isOffScreen()) {
        fallingObjects.remove(i);
      }
    }
    
    // Display UI
    displayUI();
    
  } else {
    // Game over screen
    displayGameOver();
  }
}

void spawnObject() {
  float spawnX = random(50, width - 50);
  
  // 75% chance for archives, 25% for water droplets
  if (random(100) < 75) {
    fallingObjects.add(new FallingObject(spawnX, "archive"));
  } else {
    fallingObjects.add(new FallingObject(spawnX, "water"));
  }
}

boolean isArchive(String type) {
  for (String archiveType : archiveTypes) {
    if (type.equals(archiveType)) {
      return true;
    }
  }
  return false;
}

boolean isDestroyer(String type) {
  for (String destroyerType : destroyerTypes) {
    if (type.equals(destroyerType)) {
      return true;
    }
  }
  return false;
}

void displayUI() {
  // Score display
  fill(0);
  textSize(24);
  text("Archives Saved: " + score, 20, 30);
  
  // Stack height display
  textSize(18);
  text("Archive Stack: " + stackedArchives.size() + " archives", 20, 60);
  
  // Instructions
  textSize(16);
  text("Use LEFT/RIGHT arrows to move", 20, height - 80);
  text("Catch archives to stack on your head!", 20, height - 60);
  text("Avoid water droplets - they'll damage your archives!", 20, height - 40);
  text("Goal: Build the tallest archive stack possible", 20, height - 20);
}

void displayGameOver() {
  
  // Game over text
  fill(0);
  textAlign(CENTER);
  textSize(48);
  text("ARCHIVES DESTROYED!", width/2, height/2 - 80);
  
  textSize(32);
  text("Final Score: " + score + " Archives", width/2, height/2 - 30);
  text("Stack Height: " + stackedArchives.size() + " archives", width/2, height/2);
  
  textSize(20);
  text("Water droplets soaked your precious archive collection!", width/2, height/2 + 40);
  text("The library archives have been damaged...", width/2, height/2 + 65);
  text("Press R to restart and try again", width/2, height/2 + 100);
  
  textAlign(LEFT);
}

void keyPressed() {
  if (gameOver && (key == 'r' || key == 'R')) {
    // Restart game
    setup();
  }
}
