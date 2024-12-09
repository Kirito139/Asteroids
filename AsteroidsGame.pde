Spaceship ship;
Star[] stars = new Star[100];
boolean wPressed, sPressed, aPressed, dPressed;

public void setup() {
  size(880, 660);
  frameRate(120);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  wPressed = sPressed = aPressed = dPressed = false;
  ship = new Spaceship(width / 2, height / 2);
}

public void draw() {
  background(0);
  for (int i = 0; i < stars.length; i++) {
    stars[i].show();
  }
  keyCheck();
  ship.move();
  ship.show();
}
public void keyCheck() {
  if (wPressed) {
    ship.accelerate(0.1);
  }
  if (sPressed) {
    ship.accelerate(-0.1);
  }
  if (aPressed) {
    ship.turn(-1);
  }
  if (dPressed) {
    ship.turn(1);
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
