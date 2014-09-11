int nodesPerSide = 19,
    totalNodes = (nodesPerSide * 3) + 3, // Multiply it by three for three sides of the triangle. Add three for the three corner nodes
    cornerIterations = nodesPerSide + 1,
    i = 0; // For looping;

float triangleSide = 500, // Size in pixels of one side of the triangle
      startingAngle = 270, // Starting angle of projection for the emitters
      angleIncrement = 360 / totalNodes, // Amount to increment the angle by every node
      triangleRadius = (0.5 * sqrt(3) * triangleSide) / 2, // Distance from center to closest edge of triangle
      triangleSegment = (triangleSide / nodesPerSide); // Length of segment between two nodes
Emitter[] emitters;
PVector[] startPoints = new PVector[totalNodes];
float[] angles = new float[totalNodes],
        cornerPoints = new float[3];

void setup() {
  frameRate(29.97);
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

void initEmitters() {

  for ( i = 0; i < totalNodes; i++) {

    emitters[i] = new Emitter(startPoints[i], new PVector(random(0, 0),0), new PVector(0, 0), random(0.995, 0.999), 5, angles[i], new ColorCycle(random(0.4, 0.5), 0, 2, 4, random(220, 255)));

  }
}

void draw() {
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
