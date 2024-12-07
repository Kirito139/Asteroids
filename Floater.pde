class Floater {
  protected int vertices; // the number of vertices, a triangular floater has 3
  protected int[] verticesX;
  protected int[] verticesY;
  protected int colo;
  protected double centerX, centerY; // holds center coordinates
  protected double vx, vy; // holds x and y velocity
  protected double heading; // holds current heading in degrees

  // Accelerates the floater in the direction it's pointing (heading)
  public void accelerate (double dAmount) {
    // convert the current direction the floater is pointing to radians
    double dRadians = heading * (Math.PI / 180);
    // change coordinates of direction of travel
    vx += ((dAmount) * Math.cos(dRadians));
    vy += ((dAmount) * Math.sin(dRadians));
  }
  public void turn (double degreesOfRotation) {
    // rotates the floater by a given number of degrees
    heading += degreesOfRotation;
  }
  public void move () { // move the floater in the current direction of travel
    // change the x and y coordinates by vx and vy
    centerX += vx;
    centerY += vy;

    // wrap around screen
    if (centerX > width) {
      centerX = 0;
    } else if (centerX < 0) {
      centerX = width;
    } if (centerY > height) {
      centerY = 0;
    }

    else if (centerY < 0)
    {
      centerY = height;
    }
  }
  public void show () { // Draws the floater at the current position
    fill(colo);
    stroke(colo);

    // translate the (x,y) center of the ship to the correct position
    translate((float)centerX, (float)centerY);

    // convert degrees to radians for rotate()
    float dRadians = (float)(heading * (Math.PI / 180));

    // rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);

    // draw the polygon
    beginShape();
    for (int nI = 0; nI < vertices; nI++) {
      vertex(verticesX[nI], verticesY[nI]);
    }
    endShape(CLOSE);

    // "unrotate" and "untranslate" in reverse order
    rotate(-1 * dRadians);
    translate(-1 * (float)centerX, -1 * (float)centerY);
  }
}
