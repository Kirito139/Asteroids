Spaceship ship;
Star[] stars = new Star[100];
ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();
boolean wPressed, sPressed, aPressed, dPressed;

public void setup() {
  size(880, 660);
  frameRate(30);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  for (int i = 0; i < Math.random() * 4 + 8; i++) {
    asteroids.add(new Asteroid());
  }
  wPressed = sPressed = aPressed = dPressed = false;
  ship = new Spaceship(width / 2, height / 2);
}

public void draw() {
  background(0);
  for (int i = 0; i < stars.length; i++) {
    stars[i].show();
  }
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
}

public void keyCheck() {
  if (wPressed) {
    ship.accelerate(0.3);
  }

  if (sPressed) {
    ship.accelerate(-0.3);
  }

  if (aPressed) {
    ship.turn(-16);
  }

  if (dPressed) {
    ship.turn(16);
  }
}

public void keyPressed() {
  if (key == 'w') {
    wPressed = true;
  }

  if (key == 's') {
    sPressed = true;
  }

  if (key == 'a') {
    aPressed = true;
  }

  if (key == 'd') {
    dPressed = true;
  }

  if (key == 'e') {
    ship.jump();
    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Star();
    }
    asteroids.clear();
    for (int i = 0; i < Math.random() * 4 + 8; i++) {
      asteroids.add(new Asteroid());
    }
  }
}

public void keyReleased() {
  if (key == 'w') {
    wPressed = false;
  }

  if (key == 's') {
    sPressed = false;
  }

  if (key == 'a') {
    aPressed = false;
  }

  if (key == 'd') {
    dPressed = false;
  }
}
