float x, y;
class AimCursor {
  public AimCursor() {
    x = width/2;
    y = height/2;
  }
  public void draw() {
    stroke(255, 0, 0);
    strokeWeight(0.8);
    ellipse(aimX, aimY, 16, 16);
    line(aimX, aimY + 8, aimX, aimY + 5);
    line(aimX, aimY - 8, aimX, aimY - 5);
    line(aimX + 8, aimY, aimX + 5, aimY);
    line(aimX - 8, aimY, aimX - 5, aimY);
  }
  public void changeX(float change) { x += change; }
  public void changeY(float change) { y += change; }
}
