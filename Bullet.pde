ArrayList <Bullets> bullets = new ArrayList <Bullets>();
// int[] particles = new int[1000];
float aimX, aimY; // where the system is aiming
float bulletSpeed = 20;
float aimSpeed = 0.9; // how fast the aimpoint moves, 1 is instantaneous
float reloadTime = 5; // frames between shots
int framesSinceLastShot = 0;
int shotsSinceLastTracer = 0;
float anchorX, anchorY;
PVector prevMousePos;
PVector avgVelocity = new PVector(0, 0);
int velocitySampleSize = 20; // number of frames to average velocity over
float jitterAmount = 4.0; // Adjust this value for more or less jitter
float jitterX, jitterY;

class Bullet extends Floater {
    float x, y, vx, vy;
    Bullet(float x, float y, float angle) {
        this.x = x;
        this.y = y;
        this.vx = bulletSpeed * cos(angle);
        this.vy = bulletSpeed * sin(angle);
        this.colo[0] = 55;
        this.colo[1] = 55;
        this.colo[2] = 55;
        anchorX = 50;
        anchorY = height - 50;
        aimX = anchorX; // initialize aim point to anchor point
        aimY = anchorY;
        prevMousePos = new PVector(mouseX, mouseY);
    }

    void show() {
        stroke(colo[0], colo[1], colo[2]);
        strokeWeight(2);
        noFill();
        line(x, y, x - vx / 2, y - vy / 2);
    }

    void setColor(int r, int g, int b) {
      this.colo = color(r, g, b);
    }

    boolean isNearMouse() {
        return dist(x, y, mouseX, mouseY) < 10;
    }
}

void fire() {
    float angle = atan2(aimY - anchorY, aimX - anchorX);
    jitterX = random(-jitterAmount, jitterAmount);
    jitterY = random(-jitterAmount, jitterAmount);

    if (shotsSinceLastTracer >= 5) {
        Oddball newOddball = new Oddball(anchorX, anchorY, angle);
        newOddball.setColor(0, 255, 255);
        particles.add(newOddball);
        shotsSinceLastTracer = 0;
    } else {
        Particle newParticle = new Particle(anchorX, anchorY, angle);
        particles.add(newParticle);
        shotsSinceLastTracer++;
    }
}

