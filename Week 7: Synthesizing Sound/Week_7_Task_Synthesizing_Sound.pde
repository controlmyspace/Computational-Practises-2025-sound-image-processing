import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer kick, snare, hihat, crash, openhat;
FFT fft;
AudioInput in;

// Timing variables
int bpm = 120;
int framesBetweenBeats;
int beatCounter = 0;
int barCounter = 0;
int patternIndex = 0;

// Pattern arrays (1 = play, 0 = silence)
int[][] kickPatterns = {
  {1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}, // Basic 4/4
  {1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0}, // Syncopated
  {1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0}  // Hip-hop style
};

int[][] snarePatterns = {
  {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0}, // Basic backbeat
  {0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1}, // More complex
  {0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0}  // Off-beat
};

int[][] hihatPatterns = {
  {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}, // 8th notes
  {1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1}, // Complex
  {1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0}  // Sparse
};

// Visualization variables
float[] spectrum;
float kickLevel = 0;
float snareLevel = 0;
float hihatLevel = 0;
ArrayList<Particle> particles;
color bgColor;

// Randomness variables
float randomChance = 0.1; // 10% chance for random hits
boolean useRandomness = true;

void setup() {
  size(800, 600);
  frameRate(60);
  
  minim = new Minim(this);
  
  // Load drum samples (you'll need to add your own audio files)
  // For this example, I'll create placeholder AudioPlayer objects
  // In practice, you'd load: kick = minim.loadFile("kick.wav");
  kick = minim.loadFile("data/kick.wav");
  snare = minim.loadFile("data/snare.wav");
  hihat = minim.loadFile("data/hihat.wav");
  crash = minim.loadFile("data/crash.wav");
  
  // Set up audio analysis
  try {
    in = minim.getLineIn(Minim.MONO, 512);
    fft = new FFT(in.bufferSize(), in.sampleRate());
  } catch (Exception e) {
    println("Audio input not available, continuing without analysis");
  }
  
  // Calculate timing
  framesBetweenBeats = int((60.0 / bpm) * frameRate / 4); // 16th note timing
  
  particles = new ArrayList<Particle>();
  bgColor = color(20, 20, 30);
  
  println("Drum Pattern Started!");
  println("BPM: " + bpm);
  println("Press SPACE to toggle randomness");
  println("Press 'P' to change pattern");
}

void draw() {
  background(bgColor);
  
  // Update audio analysis
  if (fft != null && in != null) {
    fft.forward(in.mix);
    spectrum = new float[fft.specSize()];
    for (int i = 0; i < spectrum.length; i++) {
      spectrum[i] = fft.getBand(i);
    }
  }
  
  // Play drum pattern
  playDrumPattern();
  
  // Draw visualizations
  drawWaveform();
  drawSpectrum();
  drawBeatVisualizer();
  drawParticles();
  drawInfo();
  
  // Update particles
  updateParticles();
  
  // Decay audio levels
  kickLevel *= 0.95;
  snareLevel *= 0.95;
  hihatLevel *= 0.95;
}

void playDrumPattern() {
  // Check if it's time for a beat
  if (frameCount % framesBetweenBeats == 0) {
    int currentPattern = patternIndex % kickPatterns.length;
    int beatInPattern = beatCounter % 16;
    
    // Play kick
    if (kickPatterns[currentPattern][beatInPattern] == 1 || 
        (useRandomness && random(1) < randomChance)) {
      if (kick != null) {
        kick.rewind();
        kick.play();
      }
      kickLevel = 1.0;
      addParticles(width/4, height/2, color(255, 100, 100), 5);
    }
    
    // Play snare
    if (snarePatterns[currentPattern][beatInPattern] == 1 || 
        (useRandomness && random(1) < randomChance * 0.5)) {
      if (snare != null) {
        snare.rewind();
        snare.play();
      }
      snareLevel = 1.0;
      addParticles(width/2, height/2, color(100, 255, 100), 8);
    }
    
    // Play hihat
    if (hihatPatterns[currentPattern][beatInPattern] == 1 || 
        (useRandomness && random(1) < randomChance * 2)) {
      if (hihat != null) {
        hihat.rewind();
        hihat.play();
      }
      hihatLevel = 1.0;
      addParticles(3*width/4, height/2, color(100, 100, 255), 3);
    }
    
    // Occasional crash (every 32 beats with some randomness)
    if (beatCounter % 32 == 0 && random(1) < 0.7) {
      if (crash != null) {
        crash.rewind();
        crash.play();
      }
      addParticles(width/2, height/4, color(255, 255, 100), 15);
      bgColor = color(random(50, 100), random(20, 50), random(20, 50));
    } else {
      bgColor = lerpColor(bgColor, color(20, 20, 30), 0.05);
    }
    
    beatCounter++;
    
    // Change pattern every 4 bars (64 beats)
    if (beatCounter % 64 == 0) {
      patternIndex++;
      println("Pattern changed to: " + (patternIndex % kickPatterns.length + 1));
    }
  }
}

