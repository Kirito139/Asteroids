public float bulletSpeed = 20;
public float reloadTime = 5; // frames between shots
public int framesSinceLastShot = 0;

class Bullet extends Floater {
  float x, y, vx, vy;
  Bullet(Spaceship ship, float angle) {
      this.x = (float)ship.getX();
      this.y = (float)ship.getY();
      this.vx = bulletSpeed * cos(angle);
      this.vy = bulletSpeed * sin(angle);
      this.colo = color(255, 0, 255);
  }

  void show() {
    stroke(colo);
    strokeWeight(2);
    noFill();
    line(x, y, x - vx / 2, y - vy / 2);
  }

  void move() {
    x += vx;
    y += vy;
  }
  public boolean isNearMouse() { return dist(x, y, mouseX, mouseY) < 10; }
  public boolean isOffScreen() {
    return x < 0 || x > width || y < 0 || y > height;
  }
}
