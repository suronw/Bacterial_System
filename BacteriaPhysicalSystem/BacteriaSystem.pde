class BacteriaSystem {
  
  ArrayList<Bacteria> bacterias;
  
  PVector p;
  float bacSize = random(8, 40);
  int fimNum = 60;
  int maxFimLen = 30;

  
  BacteriaSystem() {
    
    bacterias = new ArrayList<Bacteria>();
    
    //bacteria = new Bacteria(p = new PVector(random(0, height), random(0, width)), 30, 60, 100);
    //bacterias.add(new Bacteria(p = new PVector(random(0,height), random(0, width)), bacSize, fimNum, maxFimLen));
    bacterias.add(new Bacteria(p = new PVector(height/2, width/2), bacSize, fimNum, maxFimLen));
    
  }
  
  void addBacteria(PVector bacPos, float bacSize, int fimNum, int maxFimLen) {
    bacterias.add(new Bacteria(bacPos, bacSize, fimNum, maxFimLen));
  }
  
  void mouseClick() {
    for (Bacteria bacteria : bacterias) {
      bacteria.remakeFimbria();
      bacteria.lifespan = 255;
      
      //bacteria = new Bacteria(p = new PVector(random(0, height), random(0, width)), 30, 60, 100);
      //PVector mp = new PVector(mouseX, mouseY);
      //PVector warp = new PVector(mp.x - bacteria.position.x, mp.y - bacteria.position.y);
      //warp.normalize();
      //warp.mult(1.1);
      //bacteria.applyForce(warp);
      //bacteria.angVel = map(mouseX,0,width, -0.01,0.01);
      //bacteria.waveFim();
    }
  }
  
  void keyed(int dir) {
      
    PVector keyForce;
    
    switch (dir) {
      case (0):  //up
        keyForce = new PVector(0,-1);
        for (Bacteria bacteria : bacterias) {
          bacteria.applyForce(keyForce);
          break;
        }
      case (1):  //down
        keyForce = new PVector(0,1);
        for (Bacteria bacteria : bacterias) {
          bacteria.applyForce(keyForce);
          break;
        }
      case (2):  //right
        keyForce = new PVector(1,0);
        for (Bacteria bacteria : bacterias) {
          bacteria.applyForce(keyForce);
          break;
        }
      case (3):  //left
        keyForce = new PVector(-1,0);
        for (Bacteria bacteria : bacterias) {
          bacteria.applyForce(keyForce);
          break;
        }
    }
  }
  
  void run() {
    
    //Bacteria bacteria = bacterias.get(0);
    for (Bacteria bacteria : bacterias) {
        bacteria.update();
        bacteria.display();
        bacteria.checkEdges();
      }
      
    for (int i = bacterias.size() - 1; i >= 0; i--) {
      Bacteria bact = bacterias.get(i);
      if (bact.isDead()) {
        bacterias.remove(i);
      }
    }
      
      //PVector wind = new PVector(0.01,0);
      //PVector gravity = new PVector(0,0.1);
      //bacteria.applyForce(wind);
      //bacteria.applyForce(gravity);
      //bacteria.applyTorque(0.01, 1);
      //bacteria.velocity.add(0, 0.1);
      //bacteria.waveFim();
    

  }
  
}