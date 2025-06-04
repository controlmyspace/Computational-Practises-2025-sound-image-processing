import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer kick, snare, hihat, crash;
FFT fft;
AudioInput in;

//timing 
float bpm = 75.0;  //start tempo
int framesBetweenBeats;
int beatCounter = 0;
float tempoDecay = 0.998;  //tempo gradually slows down over time

//drum pattern (1 = play, 0 = silence) 16 beats
int[] kickPattern = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
int[] snarePattern = {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1};
int[] hihatPattern = {0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0};
int[] crashPattern = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1};

float audioLevel = 0;

void setup() {
  size(800, 600);
  frameRate(10);
  
  minim = new Minim(this);
  
  //drum samples
  kick = minim.loadFile("data/kick.wav");
  snare = minim.loadFile("data/snare.wav");
  hihat = minim.loadFile("data/hihat.wav");
  crash = minim.loadFile("data/crash.wav");
  
  //audio analysis
  try {
    in = minim.getLineIn(Minim.MONO, 512);
    fft = new FFT(in.bufferSize(), in.sampleRate());
  } catch (Exception e) {
    println("Audio input not available, continuing without analysis");
  }
  
  //start timing
  framesBetweenBeats = int((60.0 / bpm) * frameRate / 4); 
  
}

void draw() {
  background(20, 20, 30);
  
  //updated audio analysis
  if (fft != null && in != null) {
    fft.forward(in.mix);
    //overall audio level
    audioLevel = 0;
    for (int i = 0; i < fft.specSize()/4; i++) {
      audioLevel += fft.getBand(i);
    }
    audioLevel = map(audioLevel, 0, 20, 0, 1);
  }
  
  //drum pattern
  playDrumPattern();
  
  //tempo gradually slows down over time
  bpm *= tempoDecay;
  bpm = max(bpm, 10);  // set minimum tempo to 10 BPM
  framesBetweenBeats = int((60.0 / bpm) * frameRate / 2);
  
  //audio-reactive visual
  drawAudioVisual();
  
}

void playDrumPattern() {
  // check time for beat
  if (frameCount % framesBetweenBeats == 0) {
    int beatInPattern = beatCounter % 16;
    
    //kick (consistent pattern)
    if (kickPattern[beatInPattern] == 1) {
      if (kick != null) {
        kick.rewind();
        kick.play();
      }
      audioLevel = max(audioLevel, 0.8);
    }
    
    //snare (consistent pattern)
    if (snarePattern[beatInPattern] == 1) {
      if (snare != null) {
        snare.rewind();
        snare.play();
      }
      audioLevel = max(audioLevel, 0.6);
    }
    
    //hihat
    if (hihatPattern[beatInPattern] == 1) {
      if (hihat != null) {
        hihat.rewind();
        hihat.play();
      }
      audioLevel = max(audioLevel, 0.4);
    }
    
    //crash
    if (crashPattern[beatInPattern] == 1) {
      if (crash != null) {
        crash.rewind();
        crash.play();
      }
      audioLevel = max(audioLevel, 1.0);
    }
    
    beatCounter++;
  }
}

void drawAudioVisual() {
  //pulsing circle with audio level sensitivity
  pushMatrix();
  translate(width/2, height/2);
  
  //glow
  fill(100, 150, 255, audioLevel * 100);
  noStroke();
  float glowSize = 200 + audioLevel * 150;
  ellipse(0, 0, glowSize, glowSize);
  
  //circle
  fill(150, 200, 255, 200);
  stroke(255);
  strokeWeight(2);
  float coreSize = 100 + audioLevel * 80;
  ellipse(0, 0, coreSize, coreSize);
  
  popMatrix();
  
  //BPM indicator
  fill(255);
  textAlign(CENTER);
  textSize(16);
  text("BPM: " + int(bpm), width/2, 80);
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
