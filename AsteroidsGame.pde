Spaceship ship;
AimCursor cursor;
Star[] stars = new Star[100];
ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();
ArrayList <Bullet> bullets = new ArrayList <Bullet>();
boolean wPressed, sPressed, aPressed, dPressed, spacePressed, upPressed,
downPressed, leftPressed, rightPressed;
float aimX, aimY, range, leadTime, leadX, leadY;
double shipX, shipY;
int cursorVX, cursorVY;

public void setup() {
  size(880, 660);
  frameRate(30);
  aimX = width / 2;
  aimY = height / 2;
  cursorVX = cursorVY = 0;
  for (int i = 0; i < stars.length; i++) { stars[i] = new Star(); }
  for (int i = 0; i < Math.random() * 4 + 8; i++) asteroids.add(new Asteroid());
  wPressed = sPressed = aPressed = dPressed = false;
  ship = new Spaceship(width / 2, height / 2);
  cursor = new AimCursor();
}

public void draw() {
  background(0);

  for (int i = 0; i < stars.length; i++) stars[i].show();
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).move();
    asteroids.get(i).show();

    if (asteroids.get(i).isNearShip(ship)) {
      asteroids.remove(i);
      asteroids.add(new Asteroid());
    }
  }
  keyCheck();
  ship.move();
  ship.show();
  shipX = ship.getX();
  shipY = ship.getY();

  // controls how fast the average velocity changes
  range = dist((float)shipX, (float)shipY, aimX, aimY);
  leadTime = range / bulletSpeed; // how far to lead by
  leadX = cursor.getX() + cursorVX * leadTime;
  leadY = cursor.getY() + cursorVY * leadTime;

  // calculate aim point coords
  aimX += (leadX - cursor.getX());
  aimY += (leadY - cursor.getY());

  framesSinceLastShot++;

  if (spacePressed && framesSinceLastShot >= reloadTime) {
    float angle = atan2(aimY - (float)shipY, aimX - (float)shipX);
    Bullet newBullet = new Bullet(ship, angle);
    bullets.add(newBullet);
    framesSinceLastShot = 0;
  } 

  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet p = bullets.get(i);
    p.move();
    p.show();

    // TODO: fade bullets each frame, fade level corresponds with damage.
    if (p.isOffScreen()) bullets.remove(i);

  }
  cursor.show();
}

public void keyCheck() {
  if (wPressed) ship.accelerate(0.3);
  if (sPressed) ship.accelerate(-0.3);
  if (aPressed) ship.turn(-16);
  if (dPressed) ship.turn(16);
  if (upPressed) cursor.up();
  if (downPressed) cursor.down();
  if (leftPressed) cursor.left();
  if (rightPressed) cursor.right();
}

public void keyPressed() {
  if (key == ' ') spacePressed = true;
  if (key == 'w') wPressed = true;
  if (key == 's') sPressed = true;
  if (key == 'a') aPressed = true;
  if (key == 'd') dPressed = true;

  if (key == 'e') {
    ship.jump();
    // TODO: replace stars one frame at a time.
    // TODO: implement cooldown timer.
    for (int i = 0; i < stars.length; i++) stars[i] = new Star();

    while (asteroids.size() > 0) asteroids.remove(0);
    
    for (int i = 0; i < Math.random() * 4 + 8; i++) {
      asteroids.add(new Asteroid());
    }
  }
  
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = true;
      cursorVY -= 15;
    }
    if (keyCode == DOWN) {
      downPressed = true;
      cursorVY += 15;
    }
    if (keyCode == LEFT) {
      leftPressed = true;
      cursorVX -= 15;
    }
    if (keyCode == RIGHT) {
      rightPressed = true;
      cursorVX += 15;
    }
  }
}

public void keyReleased() {
  if (key == 'w') wPressed = false;
  if (key == 's') sPressed = false;
  if (key == 'a') aPressed = false;
  if (key == 'd') dPressed = false;
  if (key == ' ') spacePressed = false;
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = false;
      cursorVY += 15;
    }
    if (keyCode == DOWN) {
      downPressed = false;
      cursorVY -= 15;
    }
    if (keyCode == LEFT) {
      leftPressed = false;
      cursorVX += 15;
    }
    if (keyCode == RIGHT) {
      rightPressed = false;
      cursorVX -= 15;
    }

  }
}
