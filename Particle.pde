class Particle {

  int strokeWeight,
      t = 0; // Time
  PVector position, // The x, y pixel coordinates of the particle
          velocity, // Velocity in pixels per frame of the particle
          acceleration,
          newPosition; // Acceleration in pixels per frame squared
  float friction,
        slope,
        angle,
        frequency,
        amplitude; // Amount of friction acting on the particle
  float[] colorVals;
  
  Particle(PVector position_, PVector velocity_, PVector acceleration_, float frequency_, float amplitude_, float friction_, float[] colorVals_, int strokeWeight_) {
    
    colorVals = colorVals_;
    strokeWeight = strokeWeight_;
    position = position_;
    velocity = velocity_;
    acceleration = acceleration_;
    friction = friction_;
    frequency = frequency_;
    amplitude = amplitude_;
    slope = velocity.x / velocity.y;
    angle = atan(slope);
  }
  
  void draw() {
    update();
    pushMatrix();
    strokeWeight(strokeWeight);
    stroke(colorVals[0], colorVals[1], colorVals[2], colorVals[3]);
    popMatrix();
    pushMatrix();
    rotate(radians(angle));
    position.add(new PVector(0, sin(t * frequency) * amplitude));
    point(position.x, position.y);
    popMatrix();
    t++;
  }
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    position.mult(friction);
  }
}