import java.util.Random; 

int i = 0; // For looping
Emitter[] emitters;
RNG rng = new RNG();

void setup() {
  frameRate(29.97);
  size(1440, 900);
  background(0);
  emitters = new Emitter[8];
  initEmitters();
}

void initEmitters() {
  for ( i = 0; i < emitters.length; i++) {
   
   emitters[i] = new Emitter(new PVector(0, 0), new PVector(random(-0.02, 0.02),0), new PVector(0, 0), new PVector(3.0,3.0), new PVector(1.0, 1.0), new PVector(0.02, 0.02), new PVector(0.1, 0.1), random(0.995, 0.999), random(10, 30), new ColorCycle(random(0.1, 0.25), 0, 2, 4, random(180, 220)));
  
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
    //saveFrame("RainbowPartSmall/frames######.png");
  }  
}
