class Spider{
  PVector pos = new PVector(0, 0);
  PVector dir;
  PVector dirToPlayer  = new PVector(0, 0);
  float angle = random(-PI, PI);
  
  float speed = 3;
  
  Spider(){
    boolean notHit = false;
    
    while(!notHit){
      pos = new PVector(random(width), random(height));
      notHit = !player.hitPlayer(pos, spiderImg.width * 3, spiderImg.height * 3);
    }
  }
  
  void update(){
    angle += random(-0.2, 0.2);
    dir = PVector.fromAngle(angle).mult(speed);
    float angleToPlayer = atan((pos.y - player.pos.y) / (pos.x - player.pos.x));
    if(pos.x - player.pos.x > 0){
      angleToPlayer += PI;
    }
    dirToPlayer = PVector.fromAngle(angleToPlayer).mult(speed);
    
    pos.add(dir);
    pos.add(dirToPlayer);
    pos.x = constrain(pos.x, spiderImg.width/2, width - spiderImg.width/2);
    pos.y = constrain(pos.y, spiderImg.height/2, height - spiderImg.height/2);
    if(pos.x == spiderImg.width/2 || pos.x == width - spiderImg.width/2 || pos.y == spiderImg.height/2 || pos.y == height - spiderImg.height/2){
      angle += PI;
    }
    hitPlayer();
  }
  
  void show(){
    image(spiderImg, pos.x, pos.y);
  }
  
  void hitPlayer(){
    if(player.hitPlayer(pos, spiderImg.width, spiderImg.height)){
      alive = false;
      won = false;
    }
  }
}
