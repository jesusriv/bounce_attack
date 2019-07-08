import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
//import org.jbox2d.dynamics.contacts.*;

//import processing.sound.*;

//SoundFile backaudio;
//SoundFile over;
String back = "background.wav";
String game = "over.wav";
String path;

Box2DProcessing box2d;
PImage bckgrnd;
PImage img;
PImage brick;

Surface surface;
Obj2 box;
Boundary w1;
Boundary w2;
Boundary ceil;

int count;

ArrayList<Bullet> smBullets;
ArrayList<Bullet> mdBullets;

void setup() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -90);
  //box2d.listenForCollisions();
  size(791, 400);
  
  bckgrnd = loadImage("back.jpg");
  
  brick = loadImage("brick.jpg");

  surface = new Surface(width/2, height, width, 90);
  w1 = new Boundary(0, height - 150, 10, 210);
  w2 = new Boundary(width, height - 150, 10, 210);
  ceil = new Boundary(width/2, 0, width, 10);
  box = new Obj2();
  smBullets = new ArrayList<Bullet>();
  mdBullets = new ArrayList<Bullet>();
  smBullets.add(new Bullet(15, 0.1));
  smBullets.add(new Bullet(15, 0.1));

  path = sketchPath(back);
  //backaudio = new SoundFile(this, path);
  //backaudio.play();
  count = 0;

  path = sketchPath(game);
  //over = new SoundFile(this, path);
}

void draw() {
  box2d.step();
  background(bckgrnd);

  fill(255);
  textSize(20);
  text("Points:", 10, 30);
  fill(255);
  textSize(20);
  text(count, 80, 30);

  for (int i = 0; i < smBullets.size(); i++) {
    smBullets.get(i).display();
    if (smBullets.get(i).done()) {
      smBullets.remove(i);
      count++;
      mdBullets.add(new Bullet(30, 0.05));
      mdBullets.add(new Bullet(30, 0.05));
    }
  } 

  for (int i = 0; i < mdBullets.size(); i++) {
    mdBullets.get(i).display(); 
    if (mdBullets.get(i).done()) {
      mdBullets.remove(i);
      count += 2;
      smBullets.add(new Bullet(15, 0.1));
      smBullets.add(new Bullet(15, 0.1));
    }
  } 

  Vec2 pos = box2d.getBodyPixelCoord(box.body);
  if (pos.x > width) {
    box.destroy();
    //over.play();
    //backaudio.stop();
    fill(0);
    textSize(100);
    text("Game Over", 120, 200);
    noLoop();
  }
  if (pos.x < 0) {
    box.destroy();
    //over.play();
    //backaudio.stop();
    fill(0);
    textSize(100);
    text("Game Over", 120, 200);
    noLoop();
  }

  surface.display();
  box.display();

  w1.display();
  w2.display();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      Vec2 w = new Vec2(-10000, 0);
      box.applyForce(w);
    } else if (keyCode == RIGHT) {
      Vec2 w = new Vec2(10000, 0);
      box.applyForce(w);
    } else if (keyCode == DOWN) {
      Vec2 w = new Vec2(0, -10000);
      box.applyForce(w);
    } else if (keyCode == UP ) {
      Vec2 w = new Vec2(0, 8000);
      box.applyForce(w);
    } 
  } else if (key == 'z') {
    box2d.setGravity(0, -20);
  }
}

//// Collision event functions!
//void beginContact(Contact cp) {
//  // Get both fixtures
//  Fixture f1 = cp.getFixtureA();
//  Fixture f2 = cp.getFixtureB();
//  // Get both bodies
//  Body b1 = f1.getBody();
//  Body b2 = f2.getBody();

//  // Get our objects that reference these bodies
//  Object o1 = b1.getUserData();
//  Object o2 = b2.getUserData();

//  if (o1.getClass() == Bullet.class && o2.getClass() == Bullet.class) {
//    Bullet p1 = (Bullet) o1;
//    p1.change();
//    Bullet p2 = (Bullet) o2;
//    p2.change();
//  }
//}

//void endContact(Contact cp) {
//}
