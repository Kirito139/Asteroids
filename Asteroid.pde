class Asteroid extends Floater {
  public double rotSpeed;
  protected double x, y;
  public Asteroid() {
    x = Math.random() * width;
    y = Math.random() * height;
    rotSpeed = Math.random() * 4 - 2;
    colo = color(150, 75, 0);
    centerX = x;
    centerY = y;
    vx = Math.random() * 4 - 2;
    vy = Math.random() * 4 - 2;
    heading = Math.random() * 360;
    vertices = 11;
    verticesX = new int[vertices];
    verticesY = new int[vertices];
    verticesX[0] = -8;
    verticesY[0] = -6;
    
    verticesX[1] = -4;
    verticesY[1] = -8;

    verticesX[2] = 5;
    verticesY[2] = -6;

    verticesX[3] = 8;
    verticesY[3] = 2;

    verticesX[4] = 3;
    verticesY[4] = 5;

    verticesX[5] = 2;
    verticesY[5] = 8;

    verticesX[6] = -2;
    verticesY[6] = 7;

    verticesX[7] = -5;
    verticesY[7] = 7;

    verticesX[8] = -7;
    verticesY[8] = 8;

    verticesX[9] = -8;
    verticesY[9] = -1;

    verticesX[10] = -7;
    verticesY[10] = -3;
  }
  public boolean isNearShip(Spaceship ship) {
    return dist((float)centerX, (float)centerY, (float)ship.centerX,
    (float)ship.centerY) < 22;
  }
  public void show () { // Draws the floater at the current position
    noFill();
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
  public void move () { // move the asteroid in the current direction of travel
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
    else if (centerY < 0) {
      centerY = height;
    }
    turn(rotSpeed);
  }  
}

