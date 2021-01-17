ArrayList<Coin> coins;
ArrayList<Spider> spiders;
Player player;

PImage coinImg;
PImage playerImg;
PImage spiderImg;
PImage gunImg;
PImage bulletImg;

int winScore = 300;
boolean alive = true;
boolean won = true;

void setup() {
  size(800, 500);

  coinImg = loadImage("coin.png");
  playerImg = loadImage("player.png");
  playerImg.resize(38, 75);
  spiderImg = loadImage("spider.png");
  spiderImg.resize(75, 75);
  gunImg = loadImage("gun.png");
  gunImg.resize(75, 45);
  bulletImg = loadImage("bullet.png");
  bulletImg.resize(25, 5);

  coins = new ArrayList<Coin>();
  spiders = new ArrayList<Spider>();
  player = new Player();

  imageMode(CENTER);
  //frameRate(500); //speeds up game
}

void reset() {
  alive = true;
  coins = new ArrayList<Coin>();
  spiders = new ArrayList<Spider>();
  player = new Player();
}

void draw() {
  if (!alive) {
    fill(200);
    if (won) {
      textAlign(CENTER, CENTER);
      textSize(40);
      text("You won!", width/2, height/2);
    } else {
      textAlign(CENTER, CENTER);
      textSize(40);
      text("You died!", width/2, height/2);
    }
    textSize(20);
    text("Press r to restart", width/2, height/1.5);
  } else {

    background(51);

    if (random(100) < 1) {
      coins.add(new Coin());
    }
    if (random(100) < 1) {
      spiders.add(new Spider());
    }



    for (int i = spiders.size() - 1; i >= 0; i--) {
      if (spiders.size() == 0) {
        break;
      }

      Spider s = spiders.get(i);
      s.update();
      for (int j = player.gun.bullets.size() - 1; j >= 0; j--) {
        if (player.gun.bullets.size() == 0) {
          break;
        }
        Bullet b = player.gun.bullets.get(j);

        if (b.hitBullet(s.pos, spiderImg.width, spiderImg.height)) {
          spiders.remove(i);
          player.gun.bullets.remove(j);
          break;
        }
      }
      s.show();
    }

    for (int i = coins.size() - 1; i >= 0; i--) {
      Coin c = coins.get(i);
      c.checkPlayerHit(i);
      c.show();
    }

    player.stateSelection();
    //player.update();
    while (player.state != 0) {
      player.stateSelection();
    }
    player.show();
    text("" + round(frameRate) + "fps", 0, height - 10);
  }
}

void keyPressed() {
  if (!alive) {
    if (key == 'r') {
      reset();
    }
  }
}
