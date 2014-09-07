class Particle {

  PVector position, // The x, y pixel coordinates of the particle
          velocity, // Velocity in pixels per frame of the particle
          acceleration; // Acceleration in pixels per frame squared
  float friction; // Amount of friction acting on the particle
  
  Particle(PVector position_, PVector velocity_, PVector acceleration_, float friction_) {
    
    // Set all class variables 
    position = position_;
    velocity = velocity_;
    acceleration = acceleration_;
    friction = friction_;
  }
  
  void draw() {
    update();
    point(position.x, position.y);
  }
  
  void update() {
    acceleration.mult(friction);
    velocity.add(acceleration);
    position.add(velocity);
  }
}
