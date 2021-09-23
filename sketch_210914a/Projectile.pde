class Projectile extends GraphicObject {
  boolean isVisible = false;
  int diameter = 3;
  float radius = diameter/ 2;
  
  Projectile () {
    super();
  }
  
  void activate() {
    isVisible = true;
  }
  
  void setDirection(PVector v) {
    velocity = v;
  }
  
  PVector getLocation()
  {
    return location;
  }
  void deleted()
   {
     isVisible=false;
   }
  void update(float deltaTime) {
    
    if (!isVisible) return;
    
    super.update();
    
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
      isVisible = false;
    }
  }
  float getRadius(){
    return radius;
  }
  
  void display() {
    
    if (isVisible) {
      pushMatrix();
        translate (location.x, location.y);
        fill(0,255,0);
        //println("Hello there");
        ellipse (0, 0, 10, 10);
      popMatrix();
    }
  }
}
