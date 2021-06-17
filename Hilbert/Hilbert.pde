int order = 3;
int totalPoints = round(pow(4, order));
int cols = totalPoints/4;
int colSize;

PVector[] points = new PVector[totalPoints];

void setup() {
  size(600, 600);
  colSize = int(width/cols);
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();
  
  beginShape();
  for (int i = 0; i < order * order; i++) {
    PVector curr = hindexToxy(i, order);
    vertex(curr.x * colSize, curr.y * colSize);
  }
  endShape();
  
}

PVector hindexToxy(int hindex, int N) {
  PVector[] curve = {
    new PVector(0, 0), 
    new PVector(0, 1), 
    new PVector(1, 1), 
    new PVector(1, 0)
  };

  PVector tmp = curve[lastTwoBits(hindex)];
  hindex = (hindex >>> 2);

  float x = tmp.x;
  float y = tmp.y;
  float tmp2;

  for (int n = 4; n <= N; n*= 2) {
    int n2 = n/2;

    switch(lastTwoBits(hindex)) {
    case 0:
      tmp2 = x; 
      x = y; 
      y = tmp2;
      break;
    case 1:
      y += n2;
      break;
    case 2:
      x += n2;
      y += n2;
      break;
    case 3:
      tmp2 = y;
      y = (n2 - 1) - x;
      x = (n2 - 1) - tmp2;
      x += n2;
      break;
    }
    
    hindex = (hindex >>> 2);
  }

  return new PVector(x, y);
}

int lastTwoBits(int n) {
  return (n & 3);
}
