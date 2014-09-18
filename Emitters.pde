int nodesPerSide = 19, // Number of Emitters per side (not including corners)
    totalNodes = (nodesPerSide * 3) + 3, // Multiply it by three for three sides of the triangle. Add three for the three corner nodes
    cornerIterations = nodesPerSide + 1, // This is used for calculating where corners are when looping through the nodes
    i = 0; // For looping

float triangleSide = 500, // Size in pixels of one side of the triangle
      startingAngle = 270, // Starting angle of projection for the emitters
      angleIncrement = 360 / totalNodes, // Amount to increment the angle by every node
      triangleRadius = (0.5 * sqrt(3) * triangleSide) / 2, // Distance from center to closest edge of triangle
      triangleSegment = (triangleSide / nodesPerSide); // Length of segment between two nodes
Emitter[] emitters; // Array to hold Emitters
PVector[] startPoints = new PVector[totalNodes]; // Array of Emitter positions
float[] angles = new float[totalNodes], // Array of angles of particle trajectory
        cornerPoints = new float[3]; // Array for the 3 triangle corner points

void setup() {

  // Set up sketch properties
  frameRate(29.97);
  size(1440, 900);
  background(0);

  // Create our Emitters
  emitters = new Emitter[totalNodes];

  // Loop through all angles based on the nodes per side of the triangle
  
  for(i = 0; i < totalNodes; i++) {

    // Starting with the starting angle, increment for all 360 degrees
    angles[i] = startingAngle + (angleIncrement * i);

    // Test to see if the current node is a corner
    if( i % cornerIterations == 0) {
      switch((i / cornerIterations)) {
       
        // If it is a corner, figure out which corner it is and set its position
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

    // If it's not a corner, figure out which side the node is on and give it the proper position
    } else if(i > 0 && i < cornerIterations) {
      startPoints[i] = new PVector(cos(radians(60)) * (triangleSegment * i), -triangleRadius + (sin(radians(60)) * (triangleSegment * i) ));
    } else if(i > cornerIterations && i < (cornerIterations * 2)) {
      startPoints[i] = new PVector( (triangleSide / 2) - (triangleSegment * (i % cornerIterations)), triangleRadius);
    } else {
      startPoints[i] = new PVector( (triangleSide / -2) + cos(radians(300)) * (triangleSegment * (i % cornerIterations)) , triangleRadius + sin(radians(300)) * (triangleSegment * (i % cornerIterations)) );
    }

    
  }

  // Now that we have the locations of each node, create all of the Emitters
  initEmitters();
}

void initEmitters() {

  // Create our emitters
  for ( i = 0; i < totalNodes; i++) {

    emitters[i] = new Emitter(startPoints[i], new PVector(random(0, 0),0), new PVector(0, 0), random(0.995, 0.999), 5, angles[i]);

  }
}

void draw() {

  // Clear screen and draw each emitter
  background(0);
  for ( i = 0; i < emitters.length; i++) {
    pushMatrix();
    translate(width / 2, height / 2);
    emitters[i].update();
    emitters[i].draw();
    popMatrix();
  }
  //saveFrame("TrianglePulse/frames######.png");
}
