class Emitter {

  int savedTime, // Used to detect how many milliseconds have passed
      i; // Variable for looping
  float frequency, // Frequency in milliseconds with which the Emitter spits out a particle
        friction;
  PVector position, // The x and y coordinates of the Emitter
          velocity, // The velocity in pixels per frame
          acceleration, // The acceleration in pixels per frame squared
          velSD, // The standard deviation for the velocity
          velMean, // Mean of the veloctity. Same deal for all following PVector declarations
          accelSD,
          accelMean;
  Particle[] particles = new Particle[1]; // Dynamic array of all active particles
  RNG rng = new RNG();
  float[] colorVals; // To store the RGBA color values generated by the ColorCycle
  ColorCycle cycle; // Color cycle to change the colors of the particles
  
  Emitter(PVector position_, PVector velocity_, PVector acceleration_, PVector velSD_, PVector velMean_, PVector accelSD_, PVector accelMean_, float friction_, float frequency_, ColorCycle cycle_) {
    position = position_;
    velocity = velocity_;
    acceleration = acceleration_;
    frequency = frequency_;
    velSD = velSD_;
    velMean = velMean_;
    accelSD = accelSD_;
    accelMean = accelMean_;
    friction = friction_;
    cycle = cycle_;
    savedTime = millis();
    initParticles();
  }
  
  void draw() {
    
    for(i = 0; i < particles.length; i++) {
      colorVals = cycle.update();
      stroke(colorVals[0], colorVals[1], colorVals[2], colorVals[3]);
      if(particles[i].position.x > width || particles[i].position.x < 0) {
        // Remove particles here
      }
      
      pushMatrix();
      translate(position.x, position.y);
      particles[i].draw();
      popMatrix();
    }
      
  }
  
  void update() {
    
    velocity.add(acceleration);
    position.add(velocity);
    int passedTime = millis() - savedTime;
    if( passedTime >= frequency) {
        emitParticle();
        savedTime = millis();
    }
    frequency -= 0.5;
  }
  
  void emitParticle() {
      PVector pVelocity = new PVector(random(-3, 3), random(-3, 3));
      PVector pAcceleration = new PVector(random(-0.100, 0.100), random(-0.100, 0.100));
      float pFriction = friction;

      particles = (Particle[]) append(particles, new Particle(new PVector(0, 0), pVelocity, pAcceleration, pFriction));
  }
  
  void initParticles() {
    PVector pVelocity = new PVector(random(-3, 3), random(-3, 3));
    PVector pAcceleration = new PVector(random(-0.100, 0.100), random(-0.100, 0.100));
    float pFriction = friction;
    
    particles[0] = new Particle(new PVector(0, 0), pVelocity, pAcceleration, pFriction);
  }  
}