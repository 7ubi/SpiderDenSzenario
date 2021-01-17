class Gun {
  PVector pos;
  float angle;

  ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  void shoot() {
    bullets.add(new Bullet(pos, angle));
  }

  void update(PVector pos) {
    this.pos = new PVector(pos.x - 15, pos.y);
  }

  void getAngle(PVector p) {
    angle = atan((pos.y - p.y) / (pos.x - p.x));
    if (pos.x - p.x < 0) {
      angle += PI;
    }
  }

  void show() {
    for (Bullet b : bullets) {
      b.update();
      b.show();
    }

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    image(gunImg, 0, 0);
    popMatrix();
  }
}
