class Particle {

  int strokeWeight, // Weight of the stroke of each particle
      t = 0; // Time
  PVector position, // Position of this particle
          perpendicular, // Vector perpendicular to the current angle of motion
          center; // Center point of the stage
  float friction, // Friction applied to Particle movement
        velocity, // Velocity of Particle (not a PVector because it is applied to an angle)
        period, // Period of sinusoidal oscillation Frequency is 1 / period
        amplitude, // Amplitude of sinusoidal oscillation
        angle, // Angle of velocity of Particle
        acceleration, // Acceleration of Particle
        fadeRate; // Rate at which Particle's opacity fades in and out
  float[] particleColors;
  
  Particle(PVector position_, float velocity_, float acceleration_, float angle_, float fadeRate_, float period_, float amplitude_, float friction_, float[] particleColors_, int strokeWeight_) {
    
    // Instantiate member variables
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

    // Draw the Particle relative to the center of the screen which the proper color
    pushMatrix();
    strokeWeight(strokeWeight);
    stroke(particleColors[0], particleColors[1], particleColors[2], particleColors[3]);
    point(position.x + perpendicular.x, position.y + perpendicular.y);
    popMatrix();

    // Increment time
    t++;
  }
  
  void update() {

    // Update the position of the particle based on the velocity and angle of motion
    position.x += cos(angle) * velocity;
    position.y += sin(angle) * velocity;

    // Get a vector of velocity perpendicular to the Particle's angle
    perpendicular = getPerpVector(new PVector(cos(angle) * velocity, sin(angle) * velocity));

    // Create sinusoidal movement based on the amplitude of oscillation
    perpendicular.normalize();
    perpendicular.mult(sin(t / period) * amplitude);

    // If friction is greater than 0, apply it to the position
    if(friction > 0) {
      position.mult(friction);
    }
    
  }

  // Get a vector representing an angle perpendicular to the Particle's angle of velocity
  PVector getPerpVector(PVector v) {
    return new PVector(-v.y, v.x);
  }

  // Fade the opacity in and out
  void fade() {

    if(particleColors[3] <= 60) {
      particleColors[3] = 60;
      if(fadeRate < 0) {
        fadeRate *= -1;
      }
    }

    if(particleColors[3] >= 255) {
      particleColors[3] = 248;
      if(fadeRate > 0) {
        fadeRate *= -1;
      }
    }

    particleColors[3] -= fadeRate;

  }

  //Change the color of the particle (useful if color needs to be changed externally)
  void updateColor(float[] particleColors_) {

    particleColors = particleColors_;

  }
}