class Particle {

  int strokeWeight,
      t = 0;
  PVector position,
          perpendicular,
          center;
  float friction,
        velocity,
        frequency,
        period,
        amplitude,
        angle,
        newAngle,
        acceleration,
        oscillation,
        fadeRate;
  float[] particleColors;
  
  Particle(PVector position_, float velocity_, float acceleration_, float angle_, float fadeRate_, float period_, float amplitude_, float friction_, float[] particleColors_, int strokeWeight_) {
    
    particleColors = particleColors_;
    strokeWeight = strokeWeight_;
    position = position_;
    angle = radians(angle_);
    velocity = velocity_;
    acceleration = acceleration_;
    fadeRate = fadeRate_;
    friction = friction_;
    period = period_;
    amplitude = amplitude_;
    center = new PVector(width/2, height/2);
  }
  
  void draw() {
    pushMatrix();
    strokeWeight(strokeWeight);
    fade();
    stroke(particleColors[0], particleColors[1], particleColors[2], particleColors[3]);
    point(position.x + perpendicular.x, position.y + perpendicular.y);
    popMatrix();
    t++;
  }
  
  void update() {

    position.x += cos(angle) * velocity;
    position.y += sin(angle) * velocity;

    perpendicular = getPerpVector(new PVector(cos(angle) * velocity, sin(angle) * velocity));

    perpendicular.normalize();
    perpendicular.mult(sin(t / period) * amplitude);

    if(friction > 0) {
      position.mult(friction);
    }
    
  }

  PVector getPerpVector(PVector v) {
    return new PVector(-v.y, v.x);
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