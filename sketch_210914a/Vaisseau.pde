class Vaisseau extends GraphicObject {
  float angularVelocity = 0.0;
  float angularAcceleration = 0.0;
  
  float angle = 0.0;  
  float heading = 0.0;
  
  float w = 20;
  float h = 10;
  float PointVX;
  float PointVY;
  
  float mass = 1.0;
  
  float speedLimit = 5;
  boolean thrusting = false;
  PVector VaisseauTip= new PVector();
  PVector shootingVector = new PVector();
  boolean isVisible = true;
  
  int vie =3;
  int bigRadius = 100;
  
  int diameter = 60;
  float radius = diameter/2;
  
  Vaisseau() {
    initValues();
  }
  
  void initValues() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  float getRadius(){
    return radius;
  }
  
  
  void applyForce (PVector force) {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);
  }
  
  void checkEdges() {
    if (location.x < -size) location.x = width + size;
    if (location.y < -size) location.y = height + size;
    if (location.x > width + size) location.x = -size;
    if (location.y > height + size) location.y = -size;
  }
  
  void thrust(){
    float angle = heading - PI/2;
    
    PVector force = new PVector (cos(angle), sin(angle));
    force.mult(0.1);
    
    applyForce(force);
    
    thrusting = true;    
  }
  
  PVector getLocation()
  {
    return location;
  }
  
  void update(float deltaTime) {
    checkEdges();
    
    velocity.add(acceleration);
    
    velocity.limit(speedLimit);
    
    location.add(velocity);
    
    acceleration.mult(0);
    
    angularVelocity += angularAcceleration;
    angle += angularVelocity;
    
    angularAcceleration = 0.0;
    
    //Ennemi
    
    
    
    //VaisseauTip.x= cos(heading-HALF_PI)*size+location.x;
    //VaisseauTip.y = sin(heading-HALF_PI)*size+location.y;
  }
  
  float size = 20;
  PVector getShiptip() {
    return new PVector(cos(heading-HALF_PI)*size+location.x, sin(heading-HALF_PI)*size+location.y);
  }
  PVector getShootingVector() {
    float angle = heading - PI/2;
    
    shootingVector = new PVector (cos(angle), sin(angle));
    shootingVector.normalize();
    return shootingVector;
  }
  
  void display() {
    pushMatrix();
      translate (location.x, location.y);
      rotate (heading);
      
      fill(200);
      noStroke();
      
      beginShape(TRIANGLES);
        vertex(0, -size);
        vertex(size, size);
        vertex(-size, size);
      endShape();
      
      if (thrusting) {
        fill(200, 0, 0);
      }
      rect(-size + (size/4), size, size / 2, size / 2);
      rect(size - ((size/4) + size/2), size, size / 2, size / 2);
      
    popMatrix();
  }
  
  void pivote(float angle) {
    heading += angle;
  }
  void addlife(){
    vie++;
  }
  void deleted()
  {
    if(1>vie)
    {
      setup();
      println("DEAD");
    }
    //isVisible =false;
    else{
      vie--;
    }
    
    
  }
  void noThrust() {
    thrusting = false;
  }
  void fire() {
  
  
    if (bullets.size() < maxBullets) {
      Projectile p = new Projectile();
      
      p.location = getShiptip().copy();
      p.topSpeed = 10;
      p.velocity = getShootingVector().copy().mult(p.topSpeed);
     
      p.activate();
      
      bullets.add(p);
      //println("piou pioi");
    } else {
      //println("bobobo");
      for ( Projectile p : bullets) {
        if (!p.isVisible) {
          p.location.x = getShiptip().x;
          p.location.y = getShiptip().y;
          p.velocity.x = getShootingVector().x;
          p.velocity.y = getShootingVector().y;
          p.velocity.mult(p.topSpeed);
          p.activate();
          break;
        }
      }
    }
    
  }
}
