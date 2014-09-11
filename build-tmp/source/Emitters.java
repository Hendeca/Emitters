import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Emitters extends PApplet {

int nodesPerSide = 19,
    totalNodes = (nodesPerSide * 3) + 3, // Multiply it by three for three sides of the triangle. Add three for the three corner nodes
    cornerIterations = nodesPerSide + 1,
    i = 0; // For looping;

float triangleSide = 500, // Size in pixels of one side of the triangle
      startingAngle = 270, // Starting angle of projection for the emitters
      angleIncrement = 360 / totalNodes, // Amount to increment the angle by every node
      triangleRadius = (0.5f * sqrt(3) * triangleSide) / 2, // Distance from center to closest edge of triangle
      triangleSegment = (triangleSide / nodesPerSide); // Length of segment between two nodes
Emitter[] emitters;
PVector[] startPoints = new PVector[totalNodes];
float[] angles = new float[totalNodes],
        cornerPoints = new float[3];

public void setup() {
  frameRate(29.97f);
  size(1440, 900);
  background(0);
  emitters = new Emitter[totalNodes];

  // Loop through all angles based on the nodes per side of the triangle
  
  for(i = 0; i < totalNodes; i++) {
    angles[i] = startingAngle + (angleIncrement * i);

    if( i % cornerIterations == 0) {
      switch((i / cornerIterations)) {
       
        case 0:
          startPoints[i] = new PVector(0, -triangleRadius);
          break;
        case 1:
          startPoints[i] = new PVector(triangleSide / 2, triangleRadius);
          break;
        case 2:
          startPoints[i] = new PVector( triangleSide / -2, triangleRadius);
          break;
      }
    } else if(i > 0 && i < cornerIterations) {
      startPoints[i] = new PVector(cos(radians(60)) * (triangleSegment * i), -triangleRadius + (sin(radians(60)) * (triangleSegment * i) ));
    
    } else if(i > cornerIterations && i < (cornerIterations * 2)) {
      startPoints[i] = new PVector( (triangleSide / 2) - (triangleSegment * (i % cornerIterations)), triangleRadius);
    
    } else {
      startPoints[i] = new PVector( (triangleSide / -2) + cos(radians(300)) * (triangleSegment * (i % cornerIterations)) , triangleRadius + sin(radians(300)) * (triangleSegment * (i % cornerIterations)) );
    
    }

    
  }

  initEmitters();
}

public void initEmitters() {

  for ( i = 0; i < totalNodes; i++) {

    emitters[i] = new Emitter(startPoints[i], new PVector(random(0, 0),0), new PVector(0, 0), random(0.995f, 0.999f), 5, angles[i], new ColorCycle(random(0.4f, 0.5f), 0, 2, 4, random(220, 255)));

  }
}

public void draw() {
  background(0);
  for ( i = 0; i < emitters.length; i++) {
    pushMatrix();
    translate(width / 2, height / 2);
    emitters[i].update();
    emitters[i].draw();
    popMatrix();
    //saveFrame("TriangleShimmer/frames######.png");
  }  
}
class ColorCycle {
  
  int i = 0;
  float freq, oR, oG, oB, a;
  float[] rgbArray = new float[4];
  
  ColorCycle(float frequency, float offsetRed, float offsetGreen, float offsetBlue, float alpha) {
    freq = frequency;
    oR = offsetRed;
    oG = offsetGreen;
    oB = offsetBlue;
    a = alpha;
  }
  
  ColorCycle() {
    freq = 1;
    oR = 0;
    oG = 2;
    oB = 4;
    a = 255;
  }
  
  public float[] update() {
    rgbArray[0] = ((sin(radians(freq * i) + oR)) * 127) + 128;
    rgbArray[1] = ((sin(radians(freq * i) + oG)) * 127) + 128;
    rgbArray[2] = ((sin(radians(freq * i) + oB)) * 127) + 128;
    rgbArray[3] = a;
    i += 1;
    return rgbArray;
  }
}
class Emitter {

  int savedTime = millis(),
      i; // For looping
  float emitRate, // Frequency in milliseconds with which the Emitter spits out a particle
        friction, // Friction acting on the Emitter
        angleDivisor, // Emits particles at angles divisble by angleDivisor
        t; // Time
  PVector position, // The x and y coordinates of the Emitter
          velocity, // The velocity in pixels per frame
          acceleration, // The acceleration in pixels per frame squared
          accelSD,
          accelMean;
  ArrayList<Particle> particles = new ArrayList<Particle>(); // Dynamic array of all active particles
  float[] pColorVals; // To store the RGBA color values generated by the ColorCycle
  ColorCycle cycle; // Color cycle to change the colors of the particles
  
  Emitter(PVector position_, PVector velocity_, PVector acceleration_, float friction_, float emitRate_, float angleDivisor_, ColorCycle cycle_) {
    position = position_;
    velocity = velocity_;
    acceleration = acceleration_;
    angleDivisor = angleDivisor_;
    emitRate = emitRate_;
    friction = friction_;
    cycle = cycle_;
    pColorVals = cycle.update();
    savedTime = millis();

  }
  
  public void draw() {

    if(particles.size() > 0) {

      for(i = particles.size(); i-- != 0;) {
      
        Particle particle = particles.get(i);

        if(particle.position.x > (width / 2) || particle.position.x < (width / -2)) {
          particles.remove(i);
        }

        if(particle.position.y > (height / 2) || particle.position.y < (height / -2)) {
          particles.remove(i);
        }
        pushMatrix();
        translate(position.x, position.y);
        particle.update();
        particle.draw();
        popMatrix();
      }

    }
      
    t += 0.1f;
  }
  
  public void update() {
    
    velocity.add(acceleration);
    position.add(velocity);
    int passedTime = millis() - savedTime;
    if( passedTime >= emitRate) {
        emitParticle();
        savedTime = millis();
    }
  }
  
  public void emitParticle() {
      float pVelocity = random(8.1f, 10);
      float pAcceleration = random(-0.02f, 0.02f);
      float pFriction = friction;
      float pPeriod = 1;
      float pAmplitude = 20;
      float pAngle = angleDivisor;
      float pFadeRate = 10;
      int pStrokeWeight = (int)random(5, 10);
      
      pColorVals = cycle.update();

      particles.add(new Particle(new PVector(0, 0), pVelocity, pAcceleration, pAngle, pFadeRate, pPeriod, pAmplitude, pFriction, pColorVals, pStrokeWeight));
  }
}
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
  
  public void draw() {
    pushMatrix();
    strokeWeight(strokeWeight);
    fade();
    stroke(particleColors[0], particleColors[1], particleColors[2], particleColors[3]);
    point(position.x + perpendicular.x, position.y + perpendicular.y);
    popMatrix();
    t++;
  }
  
  public void update() {

    position.x += cos(angle) * velocity;
    position.y += sin(angle) * velocity;

    perpendicular = getPerpVector(new PVector(cos(angle) * velocity, sin(angle) * velocity));

    perpendicular.normalize();
    perpendicular.mult(sin(t / period) * amplitude);

    if(friction > 0) {
      position.mult(friction);
    }
    
  }

  public PVector getPerpVector(PVector v) {
    return new PVector(-v.y, v.x);
  }

  public void fade() {

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

  public void updateColor(float[] particleColors_) {

    particleColors = particleColors_;

  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "Emitters" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
