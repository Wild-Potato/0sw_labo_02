class Level extends Mover {

int cLevel =1;
 
 Level(int flockSs){
  flockSize= flockSs;
  flock = new ArrayList<Mover>();
    for (int i = 0; i < flockSize; i++) {
    Mover m = new Mover(new PVector(random(0, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2))); 
    flock.add(m);
  }
  cLevel =1;
 }
 
 void isNextLevel(){
  
     flockSize+=5;
     v.location.x = width / 2;
    v.location.y = height / 2;
   flock = new ArrayList<Mover>();
    for (int i = 0; i < flockSize; i++) {
    Mover m = new Mover(new PVector(random(0, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2)));
     m.fillColor = color(0,255,0);
    flock.add(m);
       
 }
 cLevel++;
  
  
}
}
