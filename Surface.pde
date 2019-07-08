class Surface {
  // Add a body 
  Body body;
  // Creat variable for width and height
  // x and y coordinate location will be set directly when defining the bodies position
  float w,h;
  
  Surface(float x, float y, float w, float h) {
    this.w = w;
    this.h = h;
    // Define body 
    BodyDef bd = new BodyDef();
    // Define type (STATIC: does not move)
    bd.type = BodyType.STATIC;
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
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body); 
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    noFill();
    noStroke();
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
  
}
