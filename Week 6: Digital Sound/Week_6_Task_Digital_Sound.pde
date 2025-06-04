import processing.sound.*;
//2 oscillators
SinOsc baseOsc;        // low atmospheric drone
SawOsc harmonyOsc;     // harmony textured layer
//2 filters
LowPass lowFilter;     // warm atmosphere
HighPass highFilter;   // sparkle sound
// controlled variables
float time = 0;
float baseFreq = 60;
boolean soundActive = false;

void setup() {
  size(800, 600);
  
  // start oscillators and filters
  baseOsc = new SinOsc(this);
  harmonyOsc = new SawOsc(this);
  lowFilter = new LowPass(this);
  highFilter = new HighPass(this);
  
  //frequencies
  baseOsc.freq(baseFreq);
  harmonyOsc.freq(baseFreq * 2);
  lowFilter.freq(400);
  highFilter.freq(1000);
  
  println("Press SPACE to start/stop sound");
}

void draw() {
  // background
  float bgIntensity = soundActive ? 25 : 10;
  background(bgIntensity, bgIntensity * 1.5, bgIntensity * 3);
  
  if (soundActive) {
    updateSound();
    drawVisuals();
  } else {
    drawInstructions();
  }
  
  time += 0.016;
}

void updateSound() {
  // mouse control
  float mouseMod = map(mouseX, 0, width, 0.5, 2.0);
  float ampMod = map(mouseY, 0, height, 0.2, 1.0);
  
  // low drone with modulation
  float baseMod = baseFreq + sin(time * 0.2) * 5;
  baseOsc.freq(baseMod * mouseMod);
  baseOsc.amp(0.4 * ampMod);
  
  //harmony layer
  float harmonyMod = (baseFreq * 2) + sin(time * 0.4) * 10;
  harmonyOsc.freq(harmonyMod * mouseMod);
  harmonyOsc.amp(0.2);
  
  //filter modulation
  lowFilter.freq(300 + sin(time * 0.5) * 200 + mouseX);
  highFilter.freq(800 + sin(time * 0.3) * 400 + mouseY);
  
  //filters applied
  lowFilter.process(baseOsc);
  highFilter.process(harmonyOsc);
}

void drawVisuals() {
  //orb
  pushMatrix();
  translate(width/2, height/2);
  
  float orbSize = 150;
  fill(100, 150, 255, 200);
  noStroke();
  ellipse(0, 0, orbSize, orbSize);
  
  //ring
  stroke(200, 220, 255, 150);
  strokeWeight(2);
  noFill();
  ellipse(0, 0, orbSize * 1.5, orbSize * 1.5);
  
  popMatrix();
}

void drawInstructions() {
  fill(255);
  textAlign(CENTER);
  textSize(20);
  text("SORPIA PLANET ARRIVAL", width/2, height/2 - 40);
  text("Press SPACE to activate", width/2, height/2);
  text("Move mouse to control", width/2, height/2 + 30);
  
  //ring graphic
  stroke(100, 150, 200, 100);
  noFill();
  ellipse(width/2, height/2, 200, 200);
}

void keyPressed() {
  if (key == ' ') {
    if (soundActive) {
      baseOsc.stop();
      harmonyOsc.stop();
      soundActive = false;
    } else {
      baseOsc.play();
      harmonyOsc.play();
      soundActive = true;
    }
  }
}

void stop() {
  if (soundActive) {
    baseOsc.stop();
    harmonyOsc.stop();
  }
}
