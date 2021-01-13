class Bullet{
  PVector pos;
  float angle;
  float speed = 8;
  
  Bullet(PVector pos, float angle){
    this.pos = pos;
    this.angle = angle;
  }
  
  void update(){
    pos.x -= speed * cos(angle);
    pos.y -= speed * sin(angle);
    
  }
  
  boolean hitBullet(PVector p, int w1, int h1) {
    if (pos.x > p.x - w1/2 && pos.x < p.x + w1/2 && pos.y > p.y - h1/2 && pos.y < p.y + h1/2) {
      return true;
    }
    return false;
  }
  
  void show(){
    pushMatrix();
    imageMode(CORNER);
    translate(pos.x, pos.y);
    rotate(angle);
    image(bulletImg, 0, 0);
    imageMode(CENTER);
    popMatrix();
  }
}
