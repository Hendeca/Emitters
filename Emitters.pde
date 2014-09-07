import java.util.Random; 

int i = 0; // For looping
Emitter[] emitters;
RNG rng = new RNG();

void setup() {
  frameRate(29.97);
  size(2560, 1440);
  background(0);
  emitters = new Emitter[20];
  initEmitters();
}

void initEmitters() {
  for ( i = 0; i < emitters.length; i++) {
   
   emitters[i] = new Emitter(new PVector(0, 0), new PVector(random(-0.02, 0.02),0), new PVector(0, 0), new PVector(3.0,3.0), new PVector(1.0, 1.0), new PVector(0.02, 0.02), new PVector(0.1, 0.1), random(0.96, 0.99), random(50, 600), new ColorCycle(random(1, 2), 0, 2, 4, random(50, 255)));
  
  }
  
  
}

void draw() {
  background(0);
  for ( i = 0; i < emitters.length; i++) {
    pushMatrix();
    translate(width / 2, height / 2);
    emitters[i].update();
    emitters[i].draw();
    popMatrix();
    //saveFrame("RainbowPart/frames######.png");
  }  
}
