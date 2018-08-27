Bacteria bacteria;
PVector p;
float bacSize = random(8, 25);
int fimNum = 60;
int maxFimLen = 30;

BacteriaSystem bs;

void setup() {
  size(800, 800);
  
  //bacteria = new Bacteria(p = new PVector(random(0, height), random(0, width)), 30, 60, 100);
  
  //bacteria = new Bacteria(p = new PVector(height/2, width/2), bacSize, fimNum, maxFimLen);
  
  bs = new BacteriaSystem();
  //bs.addBacteria(p = new PVector(random(0, height), random(0, width)), bacSize, fimNum, maxFimLen);
  
}

void keyPressed() {
  
  int keyDir = 0;
  
  switch (keyCode) {
    case UP:  
      //bacteria.applyForce(keyForce = new PVector(0,-1));
      keyDir = 0;
      break;
    case DOWN:  
      //bacteria.applyForce(keyForce = new PVector(0,1));
      keyDir = 1;
      break;
    case RIGHT:  
      //bacteria.applyForce(keyForce = new PVector(1,0));
      keyDir = 2;
      break;
    case LEFT:  
      //bacteria.applyForce(keyForce = new PVector(-1,0));
      keyDir = 3;
      break;
  }
  
  bs.keyed(keyDir);

}

void draw() {
  background(255);
  
  //PVector wind = new PVector(0.01,0);
  //PVector gravity = new PVector(0,0.1);
    
  //bacteria.applyForce(wind);
  //bacteria.applyForce(gravity);
  
  //bacteria.applyTorque(0.01, 1);
    
  //bacteria.velocity.add(0, 0.1);
  //bacteria.waveFim();
  
  //bacteria.update();
  //bacteria.display();
  //bacteria.checkEdges();
  
  bs.run();
    
  if (mousePressed) {
    bacSize = random(8, 25);
    
    //bs.mouseClick();
    bs.addBacteria(p = new PVector(mouseX, mouseY), bacSize, fimNum, maxFimLen);
    
  }
  
  
  
}