class Star {
  float x, y, z;
  public Star() {
    x = (float) Math.random() * width;
    y = (float) Math.random() * height;
    z = (float) Math.random() * 2;
  }
  public void show() {
    fill(255);
    stroke(255);
    ellipse(x, y, z, z);
  }
}
