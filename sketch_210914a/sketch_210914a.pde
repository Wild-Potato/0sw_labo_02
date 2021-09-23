int currentTime;
int previousTime;
int deltaTime;
ArrayList<Projectile> bullets;
int maxBullets = 6;
boolean saveVideo = false;
PImage bg;
Vaisseau v;
int point;

Level l;

//enemies
ArrayList<Mover> flock;
int flockSize = 300;
boolean debug = false;

int Thetime;
int TimeLife;
int enemieRestant;




//Collision
float distanceVM;
float distanceVP ;
float distanceMP ;

void playing(){
for (Mover m : flock ) {
  distanceVM = PVector.dist(v.getLocation(), m.getLocation());
  for (Projectile p : bullets) {
    
    distanceVP = PVector.dist(v.getLocation(), p.getLocation());
    distanceMP = PVector.dist(m.getLocation(), p.getLocation());
    //println(distanceVM);
    if((p.getRadius() + m.getRadius() >=distanceMP)  && m.isVisible && p.isVisible )
    {
      p.deleted();
      m.deleted();
      point++;

    } 
    if((v.getRadius() + m.getRadius() >=distanceVM)  && v.isVisible && m.isVisible )
    {   
      if(millis()>TimeLife +5000)
      {
        println("died");
        p.deleted();
        v.deleted();
      }
      m.deleted();
      //println("uDEAD");
    } 
    if((v.getRadius() + p.getRadius() >=distanceVP)  && p.isVisible  && v.isVisible)
    {
      //println("uShotURSELF");
      //p.deleted();
      if(millis()>Thetime +1000)
      {
        println("uShotURSELF");
        p.deleted();
        v.deleted();
      }
      
      
      
    } 
    
    
   
  }
}
}


void setup () {
  size (2000, 1334);
  currentTime = millis();
  previousTime = millis();
   bg = loadImage("SpaceBackground2.jpg");//2000, 1334
  v = new Vaisseau();
  v.location.x = width / 2;
  v.location.y = height / 2;
  v.vie=3;
  point=0;
  l = new Level(20);
  
  enemieRestant=0;
  bullets = new ArrayList<Projectile>();
  
    flock = new ArrayList<Mover>();
    for (int i = 0; i < flockSize; i++) {
    Mover m = new Mover(new PVector(random(0, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2)));
    m.fillColor = color(0,255,0);
    flock.add(m);
    Thetime= millis();
    TimeLife=millis();
  }

  flock.get(0).debug = true;
  
}

void render() {
  //background(0);
  
  
  for ( Projectile p : bullets) {
    p.display();
  }
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
   render();
  
  savingFrames(5, deltaTime);  
}

PVector thrusters = new PVector(0, -0.02);

/***
  The calculations should go here
*/
void update(int delta) {
  if(enemieRestant >= flockSize){
  l.isNextLevel();
  
  }
  //isNextLevel();
  playing();
  if(point>=25){
    point=0;
    v.vie++;
    }
  for ( Projectile p : bullets) {
    p.update(deltaTime);
  }
  for (Mover m : flock) {
    m.flock(flock);
    m.update(delta);
    
  }
  if (keyPressed) {
    switch (key) {
      case ' ':
        v.thrust();
        break;
      
      case 'd':
      v.pivote(.03);
      break;
      case 'a':
      v.pivote(-.03);
      break;
      case 'w':
      v.fire();
      Thetime = millis();
      
      break;
      case 'n':
      l.isNextLevel();
      break;
      
      //DEBUG
      case 's':
      flockSize++;
      
      
      case CODED:
       
        if (keyCode == LEFT) v.pivote(-.03);
        if (keyCode == RIGHT) v.pivote(.03);
        break;
    }
  }
  
  v.update(delta);
}

/***
  The rendering should go here
*/
void display () {
   background(bg); 
  for (Mover m : flock) {
    m.display();
  }
  v.display();
  fill(0,255,0);
  textSize(32);
  text(point + " points", 30, 40);
  
  fill(255,20,147);
  textSize(32);
  text(v.vie + " Vie", width - 90 , 40);
  
  fill(255,100,40);
  textSize(32);
  text("Level " + l.cLevel, (width / 2) - 40, 40);
 
  
}

//Saving frames for video
//Put saveVideo to true;
int savingAcc = 0;
int nbFrames = 0;

void savingFrames(int forMS, int deltaTime) {
  
  if (!saveVideo) return;
  
  savingAcc += deltaTime;
  
  if (savingAcc < forMS) {
    saveFrame("frames/####.tiff");
  nbFrames++;
  } else {
  println("Saving frames done! " + nbFrames + " saved");
    saveVideo = false;
  }
}



void keyReleased() {
    switch (key) {
      case ' ':
        v.noThrust();
        break;
        case 'r':
        setup();
        
        break;
    }  
}

////TIRER
