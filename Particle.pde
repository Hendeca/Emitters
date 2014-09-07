class Particle {

  int strokeWeight;
  PVector position, // The x, y pixel coordinates of the particle
          velocity, // Velocity in pixels per frame of the particle
          acceleration; // Acceleration in pixels per frame squared
  float friction; // Amount of friction acting on the particle
  float[] colorVals;
  
  Particle(PVector position_, PVector velocity_, PVector acceleration_, float friction_, float[] colorVals_, int strokeWeight_) {
    
    colorVals = colorVals_;
    strokeWeight = strokeWeight_;
    position = position_;
    velocity = velocity_;
    acceleration = acceleration_;
    friction = friction_;
  }
  
  void draw() {
    update();
    pushMatrix();
    strokeWeight(strokeWeight);
    stroke(colorVals[0], colorVals[1], colorVals[2], colorVals[3]);
    popMatrix();
    point(position.x, position.y);

  }
  
  void update() {
    acceleration.mult(friction);
    velocity.add(acceleration);
    position.add(velocity);
  }
}
