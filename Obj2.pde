class Obj2 {
  // Add a body 
  Body body;
  // Creat variable for width and height
  // x and y coordinate location will be set directly when defining the bodies position
  float x,y,w,h;
  BodyDef bd;
  PImage img;
  Obj2() {
    w = 40;
    h = 80;
    x = width/2;
    y = height - 55;
    //img = loadImage("baik.png");
    // Define body 
    bd = new BodyDef();
    // Define type (DYNAMIC: moves)
    bd.type = BodyType.DYNAMIC;
    // Set x and y coordinate
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    // Set the defined body with the specified w, h, x, and y 
    // to be an entity within box2d
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    
    ps.setAsBox(box2dW, box2dH);
    
    // Create fixture that will attach the shape to the body entity
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 0.1;
    fd.friction = 1;
    fd.restitution = 0.01;
    
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body); 
    //float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(-a);
    fill(255, 100, 255);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, w, h);
    //imageMode(CENTER);
    //image(img, 0, 0, w, h);
    popMatrix();
 
  }
  
  void destroy() {
    box2d.destroyBody(body);
  }
  
  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
}
