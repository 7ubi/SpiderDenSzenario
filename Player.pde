class Player {
  PVector pos = new PVector(width/2, height/1.5);
  PVector dir = new PVector(0.5, 0.5);
  float speed = 2;

  Gun gun = new Gun();

  float fov = 150;

  int state = 0;
  int searchIndex = 0;

  int w = 38;
  int h = 75;

  int score = 0;

  ArrayList<PVector> coinsInRange;
  ArrayList<PVector> searchPositions = new ArrayList<PVector>();
  ArrayList<PVector> spidersInRange;

  int time = 0;
  int coolDown = 1;

  Player() {
    for (int x = int(fov/2); x < width - playerImg.width/2; x += fov) {
      searchPositions.add(new PVector(x, fov/2));
      searchPositions.add(new PVector(x, height-fov/2));
    }
  }

  void stateSelection() {
    switch(state) {
    case 0:
      searchSpider();
      if (spidersInRange.size() > 0) {
        state = 1;
      } else {
        state = 3;
        time = 0;
      }

      break;
    case 1:
      PVector s = getClosest(spidersInRange);
      gun.getAngle(s);
      
      float angle = atan((pos.y - s.y) / (pos.x - s.x));
      if(pos.x - s.x > 0){
        angle += PI;
      }
      dir = PVector.fromAngle(angle + PI).mult(speed);
      state = 2;
      break;
    case 2:

      if (time % coolDown == 0) {
        gun.shoot();
      }
      time++;
      state = 0;
      break;
    case 3:
      searchCoin();
      if (coinsInRange.size() > 0) {
        state = 4;
      } else {
        state = 5;
      }
      break;
    case 4:
      turnTowards(getClosest(coinsInRange));
      state = 0;
      break;
    case 5:
      state = 6;
      break;
    case 6:
      turnTowards(searchPositions.get(searchIndex));

      state = 7;
      break;
    case 7:
      if (dist(pos.x, pos.y, searchPositions.get(searchIndex).x, searchPositions.get(searchIndex).y) < 3) {
        searchIndex = (searchIndex + 1) % searchPositions.size();
      }
      state = 0;
      break;
    }
  }

  void searchCoin() {
    coinsInRange = new ArrayList<PVector>();
    for (int i = 0; i < coins.size(); i++) {
      Coin c = coins.get(i);
      if (dist(c.pos.x, c.pos.y, pos.x, pos.y) < fov) {
        coinsInRange.add(c.pos);
      }
    }
  }

  void searchSpider() {
    spidersInRange = new ArrayList<PVector>();
    for (int i = 0; i < spiders.size(); i++) {
      Spider s = spiders.get(i);
      if (dist(s.pos.x, s.pos.y, pos.x, pos.y) < fov) {
        spidersInRange.add(s.pos);
      }
    }
  }

  void turnTowards(PVector p) {
    PVector po = new PVector(p.x, p.y);
    dir = po.sub(pos);
    dir.normalize();
    dir.x *= speed;
    dir.y *= speed;
  }

  PVector getClosest(ArrayList<PVector> list) {
    float closestRange = width * height;
    int closestIndex = 0;

    for (int i = 0; i < list.size(); i++) {
      PVector p = list.get(i);
      if (dist(pos.x, pos.y, p.x, p.y) < closestRange) {
        closestRange = dist(pos.x, pos.y, p.x, p.y);
        closestIndex = i;
      }
    }

    return list.get(closestIndex);
  }

  void update() {
    gun.update(pos);
    gun.show();

    pos.add(dir);

    pos.x = constrain(pos.x, 0, width - playerImg.width/2);
    pos.y = constrain(pos.y, 0, height - playerImg.height/2);
  }

  void show() {
    noFill();
    stroke(255);
    circle(pos.x, pos.y, fov*2);

    image(playerImg, pos.x, pos.y);

    textSize(30);
    textAlign(CORNER);
    text("score: " + score, 0, 30);
  }

  boolean hitPlayer(PVector p, int w1, int h1) {
    if (pos.x > p.x - w/2 - w1/2 && pos.x < p.x + w1/2 + w/2 && pos.y > p.y - h1/2 - h/2 && pos.y < p.y + h1/2 + h/2) {
      return true;
    }
    return false;
  }
}
