class Bacteria {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float angle = 0.0;
  float angVel = 0.0;
  float angAcc = 0.0;
  float size = 0.0;
  float sizeR = 0.0;
  float mass = 1.0;
  float lifespan = 255.0;
  
  int numFimb = 0;
  int maxFimbLen = 0;
  Fimbria[] fimbria = new Fimbria[numFimb];
  
  float lSpring = 0.001;
  float aSpring = 0.00001;
  
  Bacteria(PVector bPos, float bSize, int fNum, int maxLen) {
    
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = bPos.copy();
    size = bSize;
    sizeR = size * 0.5;
    mass = size / 10;
    lifespan = 255.0;
    
    numFimb = fNum;
    maxFimbLen = maxLen;
    fimbria = new Fimbria[numFimb];
    
    for (int i = 0; i < fimbria.length; i++) {
      fimbria[i] = new Fimbria(random(TWO_PI), random(maxFimbLen*0.8,maxFimbLen), sizeR, lifespan);
    }
    
  }
  
  void remakeFimbria() {
    
    size = random(10, 60);
    sizeR = size * 0.5;
    
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    angVel = 0.0;
    angAcc = 0.0;
    angle = 0.0;
    
    for (int i = 0; i < fimbria.length; i++) {
        fimbria[i] = new Fimbria(random(TWO_PI), random(maxFimbLen*0.8,maxFimbLen), sizeR, lifespan);
    }
    
  }
  
  void waveFim() {
    
    addNoise();
    
  }
  
  void addNoise() {
      
    float noiseT = random(100);
    float noiseFa = 0.0;
    float noiseFl = 0.0;
    float maxNoiseAng = 0.001;
    float maxNoiseLen = 0.15;
    
    for (int i = 0; i < fimbria.length; i++) {
      
      noiseT+=0.01;
      
      noiseFa = noise(noiseT);
      noiseFa = map(noiseFa, 0, 1, -maxNoiseAng, maxNoiseAng);
      fimbria[i].fimAng += noiseFa;
      
      noiseFl = noise(noiseT);
      noiseFl = map(noiseFl, 0, 1, -maxNoiseLen, maxNoiseLen);
      fimbria[i].fimLen += noiseFl;
      
      fimbria[i].update(angle);
      
    }
    
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void applyTorque(float force, float distance) {
    float t = (force * distance) / mass;
    angAcc += t;
  }
  
  void checkEdges() {

    if ((position.x + sizeR) > width) {
      position.x = width - sizeR;
      velocity.x *= -1;
    } else if (position.x - sizeR < 0) {
      velocity.x *= -1;
      position.x = 0 + sizeR;
    }

    if (position.y + sizeR > height) {
      velocity.y *= -1;
      position.y = height - sizeR;
    } else if (position.y - sizeR < 0) {
      velocity.y *= -1;
      position.y = 0 + sizeR;
    }

  }
  
  void checkTip() {

    //float fimLen;
    //float fimAng;
    //float cxPos;
    //float cyPos;
    //float txPos;
    //float tyPos;
    //float txPosNew = 0.0;
    //float tyPosNew = 0.0;
    PVector cellPos;
    //float life;
    
    cellPos = position;
    //life = lifespan;
    
    float newLen = 0.0;
    float newAng = 0.0;
    PVector tipForce = new PVector(0,0);
    float tipTorque = 0.0;
    float chanceSnag = random(100);
    float chanceGo = random(100);
    
    //boolean touched = false;
    //boolean snagged = false;
    
    for (int i = 0; i < fimbria.length; i++) {
      fimbria[i].touched = false;
      
      if (fimbria[i].txPos > width - cellPos.x) {
        fimbria[i].touched = true;
        fimbria[i].txPosNew = width - cellPos.x;
      } else if (fimbria[i].txPos < 0 - cellPos.x) {
        fimbria[i].touched = true;
        fimbria[i].txPosNew = 0 - cellPos.x;
      } else {
        fimbria[i].txPosNew = fimbria[i].txPos;
      }
      
      if (fimbria[i].tyPos > height - cellPos.y) {
        fimbria[i].touched = true;
        fimbria[i].tyPosNew = height - cellPos.y;
      } else if (fimbria[i].tyPos < 0 - cellPos.y) {
        fimbria[i].touched = true;
        fimbria[i].tyPosNew = 0 - cellPos.y;
      } else {
        fimbria[i].tyPosNew = fimbria[i].tyPos;
      }
      
      if (fimbria[i].touched) {
        lifespan = 255;
        tipForce = new PVector(fimbria[i].txPosNew, fimbria[i].tyPosNew);
        newLen = tipForce.mag();
        newAng = tipForce.heading();
        tipForce.mult(-lSpring);
        
        tipTorque = aSpring * (newAng - fimbria[i].fimAng);
        applyForce(tipForce);
        applyTorque(tipTorque, newLen);
      }
      //snagged = true;
      //if (chanceSnag > 15) {
      //  snagged = true;
      //}
    }
    
    //if (snagged) {
    //  tipForce = new PVector(txPosNew, tyPosNew);
    //  newLen = tipForce.mag();
    //  tipForce.normalize();
    //  tipForce.mult(lSpring * (newLen - fimLen));
    //  bacteria.applyForce(tipForce);
    //  if (chanceGo > 85) {
    //    snagged = false;
    //    txPos = cxPos + (fimLen * cos(fimAng));
    //    tyPos = cyPos + (fimLen * sin(fimAng));
    //  }
    //}
    
    //popMatrix();
  }
  
  // Method to update position
  void update() {
    
    angVel += angAcc;
    angVel *= 0.2;
    angle += (0.1 * angVel);
    angAcc = 0;
    lifespan -= 1.0;
    //pushMatrix();
    //rotate(angle);
    for (int i = 0; i < fimbria.length; i++) {
      fimbria[i].life = lifespan;
      fimbria[i].update(angle);
      checkTip();
    }
    velocity.add(acceleration);
    position.add(velocity);
    velocity.mult(0.99);
    acceleration.mult(0);
    //popMatrix();
  }
  
  // Method to display
  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(127, lifespan);
    ellipse(position.x, position.y, size, size);
    
    // Display fimbria
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);
    for (int i = 0; i < fimbria.length; i++) {
      fimbria[i].display();
    }
    popMatrix();
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
  
}