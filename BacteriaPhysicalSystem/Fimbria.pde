class Fimbria {
  
  float fimLen;
  float fimAng;
  float cxPos;
  float cyPos;
  float txPos;
  float tyPos;
  float txPosNew = 0.0;
  float tyPosNew = 0.0;
  float cellSize;
  float cellAngle = 0.0;
  float life;
  
  boolean touched = false;
  boolean snagged = false;
  
  Fimbria(float fAng, float fLen, float cSize, float die) {
    
    fimLen = fLen;
    fimAng = fAng;
    cellSize = cSize;
    life = die;
    cxPos = cellSize * cos(fimAng);
    cyPos = cellSize * sin(fimAng);
    txPos = cxPos + (fimLen * cos(fimAng));
    tyPos = cyPos + (fimLen * sin(fimAng));

  }
  
  void update(float cellAng) {
    
    cellAngle = cellAng;
    fimAng += cellAngle;
    
    cxPos = cellSize * cos(fimAng);
    cyPos = cellSize * sin(fimAng);
    txPos = cxPos + (fimLen * cos(fimAng));
    tyPos = cyPos + (fimLen * sin(fimAng));
    
  }
  
  void display() {
    
    //stroke(0);
    stroke(0, life);
    
    if (touched) {
      strokeWeight(2);
      line(cxPos, cyPos, txPosNew, tyPosNew);
      fill(255);
      strokeWeight(1);
      stroke(0, life);
      ellipse(txPosNew, tyPosNew, 5, 5);
    } else if (snagged) {
      strokeWeight(2);
      line(cxPos, cyPos, txPosNew, tyPosNew);
      fill(255);
      strokeWeight(1);
      stroke(0, life);
      ellipse(txPosNew, tyPosNew, 5, 5);
    }else {
      strokeWeight(1);
      line(cxPos, cyPos, txPos, tyPos);
      fill(0);
      strokeWeight(1);
      stroke(0, life);
      ellipse(txPos, tyPos, 3, 3);
    }
    
  }
  
}