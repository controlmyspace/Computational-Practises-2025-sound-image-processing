import processing.sound.*;

// Oscillators for layered sound design
SinOsc baseOsc;        // Deep atmospheric drone
SawOsc harmonyOsc;     // Harmonic texture layer
TriOsc crystalOsc;     // High crystalline shimmer
SqrOsc pulseOsc;       // Rhythmic pulse element

// Filters for sound shaping
LowPass lowFilter;     // Warm, muffled atmosphere
BandPass bandFilter;   // Focused harmonic content
HighPass highFilter;   // Crystalline sparkle

// Sound control variables
float time = 0;
float baseFreq = 45;   // Deep fundamental
float intensity = 0;
boolean soundActive = false;

// Visual feedback
color bgColor;
float visualIntensity = 0;

void setup() {
  size(800, 600);
  
  // Initialize oscillators
  baseOsc = new SinOsc(this);
  harmonyOsc = new SawOsc(this);
  crystalOsc = new TriOsc(this);
  pulseOsc = new SqrOsc(this);
  
  // Initialize filters
  lowFilter = new LowPass(this);
  bandFilter = new BandPass(this);
  highFilter = new HighPass(this);
  
  // Set initial frequencies
  baseOsc.freq(baseFreq);
  harmonyOsc.freq(baseFreq * 1.5);
  crystalOsc.freq(baseFreq * 8);
  pulseOsc.freq(baseFreq * 0.25);
  
  // Configure filters
  lowFilter.freq(800);
  bandFilter.freq(400);
  bandFilter.bw(2.0);
  highFilter.freq(2000);
  
  println("Press SPACE to start/stop the planetary arrival sound");
  println("Move mouse to modulate the sound in real-time");
}

void draw() {
  // Dynamic background based on sound intensity
  bgColor = lerpColor(color(5, 15, 35), color(25, 45, 85), visualIntensity);
  background(bgColor);
  
  if (soundActive) {
    updateSound();
    drawVisualFeedback();
  } else {
    drawInstructions();
  }
  
  time += 0.016; // Increment time for modulation
}

void updateSound() {
  // Mouse controls for real-time modulation
  float mouseInfluence = map(mouseX, 0, width, 0.2, 2.0);
  float verticalMod = map(mouseY, 0, height, 0.1, 1.0);
  
  // Evolving intensity using sine waves
  intensity = (sin(time * 0.3) + 1) * 0.5; // Main evolution
  intensity += (sin(time * 0.7) + 1) * 0.1; // Secondary variation
  intensity = constrain(intensity, 0, 1);
  
  visualIntensity = intensity;
  
  // Base atmospheric drone with slow frequency modulation
  float baseMod = baseFreq + sin(time * 0.2) * 8 + sin(time * 0.05) * 3;
  baseOsc.freq(baseMod * mouseInfluence);
  baseOsc.amp(0.3 * intensity * verticalMod);
  
  // Harmonic layer with faster modulation
  float harmonyMod = (baseFreq * 1.5) + sin(time * 0.4) * 12 + cos(time * 0.15) * 6;
  harmonyOsc.freq(harmonyMod * mouseInfluence);
  harmonyOsc.amp(0.15 * intensity);
  
  // Crystalline high frequency layer
  float crystalMod = (baseFreq * 8) + sin(time * 1.2) * 50 + sin(time * 0.8) * 25;
  crystalOsc.freq(crystalMod * mouseInfluence);
  crystalOsc.amp(0.08 * intensity * (1 - verticalMod * 0.5));
  
  // Pulsing low frequency element
  float pulseMod = (baseFreq * 0.25) + sin(time * 0.1) * 2;
  pulseOsc.freq(pulseMod);
  pulseOsc.amp(0.2 * intensity * sin(time * 2) * sin(time * 2));
  
  // Dynamic filter modulation
  float cutoffMod = 400 + sin(time * 0.6) * 300 + mouseX * 2;
  lowFilter.freq(cutoffMod);
  
  float bandMod = 300 + sin(time * 0.8) * 200 + mouseY;
  bandFilter.freq(bandMod);
  
  // Apply filters to different oscillators
  lowFilter.process(baseOsc);
  bandFilter.process(harmonyOsc);
  highFilter.process(crystalOsc);
}

void drawVisualFeedback() {
  // Central energy orb
  pushMatrix();
  translate(width/2, height/2);
  
  // Multiple layers of visual feedback
  for (int i = 5; i > 0; i--) {
    float alpha = map(i, 1, 5, 255 * visualIntensity, 50 * visualIntensity);
    float size = i * 60 * (1 + visualIntensity);
    
    fill(70 + i * 30, 120 + i * 20, 200 + i * 10, alpha);
    noStroke();
    ellipse(0, 0, size, size);
  }
  
  // Radiating energy lines
  stroke(150, 200, 255, 100 * visualIntensity);
  strokeWeight(2);
  for (int i = 0; i < 12; i++) {
    float angle = (TWO_PI / 12) * i + time * 0.5;
    float lineLength = 100 + sin(time * 2 + i) * 50;
    
    pushMatrix();
    rotate(angle);
    line(80, 0, 80 + lineLength * visualIntensity, 0);
    popMatrix();
  }
  
  popMatrix();
  
  // Floating particles
  for (int i = 0; i < 20; i++) {
    float x = 50 + (noise(i * 0.1, time * 0.3) * (width - 100));
    float y = 50 + (noise(i * 0.1 + 100, time * 0.2) * (height - 100));
    float size = 3 + sin(time * 3 + i) * 2;
    
    fill(200, 220, 255, 150 * visualIntensity);
    noStroke();
    ellipse(x, y, size, size);
  }
  
  // Sound parameters display
  fill(255, 200);
  textAlign(LEFT);
  text("Intensity: " + nf(intensity, 1, 2), 20, 30);
  text("Mouse X: Frequency Mod", 20, height - 40);
  text("Mouse Y: Amplitude Control", 20, height - 20);
}

void drawInstructions() {
  fill(255);
  textAlign(CENTER);
  textSize(24);
  text("SORPIA PLANET ARRIVAL", width/2, height/2 - 60);
  
  textSize(16);
  text("Press SPACE to activate sound", width/2, height/2 - 20);
  text("Move mouse to modulate in real-time", width/2, height/2);
  
  // Static visual elements
  stroke(100, 150, 200, 100);
  strokeWeight(1);
  noFill();
  for (int i = 0; i < 5; i++) {
    ellipse(width/2, height/2, i * 80, i * 80);
  }
}

void keyPressed() {
  if (key == ' ') {
    if (soundActive) {
      // Stop all oscillators
      baseOsc.stop();
      harmonyOsc.stop();
      crystalOsc.stop();
      pulseOsc.stop();
      soundActive = false;
    } else {
      // Start all oscillators
      baseOsc.play();
      harmonyOsc.play();
      crystalOsc.play();
      pulseOsc.play();
      soundActive = true;
    }
  }
}

// Clean up when sketch closes
void stop() {
  if (soundActive) {
    baseOsc.stop();
    harmonyOsc.stop();
    crystalOsc.stop();
    pulseOsc.stop();
  }
}
