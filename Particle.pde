class Particle {

  int strokeWeight,
      t = 0,
      savedTime = millis(); // Time
  PVector position, // The x, y pixel coordinates of the particle
          velocity,
          sineVel; // Acceleration in pixels per frame squared
  float friction, // Amount of friction acting on the particle
        frequency,
        amplitude,
        angle,
        acceleration,
        fadeRate = 3;
  float[] colorVals;
  
  Particle(PVector position_, float velocity_, float acceleration_, float angle_, float frequency_, float amplitude_, float friction_, float[] colorVals_, int strokeWeight_) {
    
    colorVals = colorVals_;
    strokeWeight = strokeWeight_;
    position = position_;
    angle = angle_;
    velocity = new PVector(velocity_ * sin(angle), velocity_ * cos(angle));
    acceleration = acceleration_;
    friction = friction_;
    frequency = frequency_;
    amplitude = amplitude_;
  }
  
  void draw() {
    pushMatrix();
    strokeWeight(strokeWeight);
    translate(position.x, position.y);
    stroke(colorVals[0], colorVals[1], colorVals[2], colorVals[3]);
    point(0, 0);
    popMatrix();
    t++;
  }
  
  void update() {

    position.add(velocity);
    if(friction > 0) {
      position.mult(friction);
    }
    
  }

  void oscillate() {

    sineVel = new PVector((amplitude * sin((angle + 90)) * sin(t / (1 / frequency))), (amplitude * cos((angle + 90)) * sin(t / (1 / frequency))));
    position.add(sineVel);

  }

  void fade() {
    colorVals[3] -= fadeRate;
  }

  void updateColor(float[] colorVals_) {

    colorVals = colorVals_;

  }
}