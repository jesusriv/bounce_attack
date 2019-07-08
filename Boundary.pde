class Boundary {
  Body body;

  float x,y,w,h;

  Boundary(float x, float y, float w, float h) {
    this.w = w;
    this.h = h;
    
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);
    
    body.createFixture(ps,1);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body); 
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(100, 255, 0);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, w, h);
    popMatrix();
  }
}
