ArrayList<Spaceship> ships = new ArrayList<Spaceship>();
AimCursor aimcursor;
Star[] stars = new Star[100];
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
boolean wPressed, sPressed, aPressed, dPressed, spacePressed, upPressed,
downPressed, leftPressed, rightPressed, game_over;
float aimX, aimY; // , range, leadTime, leadX, leadY;
double shipX, shipY;
int cursorVX, cursorVY, asteroidTimer;
Spaceship ship;

public void setup() {
  size(880, 660);
  frameRate(30);
  ships.add(new Spaceship(width / 2, height / 2));
  ship = ships.get(0);
  aimX = width / 2;
  aimY = height / 2;
  cursorVX = cursorVY = 0;
  for (int i = 0; i < stars.length; i++) { stars[i] = new Star(); }
  for (int i = 0; i < Math.random() * 4 + 8; i++) asteroids.add(new Asteroid());
  wPressed = sPressed = aPressed = dPressed = false;
  ship = new Spaceship(width / 2, height / 2);
  aimcursor = new AimCursor();
  asteroidTimer = 0;
}

public void draw() {
  background(0);

  if (asteroidTimer > 300) {
    asteroids.add(new Asteroid());
    asteroidTimer = 0;
  }

  for (int i = 0; i < stars.length; i++) stars[i].show();
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).move();
    asteroids.get(i).show();

    if (asteroids.get(i).isNearShip(ship)) {
      // asteroids.remove(i);
      ships.remove(0);
      game_over = true;
      noLoop();
      // asteroids.add(new Asteroid());
    }
  }
  keyCheck();
  ship.move();
  ship.show();
  shipX = ship.getX();
  shipY = ship.getY();

  // controls how fast the average velocity changes
  // range = dist((float)shipX, (float)shipY, aimX, aimY);
  // leadTime = range / bulletSpeed; // how far to lead by
  // leadX = cursor.getX() + cursorVX * leadTime;
  // leadY = cursor.getY() + cursorVY * leadTime;

  // calculate aim point coords
  // aimX += (leadX - cursor.getX());
  // aimY += (leadY - cursor.getY());

  framesSinceLastShot++;

  if (spacePressed && framesSinceLastShot >= reloadTime) {
    // float angle = atan2(aimY - (float)shipY, aimX - (float)shipX);
    Bullet newBullet = new Bullet(ship, aimcursor);
    bullets.add(newBullet);
    framesSinceLastShot = 0;
  } 

  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet p = bullets.get(i);
    p.move();
    p.show();
    // Check for collision with asteroids
    for (int j = asteroids.size() - 1; j >= 0; j--) {
      Asteroid a = asteroids.get(j);
      if (dist(p.x, p.y, (float)a.centerX, (float)a.centerY) < 18) {
        // Remove the asteroid and the bullet
        asteroids.remove(j);
        bullets.remove(i);
        break;
      }
    }

    // TODO: fade bullets each frame, fade level corresponds with damage.
    if (p.isOffScreen()) bullets.remove(i);

  }
  aimcursor.show();
  asteroidTimer++;
}

public void keyCheck() {
  if (wPressed) ship.accelerate(0.3);
  if (sPressed) ship.accelerate(-0.3);
  if (aPressed) ship.turn(-16);
  if (dPressed) ship.turn(16);
  if (upPressed) aimcursor.up();
  if (downPressed) aimcursor.down();
  if (leftPressed) aimcursor.left();
  if (rightPressed) aimcursor.right();
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
  
  if (key == 'k') {
    upPressed = true;
    cursorVY -= 15;
  }
  if (key == 'j') {
    downPressed = true;
    cursorVY += 15;
  }
  if (key == 'h') {
    leftPressed = true;
    cursorVX -= 15;
  }
  if (key == 'l') {
    rightPressed = true;
    cursorVX += 15;
  }
}

public void keyReleased() {
  if (key == 'w') wPressed = false;
  if (key == 's') sPressed = false;
  if (key == 'a') aPressed = false;
  if (key == 'd') dPressed = false;
  if (key == ' ') spacePressed = false;
  if (key == 'k') {
    upPressed = false;
    cursorVY += 15;
  }
  if (key == 'j') {
    downPressed = false;
    cursorVY -= 15;
  }
  if (key == 'h') {
    leftPressed = false;
    cursorVX += 15;
  }
  if (key == 'l') {
    rightPressed = false;
    cursorVX -= 15;
  }
}
