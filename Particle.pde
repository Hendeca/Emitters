class Particle {

  int strokeWeight,
      t = 0;
  PVector position,
          velocity,
          sineVel;
  float friction,
        frequency,
        period,
        amplitude,
        angle,
        acceleration,
        fadeRate;
  float[] particleColors;
  
  Particle(PVector position_, float velocity_, float acceleration_, float angle_, float fadeRate_, float period_, float amplitude_, float friction_, float[] particleColors_, int strokeWeight_) {
    
    particleColors = particleColors_;
    strokeWeight = strokeWeight_;
    position = position_;
    angle = angle_;
    velocity = new PVector(velocity_ * sin(angle), velocity_ * cos(angle));
    acceleration = acceleration_;
    fadeRate = fadeRate_;
    friction = friction_;
    period = period_;
    amplitude = amplitude_;
  }
  
  void draw() {
    pushMatrix();
    strokeWeight(strokeWeight);
    translate(position.x, position.y);
    fade();
    stroke(particleColors[0], particleColors[1], particleColors[2], particleColors[3]);
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

    frequency = 1 / period;
    sineVel = new PVector((amplitude * (sin((angle + 90)))) * sin(t * frequency) , (amplitude * (cos((angle + 90)))) * sin(t * frequency));
    position.add(sineVel);

  }

  void fade() {

    if(particleColors[3] <= 30) {
      particleColors[3] = 30;
      fadeRate *= -1;
    }

    if(particleColors[3] >= 200) {
      particleColors[3] = 200;
      fadeRate *= -1;
    }

    particleColors[3] -= fadeRate;

  }

  void updateColor(float[] particleColors_) {

    particleColors = particleColors_;

  }
}