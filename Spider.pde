class Spider{
  PVector pos = new PVector(random(width/1.5), random(height / 2));
  PVector dir = new PVector(random(1), random(1));
  
  void update(){
    dir.x += random(-1, 1);
    dir.y += random(-1, 1);
    dir.normalize();
    
    pos.add(dir);
    
    pos.x = constrain(pos.x, spiderImg.width/2, width - spiderImg.width/2);
    pos.y = constrain(pos.y, spiderImg.height/2, height - spiderImg.height/2);
    
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