void drawWaveform() {
  if (in == null) return;
  
  stroke(255, 150);
  strokeWeight(2);
  noFill();
  
  beginShape();
  for (int i = 0; i < in.bufferSize() - 1; i++) {
    float x1 = map(i, 0, in.bufferSize(), 0, width);
    float y1 = map(in.mix.get(i), -1, 1, height - 100, height - 50);
    vertex(x1, y1);
  }
  endShape();
}

void drawSpectrum() {
  if (spectrum == null) return;
  
  fill(255, 100, 150, 100);
  noStroke();
  
  for (int i = 0; i < spectrum.length/4; i++) {
    float x = map(i, 0, spectrum.length/4, 0, width);
    float h = map(spectrum[i], 0, 30, 0, 200);
    rect(x, height - h, width/(spectrum.length/4), h);
  }
}

void drawBeatVisualizer() {
  // Draw drum pads
  drawDrumPad(width/4, height/2, 60, kickLevel, "KICK", color(255, 100, 100));
  drawDrumPad(width/2, height/2, 60, snareLevel, "SNARE", color(100, 255, 100));
  drawDrumPad(3*width/4, height/2, 60, hihatLevel, "HIHAT", color(100, 100, 255));
  
  // Draw beat counter
  fill(255);
  textAlign(CENTER);
  textSize(16);
  text("Beat: " + (beatCounter % 16 + 1) + "/16", width/2, 50);
  
  // Draw beat indicator
  for (int i = 0; i < 16; i++) {
    float x = map(i, 0, 15, 50, width - 50);
    if (i == beatCounter % 16) {
      fill(255, 200, 0);
      ellipse(x, 80, 12, 12);
    } else {
      fill(100);
      ellipse(x, 80, 8, 8);
    }
  }
}

void drawDrumPad(float x, float y, float size, float level, String label, color c) {
  // Pad glow
  fill(red(c), green(c), blue(c), level * 150);
  ellipse(x, y, size + level * 20, size + level * 20);
  
  // Pad base
  fill(red(c), green(c), blue(c), 150);
  stroke(255);
  strokeWeight(2);
  ellipse(x, y, size, size);
  
  // Label
  fill(255);
  textAlign(CENTER);
  textSize(12);
  text(label, x, y + size/2 + 20);
}

void addParticles(float x, float y, color c, int count) {
  for (int i = 0; i < count; i++) {
    particles.add(new Particle(x, y, c));
  }
}

void updateParticles() {
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    if (p.isDead()) {
      particles.remove(i);
    }
  }
}

void drawParticles() {
  for (Particle p : particles) {
    p.display();
  }
}

void drawInfo() {
  fill(255, 200);
  textAlign(LEFT);
  textSize(14);
  text("Pattern: " + (patternIndex % kickPatterns.length + 1) + "/3", 20, 30);
  text("BPM: " + bpm, 20, 50);
  text("Randomness: " + (useRandomness ? "ON" : "OFF"), 20, 70);
  text("Bar: " + (beatCounter / 16 + 1), 20, 90);
  
  textAlign(RIGHT);
  text("SPACE: Toggle Randomness", width - 20, height - 60);
  text("P: Change Pattern", width - 20, height - 40);
  text("UP/DOWN: Change BPM", width - 20, height - 20);
}

void keyPressed() {
  if (key == ' ') {
    useRandomness = !useRandomness;
    println("Randomness: " + (useRandomness ? "ON" : "OFF"));
  }
  
  if (key == 'p' || key == 'P') {
    patternIndex++;
    println("Pattern changed to: " + (patternIndex % kickPatterns.length + 1));
  }
  
  if (keyCode == UP) {
    bpm = min(bpm + 10, 200);
    framesBetweenBeats = int((60.0 / bpm) * frameRate / 4);
    println("BPM: " + bpm);
  }
  
  if (keyCode == DOWN) {
    bpm = max(bpm - 10, 60);
    framesBetweenBeats = int((60.0 / bpm) * frameRate / 4);
    println("BPM: " + bpm);
  }
}

class Particle {
  PVector pos, vel;
  color c;
  float life, maxLife;
  float size;
  
  Particle(float x, float y, color col) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    vel.mult(random(2, 8));
    c = col;
    maxLife = life = random(30, 80);
    size = random(3, 8);
  }
  
  void update() {
    pos.add(vel);
    vel.mult(0.98);
    life--;
  }
  
  void display() {
    float alpha = map(life, 0, maxLife, 0, 255);
    fill(red(c), green(c), blue(c), alpha);
    noStroke();
    ellipse(pos.x, pos.y, size * (life/maxLife), size * (life/maxLife));
  }
  
  boolean isDead() {
    return life <= 0;
  }
}

void stop() {
  if (kick != null) kick.close();
  if (snare != null) snare.close();
  if (hihat != null) hihat.close();
  if (crash != null) crash.close();
  if (in != null) in.close();
  minim.stop();
  super.stop();
}
