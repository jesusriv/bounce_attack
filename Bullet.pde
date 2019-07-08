class Bullet {
  Body body;
  BodyDef bd;
  PImage img;
  //SoundFile file;
  //put your audio file name here
  String audioName = "bump.wav";
  String path;
  
  float x,y,r,d;
  
  color col;
  
  Bullet(float r, float d) {
    x = random(width);
    y = 0;
    this.r = r;
    this.d = d;
    path = sketchPath(audioName);
    //file = new SoundFile(more_practice.this, path);    
    img = loadImage("ninja.png");
    makeBody(x, y, r);
    body.setUserData(this);
    
    col = color(255);
  }
  
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(col);
    //stroke(0);
    //strokeWeight(1);
    //ellipse(0,0,r*2,r*2);
    imageMode(CENTER);
    image(img, 0, 0, r*2, r*2);
    // Let's add a line so we can see the rotation
    line(0,0,r,0);
    popMatrix();
  }
  
  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = d;
    fd.friction = 0.01;
    fd.restitution = 0.8;

    // Attach fixture to body
    body.createFixture(fd);

    body.setAngularVelocity(random(-10, 10));
  }
  
  void delete() {
    box2d.destroyBody(body);
    //file.play();
  }
  
  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.x > width) {
      delete();
      return true;
    }
    if (pos.x < 0) {
      delete();
      return true;
    }
    return false;
  }
  
  void change() {
    System.out.println("asdsada");
  }
  
  void applyForce(Vec2 force) {
    
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
  
}
