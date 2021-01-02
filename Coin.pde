class Coin{
  PVector pos = new PVector(random(width - coinImg.width), random(height - coinImg.height));
  
  void checkPlayerHit(int i){
    if(player.hitPlayer(pos, 30, 30)){
      player.score++;
      coins.remove(i);
      
      if(player.score >= winScore){
        alive = false;
        won = true;
      }
    }
  }
  
  void show(){
    image(coinImg, pos.x, pos.y);
  }
}
