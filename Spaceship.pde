class Spaceship extends Floater {
  public Spaceship(int startX, int startY) {
    colo = color(0, 255, 255);
    centerX = startX; // width / 2;
    centerY = startY; // height / 2;
    vx = 0;
    vy = 0;
    heading = 0;
    vertices = 4;
    verticesX = new int[vertices];
    verticesY = new int[vertices];
    verticesX[0] = -8;
    verticesY[0] = -8;
    verticesX[1] = 16;
    verticesY[1] = 0;
    verticesX[2] = -8;
    verticesY[2] = 8;
    verticesX[3] = -2;
    verticesY[3] = 0;
  }

  public void show() { // Draws the ship at the current position
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
    // TODO: draw rocket plumes

    // "unrotate" and "untranslate" in reverse order
    rotate(-1 * dRadians);
    translate(-1 * (float)centerX, -1 * (float)centerY);
  }
  public void jump() {
    vx = 0;
    vy = 0;
    heading = Math.random() * 360;
    centerX = Math.random() * width;
    centerY = Math.random() * height;
  }
  public double getX() {
    return centerX;
  }
  public double getY() {
    return centerY;
  }
}
